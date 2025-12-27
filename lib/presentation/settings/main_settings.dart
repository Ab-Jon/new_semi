import 'package:flutter/material.dart';
import 'package:semi_bill/presentation/settings/security.dart';
import 'package:semi_bill/presentation/settings/update_profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),

            /// Title
            const Text(
              "Settings",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 20),

            /// Profile Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    /// Avatar
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(
                            "https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91",
                            height: 56,
                            width: 56,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 18,
                            width: 18,
                            decoration: BoxDecoration(
                              color: const Color(0xFF632AAE),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(width: 14),

                    /// Name & Email
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Boss Unwana",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "ubokobong@gmail.com",
                          style: TextStyle(
                            fontSize: 13,
                            color: isLight
                                ? Colors.black54
                                : Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 55),

            /// Settings Card
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      children: [
                        buildSettingItem(
                          context,
                          Icons.shield_outlined,
                          "Security",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SecurityScreen(),
                              ),
                            );
                          },
                        ),
                        buildSettingItem(
                          context,
                          Icons.notifications_outlined,
                          "Notifications",
                        ),
                        buildSettingItem(
                          context,
                          Icons.verified_outlined,
                          "Account Verification",
                        ),
                        buildSettingItem(
                          context,
                          Icons.person_outline,
                          "Update Profile",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => UpdateProfileScreen(),
                              ),
                            );
                          },
                        ),
                        buildSettingItem(
                          context,
                          Icons.support_agent_outlined,
                          "Support",
                        ),
                        buildSettingItem(
                          context,
                          Icons.devices_other_outlined,
                          "Device & Session",
                        ),
                        buildSettingItem(
                          context,
                          Icons.help_outline,
                          "FAQ",
                        ),
                        buildSettingItem(
                          context,
                          Icons.description_outlined,
                          "Terms & Condition",
                          showDivider: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Single Setting Item
  Widget buildSettingItem(
      BuildContext context,
      IconData icon,
      String title, {
        VoidCallback? onTap,
        bool showDivider = true,
      }) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            child: Row(
              children: [
                /// Icon Container
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFF632AAE).withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 18,
                    color: const Color(0xFF632AAE),
                  ),
                ),

                const SizedBox(width: 14),

                /// Title
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                /// Chevron
                Icon(
                  Icons.chevron_right,
                  size: 22,
                  color: isLight
                      ? Colors.black38
                      : Colors.white38,
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              height: 1,
              thickness: 0.4,
              color: Colors.grey.shade300,
            ),
          ),
      ],
    );
  }
}
