import 'package:flutter/material.dart';
import 'package:semi_bill/Auth/verify/verify_bvn.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/ui/semi_ui.dart';

class AccountVerificationPage extends StatelessWidget {
  const AccountVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account Verification')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SemiCard(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: context.brand.withValues(alpha: 0.12),
                  child: Icon(Icons.verified_outlined, color: context.brand),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('KYC status', style: TextStyle(fontWeight: FontWeight.w800)),
                      SizedBox(height: 4),
                      Text('Complete BVN verification to unlock higher limits.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SemiCard(
            padding: EdgeInsets.zero,
            child: SemiListTile(
              icon: Icons.badge_outlined,
              title: 'Verify BVN',
              subtitle: 'Required for withdrawals',
              showDivider: false,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => BvnInputScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
