import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import '../../themes/app_theme.dart';

class WalletDepositSheet {
  static void show(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // top icon
              CircleAvatar(
                radius: 28,
                backgroundColor: isLight
                    ? const Color(0xFFF3EDFF)
                    : const Color(0xFF2A1A44),
                child: Icon(
                  Icons.savings_outlined,
                  color: isLight ? const Color(0xFF2B124C) : const Color(0xFF632AAE),
                  size: 26,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                "Deposit only clean funds to the account number below",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 15),

              // Account Number
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "804356788",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.copy, size: 22, color: isLight
                        ? const Color(0xFF2B124C)
                        : const Color(0xFF632AAE)),
                    onPressed: () {
                      Clipboard.setData(const ClipboardData(text: "804356788"));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Account number copied"),
                          backgroundColor: Theme.of(context).colorScheme.surface,
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Bank info box
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Bank",
                          style: TextStyle(
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.account_balance,
                              size: 18,
                              color: isLight
                                  ? const Color(0xFF2B124C)
                                  : const Color(0xFF632AAE),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "Access Bank",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Account Name",
                          style: TextStyle(
                          ),
                        ),
                        Text(
                          "Engr Unwana",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Warning Items
              Wrap(
                runSpacing: 6,
                spacing: 12,
                children: const [
                  WarningItem("Say No To Fraud"),
                  WarningItem("Say No to Corruption"),
                  WarningItem("Say No to Terrorism Financing"),
                  WarningItem("Say No to Financial Crime"),
                  WarningItem("Say No to Money Laundering"),
                ],
              ),

              const SizedBox(height: 25),

              // Share Button
              SizedBox(
                width: double.infinity,
                height: 48,
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
                    final message =
                    """Send money to:
                    Bank: Access Bank
                    Account Number: 804356788
                    Account Name: Engr Unwana
                    """;
                    Share.share(message, subject: "Deposit Details");
                  },
                  child: const Text("Share"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class WarningItem extends StatelessWidget {
  final String text;
  const WarningItem(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.circle, color: Colors.red, size: 8),
        const SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
