import 'package:flutter/material.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/ui/semi_ui.dart';

class DeviceSessionPage extends StatelessWidget {
  const DeviceSessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sessions = [
      ('iPhone 13 • Lagos', 'This device • Active now', true),
      ('Chrome • Windows', 'Last seen 2 hours ago', false),
      ('Samsung A54', 'Last seen yesterday', false),
    ];
    return Scaffold(
      appBar: AppBar(leading: const SemiBackButton(), title: const Text('Device & Session')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Devices signed into your SEMIBILL account.',
            style: TextStyle(color: context.semi.muted),
          ),
          const SizedBox(height: 16),
          SemiCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                for (var i = 0; i < sessions.length; i++)
                  SemiListTile(
                    icon: Icons.phone_iphone,
                    title: sessions[i].$1,
                    subtitle: sessions[i].$2,
                    showDivider: i != sessions.length - 1,
                    trailing: sessions[i].$3
                        ? Text('Current', style: TextStyle(color: context.brand, fontWeight: FontWeight.w700))
                        : TextButton(onPressed: () {}, child: const Text('Sign out')),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SemiButton(label: 'Sign out of all devices', onPressed: () {}),
        ],
      ),
    );
  }
}
