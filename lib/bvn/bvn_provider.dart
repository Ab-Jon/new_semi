import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;

import '../Auth/providers/auth_token_provider.dart';
import 'bvn_verification.dart';

final bvnProvider =
StateNotifierProvider<BvnNotifier, BvnVerificationState>(
      (ref) => BvnNotifier(ref),
);

class BvnNotifier extends StateNotifier<BvnVerificationState> {
  final Ref ref;
  BvnNotifier(this.ref) : super(BvnVerificationState());


  // Resend OTP.. Will be completed when it is accommodated in the backend
  Timer? _resendTimer;

  void startResendTimer() {
    _resendTimer?.cancel();

    state = state.copyWith(
      canResendOtp: false,
      resendCountdown: 60,
    );
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.resendCountdown == 0) {
        timer.cancel();
        state = state.copyWith(canResendOtp: true);
      } else {
        state = state.copyWith(
          resendCountdown: state.resendCountdown - 1,
        );
      }
    });
  }
  Future<void> resendOtp() async {
    try {
      state = state.copyWith(loading: true, error: null);

      // 🔁 CALL YOUR RESEND OTP API
      //await bvnRepository.resendOtp();

      startResendTimer();

      state = state.copyWith(
        loading: false,
        error: "OTP resent successfully",
      );
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: "Failed to resend OTP. Try again.",
      );
    }
  }


    // BVN INITIALIZATION
  Future<void> submitBvn(String bvn) async {
    state = state.copyWith(loading: true, error: null);

    try {
      final response = await http.post(
        Uri.parse('https://app.semibill.com/api/initialize-verify'),
        headers: {
          'Authorization': 'Bearer ${ref.read(authTokenProvider)}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'type': 'bvn',
          'number': bvn,
        },
      );

      if (kDebugMode) {
        print("BVN INIT STATUS: ${response.statusCode}");
        print("BVN INIT BODY: ${response.body}");
      }

      if (response.statusCode != 200) {
        throw Exception("BVN verification failed");
      }

      final decoded = jsonDecode(response.body);

      final data = decoded['data']?['data'];
      if (data == null) {
        throw Exception("Invalid BVN response structure");
      }

      state = state.copyWith(
        loading: false,
        otpId: data['otpId'],
        verificationId: data['_id'],
        bvn: data['identityNumber'],
        otpVerified: data['otpVerified'] ?? false,
      );

      if (kDebugMode) {
        print("✅ BVN INIT SUCCESS → OTP SENT");
        print("OTP ID: ${data['otpId']}");
      }
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: e.toString(),
      );

      if (kDebugMode) {
        print("❌ BVN INIT ERROR: $e");
      }
    }
  }

  // =======================
  // OTP VERIFICATION
  // =======================
  Future<void> verifyOtp(String otp) async {
    if (state.verificationId == null) {
      state = state.copyWith(
        error: "OTP session expired. Please retry BVN verification.",
      );
      return;
    }

    state = state.copyWith(loading: true, error: null);

    try {
      final response = await http.post(
        Uri.parse('https://app.semibill.com/api/verify-otp'),
        headers: {
          'Authorization': 'Bearer ${ref.read(authTokenProvider)}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'type': 'bvn',
          'id': state.verificationId!,
          'otp': otp,
        },
      );

      if (kDebugMode) {
        print("OTP VERIFY STATUS: ${response.statusCode}");
        print("OTP VERIFY BODY: ${response.body}");
      }

      if (response.statusCode != 200) {
        throw Exception("OTP verification failed");
      }

      final decoded = jsonDecode(response.body);
      final verified = decoded['data']?['data']?['otpVerified'];

      if (verified == true) {
        state = state.copyWith(
          loading: false,
          otpVerified: true,
        );

        if (kDebugMode) {
          print("✅ OTP VERIFIED SUCCESSFULLY");
        }
      } else {
        throw Exception("Invalid OTP");
      }
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: e.toString(),
      );

      if (kDebugMode) {
        print("❌ OTP VERIFY ERROR: $e");
      }
    }
  }
}
