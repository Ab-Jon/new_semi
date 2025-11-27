import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class BettingPage extends StatefulWidget {
  const BettingPage({super.key});

  @override
  State<BettingPage> createState() => _BettingPageState();
}

class _BettingPageState extends State<BettingPage> {
  String? selectedProvider = "Sporty Bet";
  List<String> providers = ["Sporty Bet", "Bet9ja", "BetKing"];

  int? selectedAmount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Betting"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// TOP BANNER
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                "https://images.unsplash.com/photo-1519677100203-a0e668c92439",
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
                  /// BET PROVIDER
                  const Text("Bet Provider",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedProvider,
                        items: providers
                            .map((p) => DropdownMenuItem(
                          value: p,
                          child: Row(
                            children: [
                              const Icon(Ionicons.shield_checkmark),
                              const SizedBox(width: 8),
                              Text(p),
                            ],
                          ),
                        ))
                            .toList(),
                        onChanged: (val) {
                          setState(() => selectedProvider = val);
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// USER ID
                  const Text("User ID",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter your Sporty Bet User ID",
                      filled: true,
                      fillColor: const Color(0xFFF4F5F7),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// AMOUNT RANGE
                  const Text("Amount to pay",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text("₦ 50 - 500,000",
                      style: TextStyle(color: Colors.grey)),

                  const SizedBox(height: 12),

                  /// PRESET AMOUNTS
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [200, 500, 1000, 5000, 10000, 500]
                        .map((amount) => GestureDetector(
                      onTap: () =>
                          setState(() => selectedAmount = amount),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: selectedAmount == amount
                                ? Colors.deepPurple
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "₦$amount",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("Pay ₦$amount"),
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

            /// BUTTON
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
