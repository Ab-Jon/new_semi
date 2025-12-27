import 'package:flutter/material.dart';

void showWithdrawalSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const WithdrawalBottomSheet(),
  );
}

class WithdrawalBottomSheet extends StatelessWidget {
  const WithdrawalBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 25),
          /// Floating Icon
          PositionedIcon(),

          const SizedBox(height: 10),

          /// Close button aligned right
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, size: 26,  color: isLight
                      ? const Color(0xFF2B124C)
                      : const Color(0xFF632AAE),),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          /// Amount Title
          const Text(
            "₦2,000.00",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 25),
          /// INFORMATION SECTION
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                infoRow(
                  label: "Bank",
                  valueWidget: Row(
                    children: [
                      Icon(Icons.account_balance, size: 18, color: isLight
                          ? const Color(0xFF2B124C)
                          : const Color(0xFF632AAE)),
                      SizedBox(width: 8),
                      Text("Access Bank"),
                    ],
                  ),
                ),
                infoRow(
                  label: "Account Number",
                  value: "2115456788",
                ),
                infoRow(
                  label: "Recipient Name",
                  value: "Engr Unwana",
                ),
                const SizedBox(height: 18),

                amountRow("Amount", "₦2,000.00"),
                amountRow("Charged Fees", "₦20.00"),
                amountRow("Recipient receive", "₦1980.00", bold: true),
                const SizedBox(height: 25),
                /// WALLET SECTION
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                       Icon(Icons.account_balance_wallet_outlined, color: isLight
                          ? const Color(0xFF2B124C)
                          : const Color(0xFF632AAE),),
                      const SizedBox(width: 12),

                      const Text(
                        "Wallet (₦150.00)",
                        style: TextStyle(fontSize: 16),
                      ),

                      const Spacer(),

                      Text(
                        "Add Money",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(width: 6),
                      Icon(Icons.chevron_right,
                          color: isLight
                              ? const Color(0xFF2B124C)
                              : const Color(0xFF632AAE)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          /// PAY BUTTON
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLight
                      ? const Color(0xFF2B124C)
                      : const Color(0xFF632AAE),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Pay 16,000",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
  /// Reusable row for top info section
  Widget infoRow({required String label, String? value, Widget? valueWidget}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle( fontSize: 14),
            ),
          ),
          valueWidget ??
              Text(
                value ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
        ],
      ),
    );
  }

  /// Reusable row for amount section
  Widget amountRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// Floating circular icon like UI
class PositionedIcon extends StatelessWidget {
  const PositionedIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isLight
            ? const Color(0xFF2B124C)
            : const Color(0xFF632AAE),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Icon(Icons.swap_vert, color: Colors.white),
    );
  }
}
