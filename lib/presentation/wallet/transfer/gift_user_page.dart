import 'package:flutter/material.dart';
import 'package:semi_bill/presentation/wallet/transfer/widget/amount_button.dart';
import 'package:semi_bill/presentation/wallet/transfer/widget/gift_summary.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/ui/semi_ui.dart';

class GiftUserPage extends StatefulWidget {
  const GiftUserPage({super.key});

  @override
  State<GiftUserPage> createState() => _GiftUserPageState();
}

class _GiftUserPageState extends State<GiftUserPage> {
  final TextEditingController recipientController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  bool remainAnonymous = false;
  int? selectedAmount;
  final List<int> presetAmounts = [50, 100, 200, 500, 1000];

  @override
  void dispose() {
    recipientController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        backgroundColor: context.pageBg,
        leading: const SemiBackButton(),
        title: const Text('Gift User'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/gift_banner.jpg',
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(height: 140, color: context.iconWash),
            ),
          ),
          const SizedBox(height: 20),
          const Text("Recipient's ID", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          SemiField(controller: recipientController, hint: "Enter recipient's number"),
          const SizedBox(height: 16),
          const Text('Description', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          TextField(
            controller: messageController,
            maxLines: 4,
            decoration: const InputDecoration(hintText: 'Write a message'),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Checkbox(
                value: remainAnonymous,
                activeColor: context.brand,
                onChanged: (value) => setState(() => remainAnonymous = value ?? false),
              ),
              const Text('Remain Anonymous'),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Amount to pay', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: presetAmounts.map((amount) {
              return AmountButton(
                amount: amount,
                selected: selectedAmount == amount,
                onTap: () => setState(() => selectedAmount = amount),
              );
            }).toList(),
          ),
          const SizedBox(height: 28),
          SemiButton(
            label: 'Gift a User',
            onPressed: selectedAmount == null
                ? null
                : () {
                    GiftSummarySheet.show(
                      context,
                      amount: selectedAmount!,
                      recipientId: recipientController.text.trim(),
                      message: messageController.text.trim(),
                      anonymous: remainAnonymous,
                    );
                  },
          ),
        ],
      ),
    );
  }
}
