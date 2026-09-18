import 'dart:async';
import 'package:flutter/material.dart';
import 'package:semi_bill/ui/ionicons.dart';
import 'package:semi_bill/presentation/services/airtime/airtime_home.dart';
import 'package:semi_bill/presentation/services/betting/betting_screen.dart';
import 'package:semi_bill/presentation/services/cable/cable_tv.dart';
import 'package:semi_bill/presentation/services/crowdfund/crowd_fund.dart';
import 'package:semi_bill/presentation/services/data/data_home.dart';
import 'package:semi_bill/presentation/services/electricity/electricity_screen.dart';
import 'package:semi_bill/presentation/services/gift/gift_user.dart';
import 'package:semi_bill/presentation/services/internet/internet_screen.dart';
import 'package:semi_bill/presentation/services/refer/refer_earn.dart';
import 'package:semi_bill/presentation/services/tickets/event_tickets.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/ui/semi_ui.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, String>> banners = [
    {
      'title': 'Get 10% Free on airtime.',
      'subtitle': 'Stay updated with new features and benefits',
    },
    {
      'title': 'Pay Bills Easily & Instantly!',
      'subtitle': 'All your payments in one tap',
    },
    {
      'title': 'Invite & Earn Rewards',
      'subtitle': 'Get bonuses for every referral',
    },
  ];

  final List<Map<String, dynamic>> services = [
    {'icon': Ionicons.call_outline, 'title': 'Buy Airtime', 'route': const AirtimeScreen()},
    {'icon': Ionicons.wifi_outline, 'title': 'Buy Data', 'route': const DataScreen()},
    {'icon': Ionicons.tv_outline, 'title': 'Pay Cable Tv', 'route': const CableTvScreen()},
    {'icon': Ionicons.game_controller_outline, 'title': 'Betting', 'route': const BettingScreen()},
    {'icon': Ionicons.flash_outline, 'title': 'Electricity', 'route': const ElectricityScreen()},
    {'icon': Ionicons.gift_outline, 'title': 'Gift User', 'route': const GiftUserPage()},
    {'icon': Ionicons.globe_outline, 'title': 'Internet', 'route': const InternetScreen()},
    {'icon': Ionicons.people_outline, 'title': 'Refer & Earn', 'route': const ReferAndEarnPage()},
    {'icon': Ionicons.ticket_outline, 'title': 'Tickets', 'route': const EventsScreen()},
    {'icon': Ionicons.cash_outline, 'title': 'Crowd Funding', 'route': const CrowdfundingPage()},
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentPage < banners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Services',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 128,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: banners.length,
                  onPageChanged: (index) => setState(() => _currentPage = index),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: context.brand,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            banners[index]['title']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            banners[index]['subtitle']!,
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Apply Now',
                                  style: TextStyle(
                                    color: context.brand,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(Icons.arrow_forward, size: 14, color: context.brand),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  banners.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 6,
                    width: _currentPage == index ? 16 : 6,
                    decoration: BoxDecoration(
                      color: context.brand,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'All Services',
                style: TextStyle(
                  color: context.semi.muted,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 14),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: services.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2.8,
                ),
                itemBuilder: (context, index) {
                  final item = services[index];
                  return SemiCard(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => item['route'] as Widget),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(item['icon'] as IconData, color: context.brand, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            item['title'] as String,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
