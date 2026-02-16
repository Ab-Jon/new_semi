import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../auth_api.dart';
import 'dio_provider.dart';

final verifyApiProvider = Provider<AuthApi>((ref) {
  final dio = ref.read(dioProvider);
  return AuthApi(dio);
});

final verificationIdProvider = StateProvider<String?>((ref) => null);

final verifyAccountProvider = StateNotifierProvider<VerifyAccountNotifier, AsyncValue<void>>(
      (ref) => VerifyAccountNotifier(ref),
);

class VerifyAccountNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  VerifyAccountNotifier(this.ref) : super(const AsyncData(null));

  // STEP 1
  Future<void> initializeBVN(String bvn) async {
    state = const AsyncLoading();
    try {
      final response = await ref.read(verifyApiProvider).initializeVerify(bvn: bvn);

      final id = response.data['data']['id'];

      if (kDebugMode) {
        print("BVN VERIFY ID: $id");
      }

      ref.read(verificationIdProvider.notifier).state = id;

      state = const AsyncData(null);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  // STEP 2
  Future<void> verifyOTp(String otp) async {
    state = const AsyncLoading();
    try {
      final id = ref.read(verificationIdProvider);

      if (id == null) {
        state = AsyncError("Verification not initialized", StackTrace.current);
        return;
      }

      if (kDebugMode) {
        print("VERIFY OTP PAYLOAD → id: $id, otp: $otp");
      }

      await ref.read(verifyApiProvider).verifyOtp(
        id: id,
        otp: otp, // keep as STRING
      );

      state = const AsyncData(null);
    } on DioException catch (e) {
      if (kDebugMode) {
        print("OTP VERIFY STATUS: ${e.response?.statusCode}");
        print("OTP VERIFY DATA: ${e.response?.data}");
      }
      state = AsyncError(e, StackTrace.current);
    }
  }
}
