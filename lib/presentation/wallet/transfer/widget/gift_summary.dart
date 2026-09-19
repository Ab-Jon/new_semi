import 'package:flutter/material.dart';
import 'package:semi_bill/presentation/wallet/transfer/widget/pin_screen.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/ui/ionicons.dart';
import 'package:semi_bill/ui/semi_ui.dart';

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
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(color: context.iconWash, shape: BoxShape.circle),
                child: Icon(Ionicons.gift_outline, color: context.brand, size: 26),
              ),
              const SizedBox(height: 12),
              Text(
                '₦$amount.00',
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 20),
              _row('Product Name', 'Gift User'),
              const SizedBox(height: 12),
              _row('Recipient', recipientId.isEmpty ? '—' : recipientId),
              const SizedBox(height: 12),
              _row('Amount', '₦$amount.00'),
              const SizedBox(height: 12),
              _row('Charged Fees', '₦0.00'),
              if (anonymous) ...[
                const SizedBox(height: 12),
                _row('Visibility', 'Anonymous'),
              ],
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: context.isDark ? SemiColors.surfaceDark : const Color(0xFFF6F4FA),
                ),
                child: Row(
                  children: [
                    Icon(Ionicons.wallet_outline, size: 20, color: context.brand),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Wallet (₦24,100.00)', style: TextStyle(fontWeight: FontWeight.w600)),
                          Text('Total Balance', style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                        ],
                      ),
                    ),
                    Text('Add Money', style: TextStyle(fontWeight: FontWeight.w700, color: context.brand)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SemiButton(
                label: 'Pay ₦$amount',
                onPressed: () {
                  Navigator.pop(context);
                  PaymentHelpers.showPinSheet(context, amount: amount);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget _row(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14)),
        Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
