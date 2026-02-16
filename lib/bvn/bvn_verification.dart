class BvnVerificationState {
  late final bool loading;
  final String? otpId;
  final String? bvn;
  final String? verificationId;
  final bool otpVerified;
  final String? error;
  final bool canResendOtp;
  final int resendCountdown;


  BvnVerificationState({
    this.loading = false,
    this.otpId,
    this.bvn,
    this.verificationId,
    this.otpVerified = false,
    this.error,
    this.canResendOtp = false,
    this.resendCountdown = 60,
  });

  BvnVerificationState copyWith({
    bool? loading,
    String? otpId,
    String? bvn,
    String? verificationId,
    bool? otpVerified,
    String? error,
    bool? canResendOtp,
    int? resendCountdown,
  }) {
    return BvnVerificationState(
      loading: loading ?? this.loading,
      otpId: otpId ?? this.otpId,
      bvn: bvn ?? this.bvn,
      verificationId: verificationId ?? this.verificationId,
      otpVerified: otpVerified ?? this.otpVerified,
      error: error,
      canResendOtp: canResendOtp ?? this.canResendOtp,
      resendCountdown: resendCountdown ?? this.resendCountdown,
    );
  }
}
