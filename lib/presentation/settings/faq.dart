import 'package:flutter/material.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/ui/semi_ui.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  final items = const [
    ('How do I fund my wallet?', 'Use Deposit on Home or Wallet, then follow the bank transfer instructions.'),
    ('How long do withdrawals take?', 'Most withdrawals settle within minutes after PIN confirmation.'),
    ('Can I buy airtime for someone else?', 'Yes. Open Buy Airtime, change the number, then pay with your wallet.'),
    ('How does crowdfunding work?', 'Create or join a campaign, then donate from your crowdfunding wallet.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FAQ')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SemiCard(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search questions',
                prefixIcon: Icon(Icons.search, color: context.brand),
                filled: true,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SemiCard(
                child: ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  childrenPadding: const EdgeInsets.only(bottom: 8),
                  title: Text(item.$1, style: const TextStyle(fontWeight: FontWeight.w700)),
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(item.$2, style: TextStyle(color: context.semi.muted)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
