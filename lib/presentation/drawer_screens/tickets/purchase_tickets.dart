import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semi_bill/presentation/drawer_screens/tickets/scan.dart';

class MyTicketsScreen extends StatelessWidget {
  const MyTicketsScreen({super.key});

  final List<Map<String, String>> tickets = const [
    {
      'title': "Brother's Gathering",
      'location': "Lovers Inn, Lekki Lagos.",
      'date': "31st Dec, 2024.",
      'image': 'https://i.pravatar.cc/100?img=5',
    },
    {
      'title': "Ikoyi Night Party",
      'location': "Lovers Inn, Lekki Lagos.",
      'date': "31st Dec, 2024.",
      'image': 'https://images.unsplash.com/photo-1519677100203-a0e668c92439?auto=format&w=800',
    },
    {
      'title': "Brother's Gathering",
      'location': "Lovers Inn, Lekki Lagos.",
      'date': "31st Dec, 2024.",
      'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&w=800',
    },
    {
      'title': "Brother's Gathering",
      'location': "Lovers Inn, Lekki Lagos.",
      'date': "31st Dec, 2024.",
      'image': 'https://images.unsplash.com/photo-1521334884684-d80222895322?auto=format&w=800',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final Color primaryColor = const Color(0xFF3A0A6A);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "My Tickets",
          style: GoogleFonts.poppins(
            color: theme.textTheme.titleLarge?.color ?? Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          final ticket = tickets[index];
          return GestureDetector(
            onTap: (){
              showTicketModal(context, "BG${index + 2345}");
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  if (!isDark)
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            ticket['image']!,
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ticket['title']!,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 14,
                                    color: isDark
                                        ? Colors.grey.shade400
                                        : Colors.grey.shade600,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      ticket['location']!,
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: isDark
                                            ? Colors.grey.shade400
                                            : Colors.grey.shade600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.qr_code_2,
                          color:
                          isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                color: Colors.white, size: 14),
                            const SizedBox(width: 6),
                            Text(
                              ticket['date']!,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "1 Ticket",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

