import 'package:flutter/material.dart';
import 'package:semi_bill/presentation/services/electricity/electricity_summary.dart';

class ElectricityScreen extends StatefulWidget {
  const ElectricityScreen({super.key});

  @override
  State<ElectricityScreen> createState() => _CableTvScreenState();
}

class _CableTvScreenState extends State<ElectricityScreen> {
  final List<String> providers = [
    "Ikeja Electricity Distro Prepaid account",
    "Abuja Electricity Distribution Company",
    "Eko Electricity Distribution Company",
  ];

  String selectedProvider = "Ikeja Electricity Distro Prepaid account";
  String meterNumber = "";
  int selectedAmountIndex = 0;

  final List<Map<String, dynamic>> amountOptions = [
    {"amount": "N200", "unit": "10 units"},
    {"amount": "N5000", "unit": "24 units"},
    {"amount": "N1000", "unit": "36 units"},

    {"amount": "N5000", "unit": "24 units"},
    {"amount": "N1000", "unit": "36 units"},
    {"amount": "N5000", "unit": "24 units"},

    {"amount": "N1000", "unit": "38 units"},
    {"amount": "N1000", "unit": "36 units"},
    {"amount": "N5000", "unit": "24 units"},
  ];

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface, // close to the purple shown
      appBar: AppBar(
        title: const Text("Electricity"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            /// TOP BANNER IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "https://images.unsplash.com/photo-1581093448798-5f8e3be1d0d1",
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 15),
            /// WHITE MAIN CONTAINER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// SERVICE PROVIDER LABEL
                  const Text(
                    "Service Provider",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  /// DROPDOWN
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: isLight
                          ? const Color(0xFF2B124C)
                          : const Color(0xFF632AAE)),
                    ),
                    child: DropdownButton<String>(
                      value: selectedProvider,
                      isExpanded: true,
                      underline: Container(),
                      items: providers.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (v) {
                        setState(() => selectedProvider = v!);
                      },
                    ),
                  ),
                  const SizedBox(height: 18),
                  /// METER NUMBER LABEL
                  const Text(
                    "Metre Number",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  /// TEXTFIELD
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter your meter number",
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (v) => meterNumber = v,
                  ),
                  const SizedBox(height: 18),
                  /// AMOUNT LABEL
                  const Text(
                    "Amount to pay",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "N 50 - 500,000",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  /// GRID OF AMOUNTS
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: amountOptions.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final item = amountOptions[index];
                      final isSelected = selectedAmountIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() => selectedAmountIndex = index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                            isSelected ? isLight
                                ? const Color(0xFF2B124C)
                                : const Color(0xFF632AAE) : Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color:
                              isSelected ? Colors.deepPurple : Colors.grey.shade300,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item["amount"],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.white : isLight? Colors.black: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item["unit"],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isSelected ? Colors.white70 : isLight? Colors.black: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// MAKE PAYMENT BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ElectricitySummaryScreen(
                          amount: 100,
                          phone: "",
                          network: "MTN")
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLight
                      ? const Color(0xFF2B124C)
                      : const Color(0xFF632AAE),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Make Payment",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
