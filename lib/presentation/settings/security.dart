import 'package:flutter/material.dart';
import 'package:semi_bill/presentation/settings/security/2fa/2fa_auth.dart';
import 'package:semi_bill/presentation/settings/security/reset_password.dart';
import 'package:semi_bill/presentation/settings/security/reset_pin.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
  }

  class _SecurityScreenState extends State<SecurityScreen> {
  bool biometricEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text('Security'),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSettingItem(
            context: context,
            icon: Icons.security,
            title: 'Change Login Password',
            onTap: () => _openResetPasswordSheet(context),
          ),
          const SizedBox(height: 12),
          _buildSettingItem(
            context: context,
            icon: Icons.pin,
            title: 'Change transaction PIN',
            onTap: () => _openResetPinSheet(context),
          ),
          const SizedBox(height: 12),
          _buildSettingItem(
            context: context,
            icon: Icons.lock,
            title: 'Change Security PIN',
            onTap: () {},
          ),
          const SizedBox(height: 12),
          _buildSettingItem(
            context: context,
            icon: Icons.person_pin,
            title: 'Biometric Unlock',
            onTap: () => showBiometricSheet(context),
            trailing: Switch(
                value: biometricEnabled,
                onChanged: (value){
                  setState(() {
                    biometricEnabled = value;
                  });
                })
          ),
          const SizedBox(height: 12),
          _buildSettingItem(
            context: context,
            icon: Icons.phonelink_lock,
            title: 'Two Factor Authentication',
            onTap: () {
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => TwoFactorIntroPage()));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required BuildContext context,
    Widget? trailing
  }) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 26, color: isLight
                ? const Color(0xFF2B124C)
                : const Color(0xFF632AAE),),
            const SizedBox(width: 14),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            trailing??
            Icon(Icons.chevron_right, size: 26, color:  isLight ? Colors.black54: Colors.white54),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void _openResetPasswordSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _ResetPasswordView(),
    );
  }
}

// Import the second file like this:
// import 'reset_password_bottom_sheet.dart';

class _ResetPasswordView extends StatelessWidget {
  const _ResetPasswordView();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 🔥 DARK GRADIENT OVERLAY (Full Screen)
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.4),
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        // 🟣 WHITE BOTTOM SHEET
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Row with Icon + Close Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 35), // Padding balance

                    // Purple Circle Icon
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.deepPurple.withOpacity(0.1),
                      ),
                      child: const Icon(Icons.lock_reset, color: Colors.deepPurple),
                    ),

                    // Close Button
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close, size: 22),
                    )
                  ],
                ),

                const SizedBox(height: 22),

                // Title
                const Text(
                  "Reset Login Password",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 12),

                Divider(color: Colors.grey.shade300),

                const SizedBox(height: 12),

                // The Paragraph Box with Purple Stripe
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F2FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          "Enter the 6-digit verification code that was sent to unw****@gmail.com. It's valid for 10 minutes",
                          style: TextStyle(fontSize: 14, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
                    },
                    child: const Text("Continue", style: TextStyle(fontSize: 16)),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void _openResetPinSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const _ResetPasswordView(),
  );
}

// Import the second file like this:
// import 'reset_password_bottom_sheet.dart';

class _ResetPinView extends StatelessWidget {
  const _ResetPinView();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 🔥 DARK GRADIENT OVERLAY (Full Screen)
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.4),
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        // 🟣 WHITE BOTTOM SHEET
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Row with Icon + Close Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 35), // Padding balance

                    // Purple Circle Icon
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.deepPurple.withOpacity(0.1),
                      ),
                      child: const Icon(Icons.lock_reset, color: Colors.deepPurple),
                    ),

                    // Close Button
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close, size: 22),
                    )
                  ],
                ),

                const SizedBox(height: 22),

                // Title
                const Text(
                  "Reset Login Password",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 12),

                Divider(color: Colors.grey.shade300),

                const SizedBox(height: 12),

                // The Paragraph Box with Purple Stripe
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F2FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          "Enter the 6-digit verification code that was sent to unw****@gmail.com. It's valid for 10 minutes",
                          style: TextStyle(fontSize: 14, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPinScreen()));
                    },
                    child: const Text("Continue", style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void showBiometricSheet(BuildContext context) {
  final isLight = Theme.of(context).brightness == Brightness.light;
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
    ),
    builder: (_) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF6B2FD8),
                          Color(0xFF9B6FD8),
                        ],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.lock, color: isLight
                        ? const Color(0xFF2B124C)
                        : const Color(0xFF632AAE),),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    "Enable Biometric",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 18),
                  const Divider(thickness: 1),
                  const SizedBox(height: 24),
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: isLight ? Colors.white54 : Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.fingerprint, size: 48, color: isLight
                        ? const Color(0xFF2B124C)
                        : const Color(0xFF632AAE)),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Security Verification",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Access your account easily when opening the app. Tap the Finger icon to save your biometric.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.4,
                      fontSize: 13,
                      color: Color(0xFF585858),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 16,
              top: 16,
              child: IconButton(
                icon: Icon(Icons.close, color: isLight
                    ? const Color(0xFF2B124C)
                    : const Color(0xFF632AAE),),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      );
    },
  );
}
