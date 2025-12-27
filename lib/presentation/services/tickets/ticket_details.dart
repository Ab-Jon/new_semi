import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'dotted_line.dart';

class TicketSuccessPage extends StatelessWidget {
  const TicketSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isLight
              ? const Color(0xFF2B124C)
              : const Color(0xFF632AAE),),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Payment Successful",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "You have successfully made a payment of N8000 for the event (Brother’s Gathering).",
              style: TextStyle(color: isLight? Colors.black54 : Colors.white70),
            ),
            const SizedBox(height: 20),
            _ticketCard(context),
            const SizedBox(height: 24),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text("Resend ticket"),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 20),
            _contactSection(context),
            const SizedBox(height: 24),
            _eventInfoSection(context),
            const SizedBox(height: 24),
            _mapSection(context),
            const SizedBox(height: 100),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Theme.of(context).colorScheme.surface,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isLight
                ? const Color(0xFF2B124C)
                : const Color(0xFF632AAE),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {},
          child: const Text(
            "Go to Home",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
    );
  }
  Widget _ticketCard(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return ClipPath(
      clipper: TicketClipper(),
      child: Container(
        decoration: BoxDecoration(
          color: isLight
              ? const Color(0xFF2B124C)
              : const Color(0xFF632AAE),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            // Gradient header with image
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2B124C), Color(0xFF2B124C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Lovers Inn Presents",
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Brother's Gathering",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      "assets/event.jpg",
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const DottedLine(
              color: Colors.white,
            ),
            const SizedBox(height: 16),
            _ticketDetail(Icons.person, "UNWANA JR.", context),
            _ticketDetail(Icons.calendar_today_outlined, "Dec 31, 2024", context),
            _ticketDetail(Icons.access_time, "5PM - 7PM WAT", context),
            _ticketDetail(Icons.location_on_outlined, "LEKKI, LAGOS.", context),
            _ticketDetail(Icons.confirmation_number, "TICKET NUMBER: XKOF004HY24", context),
            const SizedBox(height: 20),
            Column(
              children: [
                const Text("Scan here"),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: isLight ? Colors.grey.shade100 : Colors.white12,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: QrImageView(// This becomes the scannable value
                      size: 160,
                      version: QrVersions.auto,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      data: '',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _ticketDetail(IconData icon, String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 15, color: Colors.white))),
        ],
      ),
    );
  }

  Widget _contactSection(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Column(
      children: [
        const Text(
          "Contact Us",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Icon(Icons.phone, size: 20, color: isLight
                    ? const Color(0xFF2B124C)
                    : const Color(0xFF632AAE),),
                const SizedBox(width: 6),
                Text("+2348131351618", style: TextStyle(color: isLight
                    ? const Color(0xFF2B124C)
                    : const Color(0xFF632AAE),),),
              ],
            ),
            Row(
              children: [
                Icon(Icons.email_outlined, size: 20, color: isLight
                    ? const Color(0xFF2B124C)
                    : const Color(0xFF632AAE),),
                const SizedBox(width: 6),
                Text("unwana@gmail.com", style: TextStyle(color: isLight
                    ? const Color(0xFF2B124C)
                    : const Color(0xFF632AAE),),),
              ],
            ),
          ],
        ),
      ],
    );
  }
  Widget _eventInfoSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: const [
                Text("DEC", style: TextStyle(fontSize: 12)),
                Text("31", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Saturday, Dec 31",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                Text("6 PM - 8 PM GMT +4:30"),
                SizedBox(height: 8),
                Text("Victoria Island"),
                Text("Lekki, Lagos."),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget _mapSection(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Image.asset(
            "assets/map.jpeg",
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 12,
            left: 12,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isLight
                    ? const Color(0xFF2B124C)
                    : const Color(0xFF632AAE),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {},
              child: const Text("Get Directions", style: TextStyle(color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }
}
/// Creates the ticket cutout shape
class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const notchRadius = 12.0; // size of the small cutout
    final notchCenterY = size.height * 0.48;
    // ^ adjust this up/down until it aligns with your dashed line

    final path = Path();

    path.moveTo(0, 0);

    // Top edge
    path.lineTo(size.width, 0);

    // Right side small circular notch
    path.lineTo(size.width, notchCenterY - notchRadius);
    path.arcToPoint(
      Offset(size.width, notchCenterY + notchRadius),
      radius: const Radius.circular(notchRadius),
      clockwise: false,
    );

    // Bottom edge
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    // Left side small circular notch
    path.lineTo(0, notchCenterY + notchRadius);
    path.arcToPoint(
      Offset(0, notchCenterY - notchRadius),
      radius: const Radius.circular(notchRadius),
      clockwise: false,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(_) => false;
}
