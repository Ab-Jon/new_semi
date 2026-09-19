import 'package:flutter/material.dart';
import 'package:semi_bill/presentation/settings/security/2fa/2fa_verify_options.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/ui/semi_ui.dart';

class TwoFactorIntroPage extends StatelessWidget {
  const TwoFactorIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.pageBg,
        leading: const SemiBackButton(),
        title: const Text(
          "2FA Verification",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            /// --- IMAGE ---
            Center(
              child: Image.asset(
                "assets/2fa.jpg",
                height: 200,
              ),
            ),
            const SizedBox(height: 40),
            /// --- TITLE ---
            const Text(
              "Two Factor Authentication",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                height: 1.4,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            /// --- DESCRIPTION ---
            const Text(
              "Add extra security to your Sembill account to prevent unauthorized transactions.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Color(0xff7d7d7d),
              ),
            ),
            const Spacer(),
            /// --- BUTTON ---
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TwoFAVerificationOptionsPage()));
                },
                child: const Text(
                  "Proceed to Set Up",
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
