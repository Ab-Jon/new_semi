import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semi_bill/Auth/verify/verify_otp.dart';
import '../../bvn/bvn_provider.dart';
import '../../bvn/bvn_verification.dart';
import 'package:flutter/material.dart';

class BvnInputScreen extends ConsumerWidget {
  final _controller = TextEditingController();

  BvnInputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<BvnVerificationState>(bvnProvider, (previous, next) {
      // Navigate ONLY when otpId changes from null → value
      if (previous?.otpId == null && next.otpId != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const VerifyCodeScreen(),
            ),
          );
        });
      }

      if (previous?.error != next.error &&
          next.error != null &&
          next.error!.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(next.error!)));
        });
      }
    });

    final state = ref.watch(bvnProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("BVN Verification")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Enter BVN"),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: state.loading
                  ? null
                  : () {
                ref
                    .read(bvnProvider.notifier)
                    .submitBvn(_controller.text.trim());
              },
              child: state.loading
                  ? const CircularProgressIndicator()
                  : const Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}
