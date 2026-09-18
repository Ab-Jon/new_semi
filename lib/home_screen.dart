import 'package:flutter/material.dart';
import 'package:semi_bill/ui/ionicons.dart';
import 'package:semi_bill/presentation/services/service_main.dart';
import 'package:semi_bill/presentation/settings/main_settings.dart';
import 'package:semi_bill/presentation/wallet/wallet_screen.dart';
import 'package:semi_bill/presentation/wallet_dashboard.dart';
import 'package:semi_bill/themes/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    WalletDashboardScreen(),
    const ServicesScreen(),
    const WalletScreen(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    const icons = [
      Ionicons.home,
      Ionicons.briefcase,
      Ionicons.wallet,
      Ionicons.settings,
    ];
    const labels = ['Home', 'Services', 'Wallet', 'Settings'];

    return Scaffold(
      backgroundColor: context.pageBg,
      extendBody: true,
      body: Stack(
        children: [
          _screens[_selectedIndex],
          Positioned(
            left: 16,
            right: 16,
            bottom: 18,
            child: Container(
              height: 72,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: context.isDark ? SemiColors.cardDark : SemiColors.brand,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(icons.length, (index) {
                  final selected = _selectedIndex == index;
                  final selectedBg = context.isDark
                      ? const Color(0xFF5B37B7)
                      : SemiColors.lavender;
                  final selectedFg = context.isDark
                      ? SemiColors.lavender
                      : SemiColors.brand;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedIndex = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      padding: EdgeInsets.symmetric(
                        horizontal: selected ? 14 : 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: selected ? selectedBg : Colors.transparent,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            icons[index],
                            size: 22,
                            color: selected ? selectedFg : Colors.white70,
                          ),
                          if (selected) ...[
                            const SizedBox(width: 6),
                            Text(
                              labels[index],
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: selectedFg,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
