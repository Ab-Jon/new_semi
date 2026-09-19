import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:semi_bill/presentation/wallet/transfer/gift_user_page.dart';
import 'package:semi_bill/presentation/wallet/wallet_bottom_sheet.dart';
import 'package:semi_bill/presentation/wallet/withdrawal_screen.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/ui/ionicons.dart';
import 'package:semi_bill/ui/semi_ui.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int _currentBanner = 0;
  String selectedPortfolio = 'Wallet Balance';

  static const _banners = [
    {
      'title': 'Get 10% Free on airtime.',
      'subtitle': 'Stay updated with new features and benefits',
      'button': 'Apply Now',
    },
    {
      'title': 'Invite friends and earn rewards!',
      'subtitle': 'Refer and get bonuses instantly',
      'button': 'Invite Now',
    },
  ];

  void _showPortfolioSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(color: context.iconWash, shape: BoxShape.circle),
                child: Icon(Ionicons.wallet_outline, color: context.brand),
              ),
              const SizedBox(height: 12),
              const Text('Choose Portfolio', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(height: 16),
              for (final title in ['Wallet Balance', 'Crowdfunding Wallet', 'Ticket Wallet'])
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() => selectedPortfolio = title);
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                      decoration: BoxDecoration(
                        color: title == selectedPortfolio ? context.brand : context.iconWash,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        title,
                        style: TextStyle(
                          color: title == selectedPortfolio ? Colors.white : context.semi.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        backgroundColor: context.pageBg,
        title: const Text('Wallet'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
        children: [
          GestureDetector(
            onTap: _showPortfolioSheet,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                color: context.isDark ? SemiColors.surfaceDark : const Color(0xFFF6F4FA),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(selectedPortfolio, style: const TextStyle(fontWeight: FontWeight.w600)),
                  ),
                  Icon(Ionicons.chevron_down, color: context.brand, size: 18),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Center(
            child: Text('₦14,000.00', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, letterSpacing: -0.4)),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SemiIconAction(
                icon: Ionicons.add,
                label: 'Deposit',
                onTap: () => WalletDepositSheet.show(context),
              ),
              SemiIconAction(
                icon: Ionicons.arrow_up_outline,
                label: 'Withdraw',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const WithdrawalScreen()));
                },
              ),
              SemiIconAction(
                icon: Ionicons.swap_horizontal_outline,
                label: 'Transfer',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const GiftUserPage()));
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: _buildPortfolioContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioContent() {
    switch (selectedPortfolio) {
      case 'Crowdfunding Wallet':
        return _crowdfundingWalletView();
      case 'Ticket Wallet':
        return const Padding(
          key: ValueKey('ticket'),
          padding: EdgeInsets.all(40),
          child: Center(child: Text('Ticket Wallet Coming Soon')),
        );
      default:
        return _walletBalanceView();
    }
  }

  Widget _walletBalanceView() {
    return Column(
      key: const ValueKey('wallet'),
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 132,
            autoPlay: true,
            viewportFraction: 1,
            onPageChanged: (index, _) => setState(() => _currentBanner = index),
          ),
          items: _banners.map((banner) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: context.brand,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(banner['title']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(banner['subtitle']!, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                  const Spacer(),
                  Text(banner['button']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_banners.length, (i) {
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentBanner == i ? context.brand : context.iconWash,
              ),
            );
          }),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            const Text('Wallet Portfolio', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(width: 6),
            Icon(Ionicons.eye_outline, size: 18, color: context.brand),
          ],
        ),
        const SizedBox(height: 12),
        SemiCard(
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(color: context.iconWash, shape: BoxShape.circle),
                child: Icon(Ionicons.ticket_outline, color: context.iconTint, size: 18),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Event Tickets', style: TextStyle(fontWeight: FontWeight.w600)),
                    Text("Brother's Gathering", style: TextStyle(color: Color(0xFF6B7280), fontSize: 13)),
                  ],
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('₦7,000.00', style: TextStyle(fontWeight: FontWeight.w700)),
                  Text('28 of 70 sold', style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SemiCard(
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(color: context.iconWash, shape: BoxShape.circle),
                child: Icon(Ionicons.heart_outline, color: context.iconTint, size: 18),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Crowdfunding', style: TextStyle(fontWeight: FontWeight.w600)),
                    Text('Orphanage Homes', style: TextStyle(color: Color(0xFF6B7280), fontSize: 13)),
                  ],
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('₦7,000.00', style: TextStyle(fontWeight: FontWeight.w700)),
                  Text('₦7,000 of ₦120,000', style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _crowdfundingWalletView() {
    return Column(
      key: const ValueKey('crowd'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/event.jpg',
            height: 168,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 12),
        const Text("Brother's Gathering", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        const SizedBox(height: 14),
        SemiCard(
          child: Column(
            children: [
              Row(
                children: [
                  Text('Spread the word on', style: TextStyle(color: context.semi.muted)),
                  const Spacer(),
                  Image.asset('assets/icons/instagram.png', height: 22),
                  const SizedBox(width: 8),
                  Image.asset('assets/icons/facebook.png', height: 22),
                  const SizedBox(width: 8),
                  Image.asset('assets/icons/whatsapp.png', height: 22),
                ],
              ),
              const SizedBox(height: 14),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('₦700 raised', style: TextStyle(fontWeight: FontWeight.w700)),
                  Text('₦1,500 left', style: TextStyle(color: Color(0xFF6B7280))),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: 0.47,
                  minHeight: 8,
                  backgroundColor: context.iconWash,
                  color: context.brand,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Last donation 6 days ago • 120 donors',
                style: TextStyle(fontSize: 12, color: context.semi.muted),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
