import 'package:flutter/material.dart';
import 'package:semi_bill/presentation/settings/security/2fa/2fa_auth.dart';
import 'package:semi_bill/presentation/settings/security/reset_password.dart';
import 'package:semi_bill/presentation/settings/security/reset_pin.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/ui/ionicons.dart';
import 'package:semi_bill/ui/semi_ui.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool biometricEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        backgroundColor: context.pageBg,
        leading: const SemiBackButton(),
        title: const Text('Security'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 24),
        children: [
          SemiGroupCard(
            children: [
              SemiMenuRow(
                icon: Ionicons.lock_closed_outline,
                title: 'Change login Password',
                onTap: () => _openSheet(context, const _ResetLoginPasswordSheet()),
              ),
              SemiMenuRow(
                icon: Ionicons.notifications_outline,
                title: 'Change transaction PIN',
                onTap: () => _openSheet(context, const _ResetPinSheet()),
              ),
              SemiMenuRow(
                icon: Ionicons.lock_closed_outline,
                title: 'Change Security PIN',
                onTap: () => _openSheet(context, const _ResetPinSheet()),
              ),
              SemiMenuRow(
                icon: Ionicons.person_outline,
                title: 'Biometric Lock',
                trailing: Switch.adaptive(
                  value: biometricEnabled,
                  activeTrackColor: SemiColors.brand,
                  onChanged: (value) {
                    setState(() => biometricEnabled = value);
                    if (value) showBiometricSheet(context);
                  },
                ),
                onTap: () => showBiometricSheet(context),
              ),
              SemiMenuRow(
                icon: Ionicons.finger_print_outline,
                title: '2FA Authentication',
                showDivider: false,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TwoFactorIntroPage()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _openSheet(BuildContext context, Widget sheet) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => sheet,
    );
  }
}

class _ResetLoginPasswordSheet extends StatelessWidget {
  const _ResetLoginPasswordSheet();

  @override
  Widget build(BuildContext context) {
    return _VerifyCodeSheet(
      title: 'Reset Login Password',
      onContinue: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ChangePasswordScreen()),
        );
      },
    );
  }
}

class _ResetPinSheet extends StatelessWidget {
  const _ResetPinSheet();

  @override
  Widget build(BuildContext context) {
    return _VerifyCodeSheet(
      title: 'Reset Transaction PIN',
      onContinue: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ResetPinScreen()),
        );
      },
    );
  }
}

class _VerifyCodeSheet extends StatelessWidget {
  const _VerifyCodeSheet({
    required this.title,
    required this.onContinue,
  });

  final String title;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const SizedBox(width: 36),
                  const Spacer(),
                  Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      color: context.iconWash,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Ionicons.lock_closed, color: context.brand, size: 26),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, size: 22),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: context.isDark
                      ? SemiColors.surfaceDark
                      : SemiColors.lavenderSoft,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 4,
                      height: 48,
                      decoration: BoxDecoration(
                        color: SemiColors.brand,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Enter the 6-digit verification code that was sent to unw****@gmail.com. Its valid for 10 minutes',
                        style: TextStyle(fontSize: 14, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: onContinue,
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showBiometricSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return Container(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Spacer(),
                Container(
                  height: 48,
                  width: 48,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF6B2FD8), Color(0xFF9B6FD8)],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Ionicons.lock_closed, color: Colors.white, size: 22),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, size: 22),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Enable Biometric',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Divider(color: context.hairline),
            const SizedBox(height: 24),
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: context.iconWash,
                shape: BoxShape.circle,
              ),
              child: Icon(Ionicons.finger_print, size: 44, color: context.brand),
            ),
            const SizedBox(height: 20),
            const Text(
              'Security Verification',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Text(
              'Access your account easily when opening the app. Tap the Finger icon to save your biometric.',
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 1.4,
                fontSize: 13,
                color: context.semi.muted,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      );
    },
  );
}
