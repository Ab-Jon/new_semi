import 'package:flutter/material.dart';
import 'package:semi_bill/presentation/settings/account_verification.dart';
import 'package:semi_bill/presentation/settings/device_session.dart';
import 'package:semi_bill/presentation/settings/faq.dart';
import 'package:semi_bill/presentation/settings/notifications.dart';
import 'package:semi_bill/presentation/settings/security.dart';
import 'package:semi_bill/presentation/settings/support.dart';
import 'package:semi_bill/presentation/settings/terms_conditions.dart';
import 'package:semi_bill/presentation/settings/update_profile.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/themes/theme_provider.dart';
import 'package:semi_bill/ui/semi_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeProvider);
    return Scaffold(
      backgroundColor: context.pageBg,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text(
              'Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SemiCard(
                child: Row(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            'assets/avatar_1.jpg',
                            height: 56,
                            width: 56,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 18,
                            width: 18,
                            decoration: BoxDecoration(
                              color: context.brand,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.person, size: 12, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Boss Unwana',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'ubokobong@gmail.com',
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SemiCard(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: SwitchListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  title: const Text('Dark mode', style: TextStyle(fontWeight: FontWeight.w600)),
                  value: mode == ThemeMode.dark ||
                      (mode == ThemeMode.system &&
                          MediaQuery.platformBrightnessOf(context) == Brightness.dark),
                  onChanged: (value) {
                    ref.read(themeProvider.notifier).state =
                        value ? ThemeMode.dark : ThemeMode.light;
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SemiCard(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListView(
                    children: [
                      SemiListTile(
                        icon: Icons.shield_outlined,
                        title: 'Security',
                        onTap: () => _open(context, const SecurityScreen()),
                      ),
                      SemiListTile(
                        icon: Icons.notifications_outlined,
                        title: 'Notifications',
                        onTap: () => _open(context, const NotificationSettingsPage()),
                      ),
                      SemiListTile(
                        icon: Icons.verified_outlined,
                        title: 'Account Verification',
                        onTap: () => _open(context, const AccountVerificationPage()),
                      ),
                      SemiListTile(
                        icon: Icons.person_outline,
                        title: 'Update Profile',
                        onTap: () => _open(context, const UpdateProfileScreen()),
                      ),
                      SemiListTile(
                        icon: Icons.support_agent_outlined,
                        title: 'Support',
                        onTap: () => _open(context, const SupportScreen()),
                      ),
                      SemiListTile(
                        icon: Icons.devices_other_outlined,
                        title: 'Device & Session',
                        onTap: () => _open(context, const DeviceSessionPage()),
                      ),
                      SemiListTile(
                        icon: Icons.help_outline,
                        title: 'FAQ',
                        onTap: () => _open(context, const FaqPage()),
                      ),
                      SemiListTile(
                        icon: Icons.description_outlined,
                        title: 'Terms & Condition',
                        showDivider: false,
                        onTap: () => _open(context, const TermsConditionsPage()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 110),
          ],
        ),
      ),
    );
  }

  void _open(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }
}
