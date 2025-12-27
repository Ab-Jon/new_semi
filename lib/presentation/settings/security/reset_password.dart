import 'package:flutter/material.dart';

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

  void checkPassword(String value) {
    setState(() {
      hasMin8 = value.length >= 8;
      hasNumber = RegExp(r'\d').hasMatch(value);
      hasLower = RegExp(r'[a-z]').hasMatch(value);
      hasSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);

      final score = [
        hasMin8,
        hasNumber,
        hasLower,
        hasSpecial,
      ].where((v) => v).length;

      strength = score / 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text("Change Login Password"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel("OTP (Sent to your email address)"),
            _buildInput(otpController, "Enter OTP"),

            _buildLabel("Current Password"),
            _buildPassword(currentPasswordController, "Enter current password", obscure1, () {
              setState(() => obscure1 = !obscure1);
            }),

            _buildLabel("New Password"),
            _buildPassword(newPasswordController, "Enter new password", obscure2, () {
              setState(() => obscure2 = !obscure2);
            }, onChanged: checkPassword),

            _buildLabel("Confirm Password"),
            _buildPassword(confirmPasswordController, "Confirm new password", obscure3, () {
              setState(() => obscure3 = !obscure3);
            }),

            const SizedBox(height: 20),
            _buildStrengthBox(),

            const SizedBox(height: 30),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, top: 16),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildInput(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: _inputDecoration(hint),
    );
  }

  Widget _buildPassword(
      TextEditingController controller,
      String hint,
      bool obscure,
      VoidCallback toggle, {
        Function(String)? onChanged,
      }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      onChanged: onChanged,
      decoration: _inputDecoration(hint).copyWith(
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
          onPressed: toggle,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: isLight ? Colors.white54 : Colors.black54,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  Widget _buildStrengthBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinearProgressIndicator(
            value: strength,
            minHeight: 6,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation(
              strength <= 0.25
                  ? Colors.red
                  : strength <= 0.5
                  ? Colors.orange
                  : Colors.green,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _rule("Min 8 characters", hasMin8),
              _rule("At least 1 number", hasNumber),
              _rule("1 Special Character", hasSpecial),
              _rule("1 Lowercase character", hasLower),
            ],
          )
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
          color: condition ? Colors.green : Colors.grey,
        ),
        const SizedBox(width: 6),
        Text(text),
      ],
    );
  }

  Widget _buildButton() {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final isEnabled = otpController.text.isNotEmpty &&
        currentPasswordController.text.isNotEmpty &&
        newPasswordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        newPasswordController.text == confirmPasswordController.text &&
        strength > 0.5;

    return ElevatedButton(
      onPressed: isEnabled ? () {
        showPasswordResetSuccess(context);
      } : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isLight
            ? const Color(0xFF2B124C)
            : const Color(0xFF632AAE),
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: const Text("Change Password"),
    );
  }
}


void showPasswordResetSuccess(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.4),
    builder: (_) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                // The tiny centered dot
                Text(
                  '•',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.grey.shade400,
                  ),
                ),
                const SizedBox(height: 12),

                // Title
                const Text(
                  "Login Reset Successful",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 8),

                // Subtitle
                const Text(
                  "You have successfully updated your login password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 32),

                // Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Color(0xFF2B124C),
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Close modal
                      Navigator.pop(context); // Navigate back to login
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

