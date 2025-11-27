import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class GiftUserPage extends StatefulWidget {
  const GiftUserPage({super.key});

  @override
  State<GiftUserPage> createState() => _GiftUserPageState();
}

class _GiftUserPageState extends State<GiftUserPage> {
  bool anonymous = false;
  int? selectedAmount;

  final List<int> quickAmounts = [200, 500, 1000, 5000, 10000, 500];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text("Gift User"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Ionicons.notifications_outline),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// BANNER
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                "https://images.unsplash.com/photo-1607083206604-f3e490acb5fa",
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16),

            /// FORM CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// RECIPIENT ID
                  const Text("Recipient ID",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),

                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter your SensiBill User ID",
                      filled: true,
                      fillColor: const Color(0xFFF4F5F7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// DESCRIPTION
                  const Text("Description",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Write a message",
                      filled: true,
                      fillColor: const Color(0xFFF4F5F7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// CHECKBOX
                  Row(
                    children: [
                      Checkbox(
                          value: anonymous,
                          onChanged: (v) => setState(() => anonymous = v!)),
                      const Text("Remain Anonymous")
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// AMOUNT RANGE
                  const Text("Amount to pay",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text("₦ 50 - 500,000",
                      style: TextStyle(color: Colors.grey)),

                  const SizedBox(height: 10),

                  /// AMOUNT CARDS
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: quickAmounts
                        .map((amount) => GestureDetector(
                      onTap: () =>
                          setState(() => selectedAmount = amount),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedAmount == amount
                                ? Colors.deepPurple
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "₦$amount",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("Pay ₦$amount",
                                style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ))
                        .toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// MAKE PAYMENT BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 14)),
                onPressed: () {},
                child: const Text("Make Payment"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
