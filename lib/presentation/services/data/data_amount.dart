import 'package:flutter/material.dart';

import '../../wallet/transfer/widget/pin_screen.dart';

class DataDetailsScreen extends StatefulWidget {
  const DataDetailsScreen({super.key});

  @override
  State<DataDetailsScreen> createState() => _DataDetailsScreenState();
}

class _DataDetailsScreenState extends State<DataDetailsScreen> {
  int selectedIndex = 0;
  int selectedPlanIndex = -1;

  final tabs = ["Hot", "Daily", "Weekly", "Monthly"];

  final dailyPlans = [
    {"size": "200MB", "duration": "3 Days", "price": "₦200.00"},
    {"size": "500MB", "duration": "3 Days", "price": "₦200.00"},
    {"size": "1000MB", "duration": "3 Days", "price": "₦200.00"},
    {"size": "500MB", "duration": "3 Days", "price": "₦200.00"},
    {"size": "500MB", "duration": "3 Days", "price": "₦200.00"},
    {"size": "1000MB", "duration": "3 Days", "price": "₦200.00"},
    {"size": "200MB", "duration": "3 Days", "price": "₦200.00"},
    {"size": "350MB", "duration": "3 Days", "price": "₦200.00"},
    {"size": "1000MB", "duration": "3 Days", "price": "₦200.00"},
  ];

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Data Details",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // TOP USER ↔ NETWORK CARD
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left user
                  Column(
                    children: [
                      const CircleAvatar(
                        radius: 22,
                        backgroundImage: AssetImage("assets/images/gift_banner.jpg"),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Unwana Jr Chikamso",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                      const Text(
                        "₦120,000",
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                  Icon(Icons.compare_arrows, size: 28, color: isLight
                      ? const Color(0xFF2B124C)
                      : const Color(0xFF632AAE),),
                  // Right network
                  Column(
                    children: [
                      Image.asset(
                        "assets/images/mtn.png",
                        height: 35,
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "08122334456",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // SELECT DATA PLAN CARD
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select data Plan",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  // Search input
                  Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: isLight
                            ? const Color(0xFF2B124C)
                            : const Color(0xFF632AAE),),
                        const SizedBox(width: 8),
                        const Text("search"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Tabs
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(tabs.length, (i) {
                      final isSelected = selectedIndex == i;
                      return GestureDetector(
                        onTap: () => setState(() => selectedIndex = i),
                        child: Column(
                          children: [
                            Text(
                              tabs[i],
                              style: TextStyle(
                                fontWeight:
                                isSelected ? FontWeight.w700 : FontWeight.w500,
                                color: isSelected ? Colors.white : Colors.grey,
                              ),
                            ),
                            if (isSelected)
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                height: 3,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: isLight
                                      ? const Color(0xFF2B124C)
                                      : const Color(0xFF632AAE),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                          ],
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  // GRID OF DATA PLANS
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dailyPlans.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.95,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      final item = dailyPlans[index];
                      final isSelected = selectedPlanIndex == index;
                      return GestureDetector(
                        onTap: () => setState(() => selectedPlanIndex = index),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? isLight
                                  ? const Color(0xFF2B124C)
                                  : const Color(0xFF632AAE)
                                  : Colors.grey.shade300,
                              width: isSelected ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(item["size"]!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600, fontSize: 13)),
                              Text(item["duration"]!,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 11)),
                              const SizedBox(height: 4),
                              Text(item["price"]!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600, fontSize: 12)),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            const SizedBox(height: 25),
            // PROCEED BUTTON
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLight
                      ? const Color(0xFF2B124C)
                      : const Color(0xFF632AAE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: selectedPlanIndex == -1 ? null : () {
                  Navigator.pop(context);
                  // Open PIN screen
                  PaymentHelpers.showPinSheet(context, amount: 100
                  );
                },
                child: const Text("Proceed", style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
