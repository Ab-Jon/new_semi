import 'package:flutter/material.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/ui/semi_ui.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const SemiBackButton(), title: const Text('Support')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'We’re here 24/7',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(
            'Reach the SEMIBILL team through any of these channels.',
            style: TextStyle(color: context.semi.muted),
          ),
          const SizedBox(height: 20),
          SemiCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                SemiListTile(
                  icon: Icons.chat_bubble_outline,
                  title: 'Live chat',
                  subtitle: 'Get help inside the app',
                  onTap: () {},
                ),
                SemiListTile(
                  icon: Icons.email_outlined,
                  title: 'Email',
                  subtitle: 'support@semibill.com',
                  onTap: () {},
                ),
                SemiListTile(
                  icon: Icons.phone_outlined,
                  title: 'Call us',
                  subtitle: '+234 800 000 0000',
                  showDivider: false,
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _social(context, 'assets/icons/whatsapp.png', 'WhatsApp'),
              _social(context, 'assets/icons/instagram.png', 'Instagram'),
              _social(context, 'assets/icons/facebook.png', 'Facebook'),
              _social(context, 'assets/icons/telegram.png', 'Telegram'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _social(BuildContext context, String asset, String label) {
    return Column(
      children: [
        Container(
          height: 52,
          width: 52,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Image.asset(asset, width: 28, height: 28),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
