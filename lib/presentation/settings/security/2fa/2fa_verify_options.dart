import 'package:flutter/material.dart';
import 'package:semi_bill/presentation/settings/security/2fa/2fa_verify.dart';

class TwoFAVerificationOptionsPage extends StatelessWidget {
  const TwoFAVerificationOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("2FA Verification"),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose Security Method",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Select your preferred security method below",
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            _sectionHeader("Passkey"),
            _twoFAOption(
              icon: Icons.phone_android,
              title: "Mobile",
              description: "Use other means of verification to perform transactions.",
              onTap: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => TwoFAVerificationScreen()));
              },
              context: context
            ),

            _sectionHeader("2FA Via Authenticator App"),
            _twoFAOption(
              icon: Icons.shield_outlined,
              title: "Google Authenticator",
              description: "Verify using a verification code generated via Google Authenticator.",
              onTap: () {},
              context: context
            ),

            _sectionHeader("2FA Via SMS"),
            _twoFAOption(
              icon: Icons.sms_outlined,
              title: "SMS",
              description: "You will receive verification codes via text message.",
              onTap: () {},
              context: context
            ),

            _sectionHeader("2FA Via Email"),
            _twoFAOption(
              icon: Icons.email_outlined,
              title: "Email",
              description: "Verification codes will be sent to your email.",
              onTap: () {},
              context: context
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 20),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _twoFAOption({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: isLight
                  ? const Color(0xFF2B124C)
                  : const Color(0xFF632AAE), size: 26),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          height: 45,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: isLight ? const Color(0xFF2B124C) : const Color(0xFF632AAE), // light purple
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Proceed",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
