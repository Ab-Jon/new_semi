import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class PromoBannerSlider extends ConsumerStatefulWidget {
  const PromoBannerSlider({super.key});

  @override
  ConsumerState<PromoBannerSlider> createState() =>
      _PromoBannerSliderState();
}

class _PromoBannerSliderState extends ConsumerState<PromoBannerSlider> {
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

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      _currentPage =
          (_currentPage + 1) % banners.length;

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

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  banners[index]['subtitle']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      ),
    );
  }
}
