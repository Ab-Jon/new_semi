import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:semi_bill/presentation/wallet_dashboard.dart';

import 'drawer_screens/crowd_funding.dart';
import 'drawer_screens/tickets_screen.dart';

class DrawerContent extends StatefulWidget {
  const DrawerContent({super.key});

  @override
  State<DrawerContent> createState() => _DrawerContentState();
}

class _DrawerContentState extends State<DrawerContent> {
  bool _isCollapsed = false;
  int _selectedMenuIndex = 0;

  final List<Map<String, dynamic>> _menu = [
    {'icon': Ionicons.home_outline, 'label': 'Home'},
    {'icon': Ionicons.ticket_outline, 'label': 'Tickets'},
    {'icon': Ionicons.people_outline, 'label': 'Crowdfunding'},
  ];

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final Size screen = MediaQuery.of(context).size;
    final double maxDrawerWidth = (screen.width * 0.68).clamp(240.0, 320.0);
    final double minDrawerWidth = 80.0;
    final double drawerWidth = _isCollapsed ? minDrawerWidth : maxDrawerWidth;

    return SizedBox(
      width: drawerWidth,
      child: Drawer(
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Profile header
            _isCollapsed
                ? CircleAvatar(
              radius: 20,
              backgroundImage: const AssetImage('assets/avatar_1.jpg'),
              backgroundColor: isLight
                  ? const Color(0xFF2B124C)
                  : const Color(0xFF632AAE),
            )
                : Row(
              children: [
                const SizedBox(width: 12),
                CircleAvatar(
                  radius: 28,
                  backgroundImage: const AssetImage('assets/avatar_1.jpg'),
                  backgroundColor: isLight
                      ? const Color(0xFF2B124C)
                      : const Color(0xFF632AAE),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Kate Russell',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      SizedBox(height: 4),
                      Text('Kate123stein',
                          style:
                          TextStyle(color: Colors.grey, fontSize: 13)),
                    ],
                  ),
                ),
                Icon(Ionicons.chevron_down, color: isLight
                    ? const Color(0xFF2B124C)
                    : const Color(0xFF632AAE)),
              ],
            ),
            const SizedBox(height: 20),

            // Menu
            Expanded(
              child: ListView.builder(
                itemCount: _menu.length,
                itemBuilder: (_, index) {
                  final item = _menu[index];
                  final bool isActive = index == _selectedMenuIndex;
                  return ListTile(
                    leading: Icon(item['icon'], color: isLight
                        ? const Color(0xFF2B124C)
                        : const Color(0xFF632AAE)),
                    title: _isCollapsed ? null : Text(item['label']),
                    selected: isActive,
                    onTap: () {
                      Navigator.pop(context);
                      setState(() => _selectedMenuIndex = index);
                      // Navigate to the correct screen
                      switch (item['label']) {
                        case 'Tickets':
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const TicketsScreen()),
                          );
                          break;
                        case 'Crowdfunding':
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const CrowdfundPage()),
                          );
                          break;
                      }
                    },
                  );
                },
              ),
            ),
            // Collapse button
            ListTile(
              leading: Icon(_isCollapsed ? Ionicons.menu : Ionicons.menu_outline),
              title: _isCollapsed ? null : const Text('Collapse menu'),
              onTap: () => setState(() => _isCollapsed = !_isCollapsed),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
