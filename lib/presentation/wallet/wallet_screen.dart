import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int _currentBanner = 0;
  String selectedPortfolio = 'Wallet Balance';


  // bottom sheet
  void _showPortfolioSheet() {
    final isLight = Theme.of(context).brightness == Brightness.light;
    showGeneralDialog(
      context: context,
      barrierLabel: "Portfolio",
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, _, __) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5,
                ), // background blur
                child: Container(
                  width: double.infinity,
                  color: isLight? Colors.white : Colors.black12,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: isLight
                              ? Color(0xFF632AAE).withOpacity(0.08)
                              : const Color(0xFF1E1E1E),
                        ),
                        child: Icon(
                          size: 25,
                          Icons.wallet,
                          color: Color(0xFF2B124C),
                        ),
                      ),
                      const Text(
                        'Choose Portfolio',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildOption('Wallet Balance'),
                      _buildOption('Crowdfunding Wallet'),
                      _buildOption('Ticket Wallet'),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        );
      },
    );
  }

  Widget _buildOption(String title) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final isSelected = title == selectedPortfolio;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPortfolio = title;
        });
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: isSelected ? isLight
              ? const Color(0xFF2B124C)
              : const Color(0xFF632AAE) : isLight
              ? Colors.grey.shade100
              : const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : isLight? Colors.black: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  final List<Map<String, String>> _banners = [
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

  final List<Map<String, dynamic>> _portfolio = [
    {
      'title': 'Event Tickets',
      'subtitle': 'Brothers Gathering',
      'amount': '₦7,000.00',
      'progressText': '28 of 70 sold out',
      'icon': Icons.event,
    },
    {
      'title': 'Crowdfunding',
      'subtitle': 'Orphanage Homes',
      'amount': '₦7,000.00',
      'progressText': '₦7000 of ₦120000 raised',
      'icon': Icons.favorite,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Wallet',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isLight ? const Color(0xFF0F0F0F) : Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: isLight ? Colors.grey.shade100 : const Color(0xFF0F0F0F) // DARK MODE,
      ),
      backgroundColor: isLight ? Colors.white : const Color(0xFF0F0F0F),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Wallet Balance Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isLight ? Colors.grey.shade100 : const Color(0xFF0F0F0F),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)
                ),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _showPortfolioSheet,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isLight ? Colors.white : const Color(0xFF161616),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedPortfolio,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: isLight
                                ? const Color(0xFF2B124C)
                                : const Color(0xFF632AAE),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '₦14,000.00',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(
                        Icons.refresh,
                        color: isLight
                            ? const Color(0xFF2B124C)
                            : const Color(0xFF632AAE),
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildAction(Icons.add, 'Deposit'),
                      _buildAction(Icons.arrow_downward, 'Withdraw'),
                      _buildAction(Icons.swap_horiz, 'Transfer'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              child: _buildPortfolioContent(),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildAction(IconData icon, String label) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: isLight ? Colors.white : const Color(0xFF1E1E1E),
          radius: 22,
          child: Icon(
            icon,
            color: isLight
                ? Colors.black
                : Colors.white,
            size: 22,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildPortfolioContent() {
    switch (selectedPortfolio) {
      case 'Wallet Balance':
        return _walletBalanceView();

      case 'Crowdfunding Wallet':
        return _crowdfundingWalletView();

      case 'Ticket Wallet':
        return _ticketWalletView();

      default:
        return const SizedBox.shrink();
    }
  }


  Widget _walletBalanceView() {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Column(
      children: [
        // Auto Sliding Banner
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CarouselSlider(
            options: CarouselOptions(
              height: 120,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() => _currentBanner = index);
              },
            ),
            items: _banners.map((banner) {
              return Builder(
                builder: (context) {
                  return Container(
                    width: double.infinity,
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
                          banner['title']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          banner['subtitle']!,
                          style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: EdgeInsets.zero, // important
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {},
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: isLight
                                        ? [
                                          const Color(0xFF2B124C),
                                      const Color(0xFF2B124C).withOpacity(0.85),
                                    ] : [
                                          const Color(0xFF632AAE),
                                      const Color(0xFF632AAE).withOpacity(0.85),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  child: Text(
                                    banner['button']!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
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
            }).toList(),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _banners
              .asMap()
              .entries
              .map((entry) {
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 3,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentBanner == entry.key
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primary.withValues(),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        // Wallet Portfolio Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text(
                'Wallet Portfolio',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Icon(
                Icons.remove_red_eye_outlined,
                size: 18,
                color: isLight
                    ? const Color(0xFF2B124C)
                    : const Color(0xFF632AAE),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: _portfolio.map((item) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isLight ? const Color(0xFFF9F9FB) : const Color(0xFF1A1A1A),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withValues(),
                  //     blurRadius: 5,
                  //     spreadRadius: 1,
                  //   ),
                  // ],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: isLight ? Colors.white : Colors
                              .black,
                          radius: 20,
                          child: Icon(
                            item['icon'],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item['subtitle'],
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          item['amount'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item['progressText'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _crowdfundingWalletView() {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Column(
      key: const ValueKey('crowdfunding_wallet'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://images.unsplash.com/photo-1509099836639-18ba1795216d',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Brother’s Gathering",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: isLight? Colors.white : const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.4),width: 0.8,)
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Spread the word on",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 3),
                    IconButton(
                        onPressed: (){},
                        icon: FaIcon(FontAwesomeIcons.instagram)),
                    const SizedBox(width: 1),
                    IconButton(
                        onPressed: (){},
                        icon: FaIcon(FontAwesomeIcons.facebook)),
                    const SizedBox(width: 1),
                    IconButton(
                        onPressed: (){},
                        icon: FaIcon(FontAwesomeIcons.whatsapp)),
                    const SizedBox(width: 1),
                    IconButton(
                        onPressed: (){},
                        icon: FaIcon(FontAwesomeIcons.twitter)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("₦700 raised"),
                    Text("₦1,500 left"),
                  ],
                ),
                const SizedBox(height: 6),
                LinearProgressIndicator(
                  value: 0.47,
                  backgroundColor: Colors.grey.shade300,
                  color: isLight ? const Color(0xFF2B124C)
                      : const Color(0xFF632AAE),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Last donation 6 days ago • 120 donors",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _ticketWalletView() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(40),
        child: Text(
          "Ticket Wallet Coming Soon",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
