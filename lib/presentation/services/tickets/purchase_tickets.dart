import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:semi_bill/presentation/services/tickets/ticket_details.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/ui/ionicons.dart';
import 'package:semi_bill/ui/semi_ui.dart';

class PurchaseTicketPage extends StatefulWidget {
  const PurchaseTicketPage({super.key});

  @override
  State<PurchaseTicketPage> createState() => _PurchaseTicketPageState();
}

class _PurchaseTicketPageState extends State<PurchaseTicketPage> {
  int quantity = 1;
  static const price = 8000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        backgroundColor: context.pageBg,
        title: const Text('Purchase Ticket'),
        leading: const SemiBackButton(),
        actions: [
          IconButton(
            icon: Icon(Ionicons.notifications_outline, color: context.brand),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          SemiCard(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                      child: Image.asset(
                        'assets/event.jpg',
                        height: 168,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Column(
                          children: [
                            Text('Dec', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                            Text('31', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(14, 14, 14, 4),
                  child: Text(
                    "Brother's Gathering",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 0, 14, 8),
                  child: Row(
                    children: [
                      Icon(Ionicons.location_outline, color: context.brand, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        'Lovers Inn, Lekki Lagos.',
                        style: TextStyle(color: context.semi.muted),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(14, 0, 14, 16),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text('₦8,000.00', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SemiCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Ticket', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Brother's Gathering", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                          SizedBox(height: 4),
                          Text('Max Order 5', style: TextStyle(color: Color(0xFF6B7280), fontSize: 12)),
                        ],
                      ),
                    ),
                    _qtyButton(Ionicons.remove, () {
                      if (quantity > 1) setState(() => quantity--);
                    }),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        '$quantity',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                    _qtyButton(Ionicons.add, () {
                      if (quantity < 5) setState(() => quantity++);
                    }),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SemiCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Sum', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                Text(
                  '₦${price * quantity}.00',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SemiCard(
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
                          Text('Organizer', style: TextStyle(color: Color(0xFF6B7280), fontSize: 12)),
                        ],
                      ),
                    ),
                    Text(
                      'View Profile',
                      style: TextStyle(fontWeight: FontWeight.w700, color: context.brand, fontSize: 13),
                    ),
                    Icon(Icons.chevron_right, size: 16, color: context.brand),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  "About Brother's Gathering\n\n"
                  'Passionate about fostering faith and community. Together we grow in love, service, and spiritual wisdom as one church family.',
                  style: TextStyle(height: 1.4, color: context.semi.textPrimary),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.facebook, color: context.iconTint),
                    const SizedBox(width: 14),
                    FaIcon(FontAwesomeIcons.whatsapp, color: context.iconTint, size: 20),
                    const SizedBox(width: 14),
                    Icon(Ionicons.call_outline, color: context.iconTint),
                    const SizedBox(width: 14),
                    Icon(Ionicons.mail_outline, color: context.iconTint),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: SemiButton(
            label: 'Make Payment',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TicketSuccessPage()),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
          color: context.iconWash,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(icon, size: 18, color: context.brand),
      ),
    );
  }
}
