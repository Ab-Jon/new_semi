import 'package:flutter/material.dart';
import 'package:semi_bill/presentation/wallet/transfer/widget/pin_screen.dart';

class GiftSummarySheet {
  static void show(
      BuildContext context, {
        required int amount,
        required String recipientId,
        required String message,
        required bool anonymous,
      }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black26,
      builder: (context) {
        final theme = Theme.of(context);
        final isLight = Theme.of(context).brightness == Brightness.light;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top icon
              CircleAvatar(
                radius: 26,
                backgroundColor: isLight
                    ? const Color(0xFF2B124C)
                    : const Color(0xFF632AAE),
                child: Icon(Icons.card_giftcard, color: isLight
                    ? const Color(0xFF2B124C)
                    : const Color(0xFF632AAE), size: 26),
              ),
              const SizedBox(height: 12),
              // Amount Text
              Text(
                "₦$amount.00",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 20),

              // Summary section
              _summaryRow(
                context,
                label: "Product Name",
                value: "Betting",
              ),
              const SizedBox(height: 12),
              _summaryRow(
                context,
                label: "Amount",
                value: "₦$amount.00",
              ),
              const SizedBox(height: 12),
              _summaryRow(
                context,
                label: "Charged Fees",
                value: "₦0.00",
              ),

              const SizedBox(height: 20),

              // Wallet Balance
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.surface,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.account_balance_wallet_outlined, size: 20),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Wallet (₦150.00)",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Total Balance",
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      "Add Money",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Pay Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isLight
                        ? const Color(0xFF2B124C)
                        : const Color(0xFF632AAE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    // Open PIN screen
                    PaymentHelpers.showPinSheet(context, amount: amount
                    );
                  },
                  child: Text("Pay ₦$amount"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Reusable summary item
  static Widget _summaryRow(BuildContext context,
      {required String label, required String value}) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
              fontSize: 14,
            )),
        Text(value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            )),
      ],
    );
  }
}
