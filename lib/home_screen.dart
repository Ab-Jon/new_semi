import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:semi_bill/presentation/services/service_main.dart';
import 'package:semi_bill/presentation/settings/main_settings.dart';
import 'package:semi_bill/presentation/wallet/wallet_screen.dart';
import 'package:semi_bill/presentation/wallet_dashboard.dart';

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
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final icons = [
      Ionicons.home,
      Ionicons.briefcase,
      Ionicons.wallet,
      Ionicons.settings,
    ];

    final labels = ["Home", "Services", "Wallet", "Settings"];
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black      // DARK MODE BACKGROUND
              : const Color(0xFF2B124C), // LIGHT MODE BACKGROUND
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(icons.length, (index) {
            final bool isSelected = _selectedIndex == index;
            final bool isDark = Theme.of(context).brightness == Brightness.dark;

            // SELECTED TAB COLORS
            final Color selectedBackground =
            isDark ? const Color(0xFF5B37B7) : const Color(0xFFDFD7F3);

            final Color selectedTextColor =
            isDark ? const Color(0xFFB6A4FF) : const Color(0xFF5B37B7);

            const Color unselectedColor = Colors.white70;

            return GestureDetector(
              onTap: () => _onItemTapped(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: EdgeInsets.symmetric(
                  horizontal: isSelected ? 16 : 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? selectedBackground : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Icon(
                      icons[index],
                      size: 24,
                      color: isSelected ? selectedTextColor : unselectedColor,
                    ),
                    if (isSelected)
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Text(
                          labels[index],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: selectedTextColor,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _AnimatedBottomNavBar extends StatefulWidget {
  const _AnimatedBottomNavBar({super.key});

  @override
  State<_AnimatedBottomNavBar> createState() => _AnimatedBottomNavBarState();
}

class _AnimatedBottomNavBarState extends State<_AnimatedBottomNavBar> {
  int _selectedIndex = 0;

  final List<_NavItem> _items = [
    _NavItem(Ionicons.home, "Home"),
    _NavItem(Ionicons.briefcase, "Services"),
    _NavItem(Ionicons.wallet, "Wallet"),
    _NavItem(Ionicons.settings, "Settings"),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(_items.length, (index) {
        final isSelected = index == _selectedIndex;
        final item = _items[index];

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            padding: EdgeInsets.symmetric(
              horizontal: isSelected ? 16 : 0,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(item.icon, size: 26),
                if (isSelected) ...[
                  const SizedBox(width: 8),
                  Text(
                    item.label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem(this.icon, this.label);
}
