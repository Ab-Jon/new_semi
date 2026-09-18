import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semi_bill/Auth/verify/verify_otp.dart';
import 'package:semi_bill/ui/semi_ui.dart';
import '../../bvn/bvn_provider.dart';
import '../../bvn/bvn_verification.dart';

class BvnInputScreen extends ConsumerWidget {
  BvnInputScreen({super.key});

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<BvnVerificationState>(bvnProvider, (previous, next) {
      if (previous?.otpId == null && next.otpId != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const VerifyCodeScreen()),
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
      appBar: AppBar(title: const Text('BVN Verification')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SemiAuthHeader(
              lead: 'Verify ',
              accent: 'BVN',
              subtitle: 'We use your BVN to protect withdrawals and raise limits.',
            ),
            const SizedBox(height: 28),
            SemiField(
              controller: _controller,
              label: 'Enter BVN',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            SemiButton(
              label: 'Continue',
              loading: state.loading,
              onPressed: () {
                ref.read(bvnProvider.notifier).submitBvn(_controller.text.trim());
              },
            ),
          ],
        ),
      ),
    );
  }
}
