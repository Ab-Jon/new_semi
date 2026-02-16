import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../bvn/bvn_provider.dart';
import '../../bvn/bvn_verification.dart';
import '../create_wallet/create_wallet.dart';

class VerifyCodeScreen extends ConsumerStatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  ConsumerState<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends ConsumerState<VerifyCodeScreen> {
  static const int codeLength = 6;

  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  bool _hasNavigated = false; // 🚨 prevents double navigation

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(codeLength, (_) => TextEditingController());
    _focusNodes = List.generate(codeLength, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    super.dispose();
  }

  void _submitOtp() {
    final otp = _controllers.map((c) => c.text).join();
    if (otp.length != codeLength) return;

    ref.read(bvnProvider.notifier).verifyOtp(otp);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bvnProvider);

    /// 🔥 SAFE LISTENER
    ref.listen<BvnVerificationState>(bvnProvider, (prev, next) {
      // ✅ NAVIGATE ON SUCCESS (ONCE)
      if (!_hasNavigated && next.otpVerified == true) {
        _hasNavigated = true;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const CreateWallet()),
          );
        });
      }

      // ❌ ERROR HANDLING
      if (prev?.error != next.error &&
          next.error != null &&
          next.error!.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(next.error!)),
          );
        });
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Enter OTP",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 30),

                /// OTP BOXES
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    codeLength,
                        (index) => _buildOtpBox(index),
                  ),
                ),

                const SizedBox(height: 40),

                if (state.loading) const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 48,
      height: 58,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) {
          if (value.isEmpty) return;

          if (index < codeLength - 1) {
            _focusNodes[index + 1].requestFocus();
          } else {
            _focusNodes[index].unfocus();
            _submitOtp(); // 🚀 AUTO SUBMIT
          }
        },
      ),
    );
  }
}
