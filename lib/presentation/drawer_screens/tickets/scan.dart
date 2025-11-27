import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:semi_bill/presentation/drawer_screens/tickets/qr_scanner.dart';

void showTicketModal(BuildContext context, String ticketData) {
  final theme = Theme.of(context);
  final isDark = theme.brightness == Brightness.dark;
  final isLight = Theme.of(context).brightness == Brightness.light;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(26),
            topRight: Radius.circular(26),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Row
            Row(
              children: [
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withOpacity(0.08)
                        : Colors.purple.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.confirmation_number_outlined,
                    color:  isLight
                        ? const Color(0xFF2B124C)
                        : const Color(0xFF632AAE),
                    size: 20,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.close,
                    color:  isLight
                        ? const Color(0xFF2B124C)
                        : const Color(0xFF632AAE),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // QR Label
            Text(
              "Scan here",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),

            const SizedBox(height: 16),

            // Generated QR Code
            Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.white12 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(20),
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => QrScannerPage()));
                },
                child: QrImageView(
                  data: ticketData,          // This becomes the scannable value
                  size: 160,
                  version: QrVersions.auto,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Ticket Passcode (shown below QR)
            RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: theme.textTheme.bodyLarge?.color,
                ),
                children: [
                  const TextSpan(text: "Ticket Passcode: "),
                  TextSpan(
                    text: ticketData,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Share Ticket Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:  isLight
                      ? const Color(0xFF2B124C)
                      : const Color(0xFF632AAE),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // TODO: Add share logic
                },
                child: Text(
                  "Share Ticket",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}
