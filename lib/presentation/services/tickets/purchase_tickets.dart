import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:semi_bill/presentation/services/tickets/ticket_details.dart';

class PurchaseTicketPage extends StatefulWidget {
  const PurchaseTicketPage({super.key});

  @override
  State<PurchaseTicketPage> createState() => _PurchaseTicketPageState();
}

class _PurchaseTicketPageState extends State<PurchaseTicketPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    const price = 8000;
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        title: const Text(
          "Purchase Ticket",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isLight
              ? const Color(0xFF2B124C)
              : const Color(0xFF632AAE),),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: isLight
                ? const Color(0xFF2B124C)
                : const Color(0xFF632AAE),),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children:
          [
            // Event Image Card
            Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image + Date Badge
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                        child: Image.asset(
                          "assets/event.jpg",
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            children: const [
                              Text("Dec",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              Text("31",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Brother's Gathering",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined,
                                color: isLight
                                    ? const Color(0xFF2B124C)
                                    : const Color(0xFF632AAE), size: 17),
                            const SizedBox(width: 4),
                            const Text(
                              "Lovers Inn, Lekki Lagos.",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Price
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 12, right: 12, bottom: 12),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "₦8000.00",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Ticket Selector
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Ticket",
                    style:
                    TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Brothers Gathering",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
                            SizedBox(height: 4),
                            Text("Max Order 5",
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      // Quantity Selector
                      Row(
                        children: [
                          _qtyButton(
                            icon: Icons.remove,
                            onTap: () {
                              if (quantity > 1) {
                                setState(() => quantity--);
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              quantity.toString(),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ),
                          _qtyButton(
                            icon: Icons.add,
                            onTap: () {
                              if (quantity < 5) {
                                setState(() => quantity++);
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Total Sum
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total Sum",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  Text(
                    "₦${price * quantity}.00",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Organizer Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage("assets/organizer.jpg"),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Mr Judeen Igwe",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                          Text("Organizer",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Text("View Profile",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: isLight
                                      ? const Color(0xFF2B124C)
                                      : const Color(0xFF632AAE),
                                )),
                            const SizedBox(width: 4),
                            Icon(Icons.arrow_forward_ios,
                                size: 14, color: isLight
                                  ? const Color(0xFF2B124C)
                                  : const Color(0xFF632AAE)),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    "About Brother's Gatherine\n\n"
                        "Passionate about fostering faith and community, I blend RCCG teachings with the power of faith to transform lives. "
                        "Together, we grow in Christ, embracing love, service, and spiritual wisdom in our daily lives. "
                        "Let’s journey in faith and purpose as one church family...",
                    style: TextStyle(height: 1.4, color: isLight ? Colors.black : Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.facebook, color: Colors.grey),
                      SizedBox(width: 14),
                      FaIcon(FontAwesomeIcons.whatsapp, color: Colors.grey),
                      SizedBox(width: 14),
                      Icon(Icons.call, color: Colors.grey),
                      SizedBox(width: 14),
                      Icon(Icons.email, color: Colors.grey),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 80),
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
                borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => TicketSuccessPage()));
          },
          child: const Text(
            "Make Payment",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
    );
  }
  Widget _qtyButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.surface),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(icon, size: 20),
      ),
    );
  }
}
