import 'package:flutter/material.dart';
import 'package:semi_bill/presentation/services/service_main.dart';
import 'package:semi_bill/presentation/settings/main_settings.dart';
import 'package:semi_bill/presentation/wallet/wallet_screen.dart';
import 'package:semi_bill/presentation/wallet_dashboard.dart';
import 'package:semi_bill/ui/semi_ui.dart';

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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBody: true,
      body: Stack(
        children: [
          _screens[_selectedIndex],
          Positioned(
            left: 16,
            right: 16,
            bottom: 12 + MediaQuery.paddingOf(context).bottom,
            child: SemiNavBar(
              index: _selectedIndex,
              onChanged: (i) => setState(() => _selectedIndex = i),
            ),
          ),
        ],
      ),
    );
  }
}
