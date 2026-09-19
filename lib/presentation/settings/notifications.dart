import 'package:flutter/material.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/ui/semi_ui.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool loginAlert = true;
  bool transactionAlert = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        backgroundColor: context.pageBg,
        leading: const SemiBackButton(),
        title: const Text('Notification'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 24),
        children: [
          SemiGroupCard(
            children: [
              _alertRow(
                title: 'Login Alert',
                value: loginAlert,
                onChanged: (v) => setState(() => loginAlert = v),
              ),
              Divider(height: 1, indent: 16, endIndent: 16, color: context.hairline),
              _alertRow(
                title: 'Transaction Alerts',
                value: transactionAlert,
                onChanged: (v) => setState(() => transactionAlert = v),
                showDivider: false,
              ),
            ],
          ),
          const SizedBox(height: 28),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Notification preferences saved')),
                  );
                },
                child: const Text('Save Changes'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _alertRow({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    bool showDivider = true,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 12, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: context.iconWash,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Email',
                  style: TextStyle(
                    color: context.brand,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
              const Spacer(),
              Switch.adaptive(
                value: value,
                activeTrackColor: SemiColors.brand,
                onChanged: onChanged,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
