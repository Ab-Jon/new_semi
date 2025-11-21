import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semi_bill/home_screen.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  @override
  void initState() {
    super.initState();

    // Fake waiting time for scanning (5 seconds)
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const TicketVerifiedPage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Placeholder background image (camera preview replacement)
          Positioned.fill(
            child: Image.asset(
              "assets/images/placeholder_scan.jpg",
              fit: BoxFit.cover,
            ),
          ),

          // TOP LABEL
          Positioned(
            top: 70,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "Find a code to scan",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // SCAN FRAME (four corners)
          SizedBox(
            width: 260,
            height: 260,
            child: CustomPaint(
              painter: ScannerFramePainter(),
            ),
          ),

          // BOTTOM CANCEL BUTTON
          Positioned(
            bottom: 50,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.delete, color: Colors.white, size: 26),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Scanner corner frame painter
class ScannerFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    double w = size.width;
    double h = size.height;
    double corner = 25;

    Path path = Path();

    // Top-left
    path.moveTo(0, corner);
    path.lineTo(0, 0);
    path.lineTo(corner, 0);

    // Top-right
    path.moveTo(w - corner, 0);
    path.lineTo(w, 0);
    path.lineTo(w, corner);

    // Bottom-left
    path.moveTo(0, h - corner);
    path.lineTo(0, h);
    path.lineTo(corner, h);

    // Bottom-right
    path.moveTo(w - corner, h);
    path.lineTo(w, h);
    path.lineTo(w, h - corner);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// VERIFIED SCREEN
// ---------------------------------------------------------------------------
class TicketVerifiedPage extends StatelessWidget {
  const TicketVerifiedPage({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF3A0A6A);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0414),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle,
                  color: Colors.green, size: 38),

              const SizedBox(height: 14),

              Text(
                "Ticket Verified",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "You have successfully verified this ticket for\nBrothers Gathering",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 26),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Text(
                    "Go to Home",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
