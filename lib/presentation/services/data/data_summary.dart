import 'package:flutter/material.dart';
import '../../wallet/transfer/widget/pin_screen.dart';

class DataSummaryScreen extends StatelessWidget {
  final int amount;
  final String phone;
  final String network;

  const DataSummaryScreen({
    super.key,
    required this.amount,
    required this.phone,
    required this.network,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(title: const Text('Airtime Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Product: Airtime'),
                    const SizedBox(height: 8),
                    Text('Amount: N$amount'),
                    const SizedBox(height: 8),
                    Text('Charged fees: N20.00'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet_outlined),
              title: const Text('Wallet'),
              subtitle: const Text('₦150.00'),
              trailing: TextButton(
                onPressed: () {
                  //Todo Add money functionality
                },
                child: const Text('Add Money'),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLight
                      ? const Color(0xFF2B124C)
                      : const Color(0xFF632AAE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Show PIN sheet from helpers
                  PaymentHelpers.showPinSheet(context, amount: amount);
                },
                child: Text(
                  'Pay N$amount',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
