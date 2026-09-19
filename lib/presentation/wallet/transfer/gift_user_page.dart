import 'package:flutter/material.dart';
import 'package:semi_bill/presentation/wallet/transfer/widget/amount_button.dart';
import 'package:semi_bill/presentation/wallet/transfer/widget/gift_summary.dart';
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
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: const SemiBackButton(),
        title: const Text("Gift User"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // --- Banner ---
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                image: const DecorationImage(
                  image: AssetImage("assets/images/gift_banner.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // --- Recipient ID ---
            Text("Recipient's ID",
                style: TextStyle(fontSize: 13)),
            const SizedBox(height: 6),

            TextField(
              controller: recipientController,
              decoration: InputDecoration(
                hintText: "Enter recipient's number",
                filled: true,
                fillColor: theme.colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // --- Message ---
            Text("Description",
                style: TextStyle(fontSize: 13)),
            const SizedBox(height: 6),

            TextField(
              controller: messageController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Write a message",
                filled: true,
                fillColor: theme.colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // --- Anonymous checkbox ---
            Row(
              children: [
                Checkbox(
                  value: remainAnonymous,
                  onChanged: (value) {
                    setState(() => remainAnonymous = value!);
                  },
                ),
                Text(
                  "Remain Anonymous",
                  style: TextStyle(),
                )
              ],
            ),

            const SizedBox(height: 10),

            // --- Amount section ---
            Text("Amount to pay",
                style: TextStyle(fontSize: 13)),
            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: presetAmounts.map((amount) {
                return AmountButton(
                  amount: amount,
                  selected: selectedAmount == amount,
                  onTap: () {
                    setState(() => selectedAmount = amount);
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 30),

            // --- Gift Button ---
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLight
                      ? const Color(0xFF2B124C)
                      : const Color(0xFF632AAE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: selectedAmount == null
                    ? null
                    : () {
                  // open summary sheet (next step)
                  GiftSummarySheet.show(context, amount: selectedAmount!, recipientId: recipientController.text.trim(), message: messageController.text.trim(), anonymous: remainAnonymous);
                },
                child: const Text(
                  "Gift a User",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
