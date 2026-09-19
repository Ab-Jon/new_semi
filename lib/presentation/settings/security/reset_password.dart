import 'package:flutter/material.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/ui/semi_ui.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final otpController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  double strength = 0.0;
  bool hasMin8 = false;
  bool hasNumber = false;
  bool hasLower = false;
  bool hasSpecial = false;
  bool obscure1 = true;
  bool obscure2 = true;
  bool obscure3 = true;

  @override
  void initState() {
    super.initState();
    otpController.addListener(() => setState(() {}));
    currentPasswordController.addListener(() => setState(() {}));
    confirmPasswordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    otpController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void checkPassword(String value) {
    setState(() {
      hasMin8 = value.length >= 8;
      hasNumber = RegExp(r'\d').hasMatch(value);
      hasLower = RegExp(r'[a-z]').hasMatch(value);
      hasSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
      final score = [hasMin8, hasNumber, hasLower, hasSpecial].where((v) => v).length;
      strength = score / 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = otpController.text.isNotEmpty &&
        currentPasswordController.text.isNotEmpty &&
        newPasswordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        newPasswordController.text == confirmPasswordController.text &&
        strength > 0.5;

    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        backgroundColor: context.pageBg,
        leading: const SemiBackButton(),
        title: const Text('Change Login Password'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          const Text('OTP (Sent to your email address)', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          SemiField(controller: otpController, hint: 'Enter OTP', keyboardType: TextInputType.number),
          const SizedBox(height: 16),
          const Text('Current Password', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          SemiField(
            controller: currentPasswordController,
            hint: 'Enter current password',
            obscure: obscure1,
            onToggleObscure: () => setState(() => obscure1 = !obscure1),
          ),
          const SizedBox(height: 16),
          const Text('New Password', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          TextField(
            controller: newPasswordController,
            obscureText: obscure2,
            onChanged: checkPassword,
            decoration: InputDecoration(
              hintText: 'Enter new password',
              suffixIcon: IconButton(
                icon: Icon(obscure2 ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                onPressed: () => setState(() => obscure2 = !obscure2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Confirm Password', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          SemiField(
            controller: confirmPasswordController,
            hint: 'Confirm new password',
            obscure: obscure3,
            onToggleObscure: () => setState(() => obscure3 = !obscure3),
          ),
          const SizedBox(height: 20),
          SemiCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: strength,
                    minHeight: 6,
                    backgroundColor: context.iconWash,
                    color: strength <= 0.25
                        ? SemiColors.danger
                        : strength <= 0.5
                            ? Colors.orange
                            : SemiColors.success,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _rule('Min 8 characters', hasMin8),
                    _rule('At least 1 number', hasNumber),
                    _rule('1 Special Character', hasSpecial),
                    _rule('1 Lowercase character', hasLower),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          SemiButton(
            label: 'Change Password',
            onPressed: isEnabled ? () => showPasswordResetSuccess(context) : null,
          ),
        ],
      ),
    );
  }

  Widget _rule(String text, bool condition) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          condition ? Icons.check_circle : Icons.radio_button_unchecked,
          size: 18,
          color: condition ? SemiColors.success : context.semi.muted,
        ),
        const SizedBox(width: 6),
        Text(text),
      ],
    );
  }
}

void showPasswordResetSuccess(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 320,
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
            decoration: BoxDecoration(
              color: context.cardColor,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Login Reset Successful', textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Text(
                  'You have successfully updated your login password',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: context.semi.muted, height: 1.4),
                ),
                const SizedBox(height: 24),
                SemiButton(
                  label: 'Sign In',
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
