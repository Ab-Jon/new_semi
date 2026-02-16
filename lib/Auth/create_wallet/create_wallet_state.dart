class CreateWalletState {
  final bool loading;
  final String? error;
  final bool success;

  const CreateWalletState({
    this.loading = false,
    this.error,
    this.success = false,
  });

  CreateWalletState copyWith({
    bool? loading,
    String? error,
    bool? success,
  }) {
    return CreateWalletState(
      loading: loading ?? this.loading,
      error: error,
      success: success ?? this.success,
    );
  }
}
