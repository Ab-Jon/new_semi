import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:semi_bill/presentation/settings/security/reset_password.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/ui/semi_ui.dart';

class ResetPinScreen extends StatefulWidget {
  const ResetPinScreen({super.key});

  @override
  State<ResetPinScreen> createState() => _ResetPinScreenState();
}

class _ResetPinScreenState extends State<ResetPinScreen> {
  final otpController = TextEditingController();
  final newPinController = TextEditingController();
  final confirmPinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    otpController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    otpController.dispose();
    newPinController.dispose();
    confirmPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final valid = otpController.text.isNotEmpty &&
        newPinController.text.length == 4 &&
        confirmPinController.text == newPinController.text;

    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        backgroundColor: context.pageBg,
        leading: const SemiBackButton(),
        title: const Text('Change PIN'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          const Text('OTP (Sent to your email address)', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          SemiField(
            controller: otpController,
            hint: 'Enter OTP',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          const Text('New Pin', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          TextField(
            controller: newPinController,
            obscureText: true,
            keyboardType: TextInputType.number,
            maxLength: 4,
            onChanged: (_) => setState(() {}),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(hintText: 'Enter 4 digit Pin', counterText: ''),
          ),
          const SizedBox(height: 16),
          const Text('Confirm Pin', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          TextField(
            controller: confirmPinController,
            obscureText: true,
            keyboardType: TextInputType.number,
            maxLength: 4,
            onChanged: (_) => setState(() {}),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(hintText: 'Enter 4 digit Pin', counterText: ''),
          ),
          const SizedBox(height: 48),
          SemiButton(
            label: 'Change PIN',
            onPressed: valid ? () => showPasswordResetSuccess(context) : null,
          ),
        ],
      ),
    );
  }
}
