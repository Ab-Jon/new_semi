import 'package:flutter/material.dart';

class TwoFAVerificationScreen extends StatefulWidget {
  const TwoFAVerificationScreen({super.key});

  @override
  State<TwoFAVerificationScreen> createState() =>
      _TwoFAVerificationScreenState();
}

class _TwoFAVerificationScreenState extends State<TwoFAVerificationScreen> {
  final List<String> _otp = List.filled(6, "");

  void _onKeyTap(String value) {
    for (int i = 0; i < 6; i++) {
      if (_otp[i].isEmpty) {
        setState(() => _otp[i] = value);
        return;
      }
    }
  }

  void _onBackspace() {
    for (int i = 5; i >= 0; i--) {
      if (_otp[i].isNotEmpty) {
        setState(() => _otp[i] = "");
        return;
      }
    }
  }

  String get code => _otp.join();

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "2FA Verification",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: isLight ? Colors.black : Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // ===== TITLE + DESCRIPTION =====
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Security Verification",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Enter the 6-digit verification code that was sent to\n"
                      "unw****@gmail.com. Its valid for 10 minutes",
                  style: TextStyle(
                    fontSize: 13,
                    color: isLight ? Colors.black : Colors.white,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // ===== OTP BOXES =====
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(6, (index) {
              return Container(
                height: 48,
                width: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(6),
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Text(
                  _otp[index],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          // ===== RESEND TIMER =====
          const Text(
            "Resend code in 41s",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 30),
          // ===== SUBMIT BUTTON =====
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLight
                      ? const Color(0xFF2B124C)
                      : const Color(0xFF632AAE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {},
            child: Text(
              "Didn’t receive the email verification code? Resend",
              style: TextStyle(
                color: isLight
                    ? const Color(0xFF2B124C)
                    : const Color(0xFF632AAE),
                fontSize: 13,
              ),
            ),
          ),
          const Spacer(),
          // ===== CUSTOM KEYPAD =====
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                _buildKeypadRow(["1", "2", "3"]),
                const SizedBox(height: 12),
                _buildKeypadRow(["4", "5", "6"]),
                const SizedBox(height: 12),
                _buildKeypadRow(["7", "8", "9"]),
                const SizedBox(height: 12),
                _buildKeypadRow(["", "0", "back"]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeypadRow(List<String> values) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: values.map((value) {
        if (value == "back") {
          return _keyCell(
            child: const Icon(Icons.backspace_outlined),
            onTap: _onBackspace,
          );
        } else if (value.isEmpty) {
          return _keyCell(child: const SizedBox());
        } else {
          return _keyCell(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () => _onKeyTap(value),
          );
        }
      }).toList(),
    );
  }

  Widget _keyCell({required Widget child, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 58,
        width: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: child,
      ),
    );
  }
}
