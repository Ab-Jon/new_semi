import 'dart:async';
import 'package:flutter/material.dart';
import 'package:semi_bill/presentation/services/tickets/purchase_tickets.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/ui/ionicons.dart';
import 'package:semi_bill/ui/semi_ui.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final events = List.generate(
    8,
    (index) => {
      'title': "Brother's Gathering",
      'image': 'assets/event.jpg',
      'date': 'Dec 31',
      'price': '₦8,000.00',
      'location': 'Lovers inn, Lekki Lagos',
    },
  );

  late final PageController _pageController;
  Timer? _autoScrollTimer;
  int _currentPage = 0;
  String selectedCategory = 'Concert';

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.92);
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_pageController.positions.isEmpty) return;
      _currentPage = (_currentPage + 1) % 3;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        backgroundColor: context.pageBg,
        leading: const SemiBackButton(),
        title: const Text('Event'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 28),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
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
                      color: context.isDark ? SemiColors.surfaceDark : const Color(0xFFF6F4FA),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Text('Filter by: ', style: TextStyle(color: context.semi.muted, fontSize: 13)),
                        Text(selectedCategory, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                        Icon(Ionicons.chevron_down, size: 16, color: context.brand),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 210,
            child: PageView.builder(
              controller: _pageController,
              itemCount: 3,
              onPageChanged: (i) => setState(() => _currentPage = i),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _EventPoster(item: events[index], featured: true),
              ),
            ),
          ),
          const SizedBox(height: 8),
          _section('Premium'),
          _rail(),
          _section('Recently added', trailing: 'View more'),
          _rail(),
          _section('Event of the Month', trailing: 'View more'),
          _rail(),
          _section('Event near you', trailing: 'View more'),
          _rail(),
        ],
      ),
    );
  }

  Widget _section(String title, {String? trailing}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
      child: Row(
        children: [
          Expanded(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700))),
          if (trailing != null)
            Text(trailing, style: TextStyle(color: context.brand, fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _rail() {
    return SizedBox(
      height: 188,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) => _EventPoster(item: events[index % events.length]),
      ),
    );
  }

  void _openFilter() {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        const categories = [
          'Concert', 'Sports', 'Theatre', 'Festival', 'Education',
          'Performance', 'Travel', 'Seminar', 'Conference', 'Music',
        ];
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(child: Text('Filter', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
                ],
              ),
              const SizedBox(height: 8),
              const Text('Categories', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: categories.map((c) {
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

class _EventPoster extends StatelessWidget {
  const _EventPoster({required this.item, this.featured = false});

  final Map<String, String> item;
  final bool featured;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const PurchaseTicketPage()));
      },
      child: Container(
        width: featured ? null : 188,
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
            Stack(
              children: [
                Image.asset(
                  item['image']!,
                  height: featured ? 128 : 96,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: featured ? 128 : 96,
                    color: context.iconWash,
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item['date']!,
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                  if (!featured) ...[
                    const SizedBox(height: 2),
                    Text(item['price']!, style: TextStyle(color: context.brand, fontWeight: FontWeight.w600, fontSize: 12)),
                  ],
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Ionicons.location_outline, size: 13, color: context.brand),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          item['location']!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 11, color: context.semi.muted),
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
