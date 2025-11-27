import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:semi_bill/presentation/drawer_screens/tickets/events/event_screen.dart';
import 'package:semi_bill/presentation/drawer_screens/tickets/purchase_tickets.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  String selected = ""; // 'tickets' or 'events'

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      floatingActionButton: selected == "events"
          ? FloatingActionButton(
        onPressed: () {
          // Add event logic here
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => MyEventsPage()));
        },
        backgroundColor: isLight
            ? const Color(0xFF2B124C)
            : const Color(0xFF632AAE),
        child: Icon(Icons.add, color: Colors.white),
      )
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Personalize your Experience',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Select one of the experience to get started',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 30),

              /// ------------------ My Tickets Card ------------------
              GestureDetector(
                onTap: () {
                  setState(() => selected = "tickets");

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyTicketsScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: selected == "tickets"
                          ? isLight
                          ? const Color(0xFF2B124C)
                          : const Color(0xFF632AAE)
                          : Theme.of(context).colorScheme.primary,
                      width: 0.8,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Ionicons.ticket,
                        size: 40,
                        color:
                        selected == "tickets" ? isLight
                            ? const Color(0xFF2B124C)
                            : const Color(0xFF632AAE)
                            : Theme.of(context).colorScheme.primary,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'My Tickets',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Selecting this ensures your Dhara experience aligns with your role as an Anchor',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// ------------------ My Events Card ------------------
              GestureDetector(
                onTap: () {
                  setState(() => selected = "events");
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: selected == "events"
                          ? isLight
                          ? const Color(0xFF2B124C)
                          : const Color(0xFF632AAE)
                          : Theme.of(context).colorScheme.primary,
                      width: 0.8,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Ionicons.calendar,
                        size: 40,
                        color: selected == "events"
                            ? isLight
                            ? const Color(0xFF2B124C)
                            : const Color(0xFF632AAE)
                            : Theme.of(context).colorScheme.primary,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'My Events',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Selecting this ensures your Dhara experience aligns with your role as a Vendor',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
