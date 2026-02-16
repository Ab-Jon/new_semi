import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;
import '../../bvn/bvn_provider.dart';
import '../../Auth/providers/auth_token_provider.dart';
import 'create_wallet_state.dart';

final createWalletProvider =
StateNotifierProvider<CreateWalletNotifier, CreateWalletState>(
      (ref) => CreateWalletNotifier(ref),
);

class CreateWalletNotifier extends StateNotifier<CreateWalletState> {
  final Ref ref;

  CreateWalletNotifier(this.ref) : super(const CreateWalletState());

  Future<void> createWallet({
    required String phone,
    required String bvn,
    required String otp,
  }) async {
    final bvnState = ref.read(bvnProvider);

    if (bvnState.verificationId == null) {
      state = state.copyWith(error: "BVN verification session missing");
      return;
    }

    state = state.copyWith(loading: true, error: null);

    try {
      final response = await http.post(
        Uri.parse("https://app.semibill.com/api/create_bank_wallet"),
        headers: {
          "Authorization": "Bearer ${ref.read(authTokenProvider)}",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {
          "phone": phone,
          "no": bvnState.verificationId!, // 🔥 VERY IMPORTANT
          "bvn": bvn,
          "otp": otp,
        },
      );

      if (kDebugMode) {
        print("WALLET CREATE: ${response.statusCode}");
        print("WALLET CREATION: ${response.body}");
        print({
          "phone": phone,
          "bvn": bvn,
          "otp": otp,
          "no": bvnState.verificationId,
        });
      }

      final decoded = jsonDecode(response.body);

      String? backendError;
      if (decoded['data'] is String) {
        backendError = decoded['data'];
      } else if (decoded['data'] is Map) {
        backendError =
            decoded['data']['response']?['message'] ??
                decoded['data']['error'];
      }
      backendError ??= decoded['message'];

      if (response.statusCode != 200 || decoded['code'] != 200) {
        throw Exception(backendError ?? "Wallet creation failed");
      }

      if (decoded["code"] == 200) {
        state = state.copyWith(
          loading: false,
          success: true,
        );
      } else {
        throw Exception(decoded["message"] ?? "Unknown error");
      }
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: e.toString(),
      );
    }
  }
}
