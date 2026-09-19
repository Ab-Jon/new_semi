import 'package:flutter/material.dart';
import 'package:semi_bill/presentation/services/crowdfund/fundraiser/donate_screen.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/ui/ionicons.dart';
import 'package:semi_bill/ui/semi_ui.dart';

class FundraiserDetailsScreen extends StatelessWidget {
  const FundraiserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/event.jpg',
              height: 168,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(height: 168, color: context.iconWash),
            ),
          ),
          const SizedBox(height: 14),
          Text('18 days left', style: TextStyle(color: context.semi.muted, fontSize: 13)),
          const SizedBox(height: 4),
          const Text(
            "Brother's Gathering",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          SemiCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Spread the word on',
                      style: TextStyle(fontSize: 12, color: context.semi.muted),
                    ),
                    const Spacer(),
                    Image.asset('assets/icons/instagram.png', height: 22),
                    const SizedBox(width: 8),
                    Image.asset('assets/icons/facebook.png', height: 22),
                    const SizedBox(width: 8),
                    Image.asset('assets/icons/telegram.png', height: 22),
                    const SizedBox(width: 8),
                    Image.asset('assets/icons/whatsapp.png', height: 22),
                  ],
                ),
                const SizedBox(height: 16),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('₦700 raised', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
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
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Last donation 6 days ago',
                      style: TextStyle(color: context.semi.muted, fontSize: 12),
                    ),
                    const Spacer(),
                    Icon(Ionicons.people_outline, size: 16, color: context.brand),
                    const SizedBox(width: 4),
                    const Text('120 donors', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          TabBar(
            labelColor: context.brand,
            unselectedLabelColor: context.semi.muted,
            indicatorColor: context.brand,
            labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            tabs: const [
              Tab(text: 'Campaign Details'),
              Tab(text: 'About the Fundraiser'),
            ],
          ),
          const SizedBox(
            height: 220,
            child: TabBarView(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Brothers Gathering @2024",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'A small act of kindness is all we need. Give when you have the chance — it does not take much to be decent humans.',
                        style: TextStyle(fontSize: 14, height: 1.45),
                      ),
                    ],
                  ),
                ),
                _AboutFundraiser(),
              ],
            ),
          ),
          SemiButton(
            label: 'Donate Now',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DonateScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _AboutFundraiser extends StatelessWidget {
  const _AboutFundraiser();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SemiAvatar(size: 48),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mr Judeen Igwe', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                    Text('Fundraiser', style: TextStyle(color: Color(0xFF6B7280), fontSize: 12)),
                  ],
                ),
              ),
              Text(
                'View Profile',
                style: TextStyle(color: context.brand, fontWeight: FontWeight.w700, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Passionate about fostering faith and community. Together we grow in love, service, and purpose as one family.',
            style: TextStyle(fontSize: 14, height: 1.45),
          ),
        ],
      ),
    );
  }
}
