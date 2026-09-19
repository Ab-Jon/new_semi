import 'package:flutter/material.dart';
import 'package:semi_bill/presentation/settings/security/2fa/2fa_verify.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/ui/ionicons.dart';
import 'package:semi_bill/ui/semi_ui.dart';

class TwoFAVerificationOptionsPage extends StatelessWidget {
  const TwoFAVerificationOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        backgroundColor: context.pageBg,
        leading: const SemiBackButton(),
        title: const Text('2FA Verification'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
        children: [
          const Text('Choose Security Method', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(
            'Select your preferred security method below',
            style: TextStyle(fontSize: 13, color: context.semi.muted),
          ),
          const SizedBox(height: 8),
          _section('Passkey'),
          _option(
            context,
            icon: Ionicons.phone_portrait_outline,
            title: 'Mobile',
            description: 'Use other means of verification to perform transactions.',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const TwoFAVerificationScreen()));
            },
          ),
          _section('2FA Via Authenticator App'),
          _option(
            context,
            icon: Ionicons.shield_checkmark_outline,
            title: 'Google Authenticator',
            description: 'Verify using a verification code generated via Google Authenticator.',
            onTap: () {},
          ),
          _section('2FA Via SMS'),
          _option(
            context,
            icon: Ionicons.chatbubble_outline,
            title: 'SMS',
            description: 'You will receive verification codes via text message.',
            onTap: () {},
          ),
          _section('2FA Via Email'),
          _option(
            context,
            icon: Ionicons.mail_outline,
            title: 'Email',
            description: 'Verification codes will be sent to your email.',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _section(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 18),
      child: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
    );
  }

  Widget _option(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        SemiCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(color: context.iconWash, shape: BoxShape.circle),
                child: Icon(icon, color: context.iconTint, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(description, style: TextStyle(fontSize: 12, color: context.semi.muted, height: 1.4)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SemiButton(label: 'Proceed', onPressed: onTap),
      ],
    );
  }
}
