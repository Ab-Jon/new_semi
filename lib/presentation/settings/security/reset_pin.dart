import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:semi_bill/presentation/settings/security/reset_password.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Change PIN",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label("OTP (Sent to your email address)"),
            _cardField(
              child: _input(
                controller: otpController,
                hint: "Enter OTP",
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 18),

            _label("New Pin"),
            _cardField(
              child: _input(
                controller: newPinController,
                hint: "Enter 4 digit Pin",
                keyboardType: TextInputType.number,
                maxLength: 4,
                obscure: true,
              ),
            ),
            const SizedBox(height: 18),

            _label("Confirm Pin"),
            _cardField(
              child: _input(
                controller: confirmPinController,
                hint: "Enter 4 digit Pin",
                keyboardType: TextInputType.number,
                maxLength: 4,
                obscure: true,
              ),
            ),

            const SizedBox(height: 80),
            _button(),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _cardField({required Widget child}) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isLight ? Colors.white54 : Colors.black54,
        ),
      ),
      child: child,
    );
  }

  Widget _input({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    bool obscure = false,
    int? maxLength,
  }) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      maxLength: maxLength,
      inputFormatters: [
        if (keyboardType == TextInputType.number)
          FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        hintText: hint,
        counterText: "",
        filled: true,
        fillColor: isLight ? Colors.white54 : Colors.black54,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 14,
        ),
      ),
    );
  }

  Widget _button() {
    final valid = otpController.text.isNotEmpty &&
        newPinController.text.length == 4 &&
        confirmPinController.text == newPinController.text;
    final isLight = Theme.of(context).brightness == Brightness.light;
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: valid ? () {
          showPasswordResetSuccess(context);
        } : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isLight
              ? const Color(0xFF2B124C)
              : const Color(0xFF632AAE),
          disabledBackgroundColor: Colors.grey.shade400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          "Change PIN",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.white
          ),
        ),
      ),
    );
  }
}
