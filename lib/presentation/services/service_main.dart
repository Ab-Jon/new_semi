import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
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

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  // ✅ Make sure these are INSIDE your _ServicesScreenState class
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
    {'icon': Ionicons.call_outline, 'title': 'Buy Airtime', 'route': AirtimeScreen()},
    {'icon': Ionicons.wifi_outline, 'title': 'Buy Data', 'route': DataScreen()},
    {'icon': Ionicons.tv_outline, 'title': 'Pay Cable Tv', 'route': CableTvPage()},
    {'icon': Ionicons.game_controller_outline, 'title': 'Betting', 'route': BettingPage()},
    {'icon': Ionicons.flash_outline, 'title': 'Electricity', 'route': ElectricityScreen()},
    {'icon': Ionicons.gift_outline, 'title': 'Gift User', 'route': GiftUserPage()},
    {'icon': Ionicons.globe_outline, 'title': 'Internet', 'route': InternetScreen()},
    {'icon': Ionicons.people_outline, 'title': 'Refer & Earn', 'route': ReferAndEarnPage()},
    {'icon': Ionicons.ticket_outline, 'title': 'Tickets', 'route': EventsScreen()},
    {'icon': Ionicons.cash_outline, 'title': 'Crowd Funding', 'route': CrowdfundingPage()},
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
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  "Services",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ✅ Banner Carousel
              SizedBox(
                height: 120,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: banners.length,
                  onPageChanged: (index) => setState(() => _currentPage = index),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isLight
                            ? const Color(0xFF2B124C)
                            : const Color(0xFF632AAE),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            banners[index]['title']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            banners[index]['subtitle']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Apply Now Button
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Apply Now",
                                  style: TextStyle(
                                    color: isLight
                                        ? const Color(0xFF2B124C)
                                        : const Color(0xFF632AAE),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 14,
                                  color: isLight
                                      ? const Color(0xFF2B124C)
                                      : const Color(0xFF632AAE),
                                )
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
              // ✅ Page Indicator
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
                      color: isLight
                          ? const Color(0xFF2B124C)
                          : const Color(0xFF632AAE),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),
              const Text(
                "All Services",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),

              // ✅ Grid of Services
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: services.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 1.9,
                ),
                itemBuilder: (context, index) {
                  final item = services[index];
                  return InkWell(
                    onTap: (){
                      Navigator.push(context,
                      MaterialPageRoute(builder: (_) => item['route']));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(),
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              item['icon'],
                              color: isLight
                                  ? const Color(0xFF2B124C)
                                  : const Color(0xFF632AAE),
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                item['title'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
