import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:semi_bill/home_screen.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/ui/ionicons.dart';
import 'package:semi_bill/ui/semi_ui.dart';

import 'dotted_line.dart';

class TicketSuccessPage extends StatelessWidget {
  const TicketSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        backgroundColor: context.pageBg,
        leading: const SemiBackButton(),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        children: [
          const Text(
            'Payment Successful',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(
            "You have successfully made a payment of ₦8,000 for Brother's Gathering.",
            style: TextStyle(color: context.semi.muted, height: 1.4),
          ),
          const SizedBox(height: 20),
          _ticketCard(context),
          const SizedBox(height: 16),
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text('Resend ticket', style: TextStyle(color: context.brand, fontWeight: FontWeight.w600)),
            ),
          ),
          Divider(color: context.hairline),
          const SizedBox(height: 16),
          const Center(
            child: Text('Contact Us', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(Ionicons.call_outline, size: 18, color: context.brand),
                  const SizedBox(width: 6),
                  Text('+2348131351618', style: TextStyle(color: context.brand, fontWeight: FontWeight.w600)),
                ],
              ),
              Row(
                children: [
                  Icon(Ionicons.mail_outline, size: 18, color: context.brand),
                  const SizedBox(width: 6),
                  Text('unwana@gmail.com', style: TextStyle(color: context.brand, fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          SemiCard(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  decoration: BoxDecoration(
                    color: context.iconWash,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Column(
                    children: [
                      Text('DEC', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                      Text('31', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Saturday, Dec 31', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                      SizedBox(height: 4),
                      Text('5 PM - 7 PM WAT'),
                      SizedBox(height: 6),
                      Text('Victoria Island'),
                      Text('Lekki, Lagos.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Image.asset(
                  'assets/map.jpeg',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Get Directions'),
                    ),
                  ),
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
            label: 'Go to Home',
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const HomeScreen()),
                (_) => false,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _ticketCard(BuildContext context) {
    return ClipPath(
      clipper: TicketClipper(),
      child: Container(
        decoration: BoxDecoration(
          color: context.brand,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Lovers Inn Presents', style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 4),
                  const Text(
                    "Brother's Gathering",
                    style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/event.jpg',
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            const DottedLine(color: Colors.white),
            const SizedBox(height: 12),
            _ticketDetail(Ionicons.person_outline, 'UNWANA JR.'),
            _ticketDetail(Ionicons.calendar_outline, 'Dec 31, 2024'),
            _ticketDetail(Ionicons.time_outline, '5PM - 7PM WAT'),
            _ticketDetail(Ionicons.location_outline, 'LEKKI, LAGOS.'),
            _ticketDetail(Ionicons.ticket_outline, 'TICKET NUMBER: XKOF004HY24'),
            const SizedBox(height: 16),
            const Text('Scan here', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: QrImageView(
                size: 148,
                version: QrVersions.auto,
                backgroundColor: Colors.white,
                data: 'XKOF004HY24',
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _ticketDetail(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14, color: Colors.white))),
        ],
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const notchRadius = 12.0;
    final notchCenterY = size.height * 0.48;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, notchCenterY - notchRadius)
      ..arcToPoint(
        Offset(size.width, notchCenterY + notchRadius),
        radius: const Radius.circular(notchRadius),
        clockwise: false,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, notchCenterY + notchRadius)
      ..arcToPoint(
        Offset(0, notchCenterY - notchRadius),
        radius: const Radius.circular(notchRadius),
        clockwise: false,
      )
      ..close();
    return path;
  }

  @override
  bool shouldReclip(_) => false;
}
