import 'package:flutter/material.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/ui/semi_ui.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms & Conditions')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SemiCard(
            child: Text(
              'By using SEMIBILL you agree to keep your PIN private, confirm recipient details before transfers, and follow Nigerian KYC rules. Bill payments, tickets, and crowdfunding are processed through your wallet balances. We may pause a transaction if we detect unusual activity.',
              style: TextStyle(height: 1.5, color: context.semi.muted),
            ),
          ),
        ],
      ),
    );
  }
}
