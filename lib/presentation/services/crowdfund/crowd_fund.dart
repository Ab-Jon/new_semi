import 'package:flutter/material.dart';
import 'package:semi_bill/presentation/services/crowdfund/fundraiser/fund_tab.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/ui/ionicons.dart';
import 'package:semi_bill/ui/semi_ui.dart';

class CrowdfundingPage extends StatefulWidget {
  const CrowdfundingPage({super.key});

  @override
  State<CrowdfundingPage> createState() => _CrowdfundingPageState();
}

class _CrowdfundingPageState extends State<CrowdfundingPage> {
  String selectedCategory = 'Charity';

  static const _campaigns = [
    (
      title: "Brother's Gathering",
      days: '18 days left',
      raised: '₦700',
      goal: '₦1,500',
      donors: '120 donors',
      progress: 0.47,
    ),
    (
      title: 'Orphanage Homes',
      days: '24 days left',
      raised: '₦7,000',
      goal: '₦120,000',
      donors: '86 donors',
      progress: 0.06,
    ),
    (
      title: 'Community Clinic',
      days: '11 days left',
      raised: '₦42,100',
      goal: '₦80,000',
      donors: '210 donors',
      progress: 0.53,
    ),
    (
      title: 'School Rebuild',
      days: '31 days left',
      raised: '₦18,400',
      goal: '₦50,000',
      donors: '64 donors',
      progress: 0.37,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        backgroundColor: context.pageBg,
        leading: const SemiBackButton(),
        title: const Text('Crowdfunding'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 28),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/event.jpg',
                height: 128,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 128,
                  color: context.iconWash,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Ionicons.search_outline, color: context.brand),
                      hintText: 'Search',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _openFilter,
                  child: Container(
                    height: 52,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: context.isDark
                          ? SemiColors.surfaceDark
                          : const Color(0xFFF6F4FA),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Filter by: ',
                          style: TextStyle(color: context.semi.muted, fontSize: 13),
                        ),
                        Text(
                          selectedCategory,
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                        ),
                        Icon(Ionicons.chevron_down, size: 16, color: context.brand),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          _section('Premium'),
          _rail(),
          _section('Recently Added', trailing: 'View more'),
          _rail(offset: 1),
          _section('Campaign of the month', trailing: 'View more'),
          _rail(offset: 2),
          _section('Campaign near you', trailing: 'View more'),
          _rail(offset: 3),
        ],
      ),
    );
  }

  Widget _section(String title, {String? trailing}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          if (trailing != null)
            Text(
              trailing,
              style: TextStyle(
                color: context.brand,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
        ],
      ),
    );
  }

  Widget _rail({int offset = 0}) {
    return SizedBox(
      height: 248,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: _campaigns.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = _campaigns[(index + offset) % _campaigns.length];
          return _CampaignCard(item: item);
        },
      ),
    );
  }

  void _openFilter() {
    const filters = [
      'Charity',
      'Humanity Project',
      'Events',
      'Health',
      'Education',
      'Sports',
      'Social Causes',
      'Creative Arts',
      'Sustainability',
    ];
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Filter',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text('Categories', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: filters.map((c) {
                  final selected = c == selectedCategory;
                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedCategory = c);
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: selected ? context.brand : context.iconWash,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        c,
                        style: TextStyle(
                          color: selected ? Colors.white : context.brand,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CampaignCard extends StatelessWidget {
  const _CampaignCard({required this.item});

  final ({
    String title,
    String days,
    String raised,
    String goal,
    String donors,
    double progress,
  }) item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CampaignDetailsScreen()),
        );
      },
      child: Container(
        width: 220,
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: context.isDark
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/event.jpg',
              height: 96,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(height: 96, color: context.iconWash),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.days,
                    style: TextStyle(color: context.semi.muted, fontSize: 11),
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: item.progress,
                      minHeight: 6,
                      backgroundColor: context.iconWash,
                      color: context.brand,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const SemiAvatar(size: 20),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          item.donors,
                          style: TextStyle(fontSize: 11, color: context.semi.muted),
                        ),
                      ),
                      Text(
                        'Donate',
                        style: TextStyle(
                          color: context.brand,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
