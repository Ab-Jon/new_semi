import 'package:flutter/material.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/ui/ionicons.dart';
import 'package:semi_bill/ui/semi_ui.dart';
import 'confirm_withdrawal.dart';

class WithdrawalScreen extends StatelessWidget {
  const WithdrawalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        leading: const SemiBackButton(),
        title: const Text('Withdrawal'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Ionicons.time_outline, color: context.brand),
          ),
        ],
        backgroundColor: context.pageBg,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
        children: [
          Text('Available', style: TextStyle(fontSize: 13, color: context.semi.muted), textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Text('₦450,000.00', style: TextStyle(fontSize: 13, color: context.semi.muted), textAlign: TextAlign.center),
          const SizedBox(height: 10),
          const Text(
            '₦2,000',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, letterSpacing: -0.4),
          ),
          const SizedBox(height: 18),
          SemiCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Recipient Account', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                const TextField(
                  decoration: InputDecoration(hintText: 'Enter 10 digits Account Number'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    color: context.isDark ? SemiColors.surfaceDark : const Color(0xFFF6F4FA),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Image.asset('assets/zenith.png', height: 22, errorBuilder: (_, __, ___) => Icon(Ionicons.card_outline, color: context.brand, size: 20)),
                      const SizedBox(width: 10),
                      const Expanded(child: Text('Zenith Bank', style: TextStyle(fontWeight: FontWeight.w600))),
                      Icon(Icons.chevron_right, color: context.iconTint),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: context.brand,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: const Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.white, size: 20),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Chikwado Ugochukwu Augustine',
                          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                const Text('Remark', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                const TextField(
                  decoration: InputDecoration(hintText: 'Enter Description (What is this for)'),
                  minLines: 1,
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                SemiButton(
                  label: 'Proceed Withdrawal',
                  onPressed: () {
                    WithdrawalFlow.showSummary(context, amount: 5000);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SemiCard(
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(color: context.iconWash, borderRadius: BorderRadius.circular(12)),
                  child: Icon(Ionicons.pulse_outline, color: context.brand),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Real-time Bank Monitor', style: TextStyle(fontWeight: FontWeight.w600)),
                      Text('Confirm the strength of the bank', style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: context.iconTint),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SemiCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select Beneficiary', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search beneficiary',
                    prefixIcon: Icon(Ionicons.search_outline, color: context.brand),
                  ),
                ),
                const SizedBox(height: 8),
                _beneficiary(context, 'Jose Mourinho', 'Providus Bank - 6567554567'),
                Divider(color: context.hairline),
                _beneficiary(context, 'Jose Mourinho', 'Providus Bank - 6567554567'),
                Divider(color: context.hairline),
                _beneficiary(context, 'Jose Mourinho', 'Providus Bank - 6567554567'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _beneficiary(BuildContext context, String name, String subtitle) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const SemiAvatar(size: 44),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: TextStyle(color: context.semi.muted, fontSize: 12)),
      onTap: () {},
    );
  }
}
