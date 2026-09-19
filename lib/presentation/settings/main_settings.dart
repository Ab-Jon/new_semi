import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
import 'package:semi_bill/ui/ionicons.dart';
import 'package:semi_bill/ui/semi_ui.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeProvider);
    final isDark = mode == ThemeMode.dark ||
        (mode == ThemeMode.system &&
            MediaQuery.platformBrightnessOf(context) == Brightness.dark);

    return Scaffold(
      backgroundColor: context.pageBg,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),
            SizedBox(
              height: 44,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Text(
                    'Settings',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Positioned(
                    right: 8,
                    child: IconButton(
                      tooltip: 'Theme',
                      onPressed: () {
                        ref.read(themeProvider.notifier).state =
                            isDark ? ThemeMode.light : ThemeMode.dark;
                      },
                      icon: Icon(
                        isDark ? Ionicons.sunny_outline : Ionicons.moon_outline,
                        size: 20,
                        color: context.semi.muted,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Stack(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/avatar_1.jpg',
                          height: 52,
                          width: 52,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: Container(
                          height: 18,
                          width: 18,
                          decoration: BoxDecoration(
                            color: context.cardColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: context.cardColor, width: 1.5),
                          ),
                          child: Icon(
                            Ionicons.camera_outline,
                            size: 10,
                            color: context.brand,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Boss Unwana',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'ubokobong@gmail.com',
                          style: TextStyle(
                            fontSize: 13,
                            color: SemiColors.brand,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 120),
                children: [
                  SemiGroupCard(
                    children: [
                      SemiMenuRow(
                        icon: Ionicons.shield_outline,
                        title: 'Security',
                        onTap: () => _open(context, const SecurityScreen()),
                      ),
                      SemiMenuRow(
                        icon: Ionicons.notifications_outline,
                        title: 'Notifications',
                        onTap: () => _open(context, const NotificationSettingsPage()),
                      ),
                      SemiMenuRow(
                        icon: Ionicons.shield_checkmark_outline,
                        title: 'Account Verification',
                        onTap: () => _open(context, const AccountVerificationPage()),
                      ),
                      SemiMenuRow(
                        icon: Ionicons.person_outline,
                        title: 'Update Profile',
                        onTap: () => _open(context, const UpdateProfileScreen()),
                      ),
                      SemiMenuRow(
                        icon: Ionicons.headset_outline,
                        title: 'Support',
                        onTap: () => _open(context, const SupportScreen()),
                      ),
                      SemiMenuRow(
                        icon: Ionicons.phone_portrait_outline,
                        title: 'Device & Session',
                        onTap: () => _open(context, const DeviceSessionPage()),
                      ),
                      SemiMenuRow(
                        icon: Ionicons.help_circle_outline,
                        title: 'FAQ',
                        onTap: () => _open(context, const FaqPage()),
                      ),
                      SemiMenuRow(
                        icon: Ionicons.document_text_outline,
                        title: 'Terms & Condition',
                        showDivider: false,
                        onTap: () => _open(context, const TermsConditionsPage()),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _open(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }
}
