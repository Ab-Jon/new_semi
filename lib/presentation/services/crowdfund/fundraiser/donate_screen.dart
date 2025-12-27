import 'package:flutter/material.dart';

class DonateScreen extends StatefulWidget {
  const DonateScreen({super.key});

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController messageCtrl = TextEditingController();

  final List<int> amounts = [100, 200, 300, 400];
  int selectedAmount = 100;
  bool anonymous = false;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "",
        ),
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.surface),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE CARD SECTION
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12)),
                    child: Image.network(
                      "https://picsum.photos/400/250",
                      height: 170,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Brother's Gathering",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Text(
                              "Victory Estate, Lagos",
                              style: TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                            const Spacer(),
                            Icon(Icons.favorite, color: isLight
                                ? const Color(0xFF2B124C)
                                : const Color(0xFF632AAE), size: 16),
                            const SizedBox(width: 4),
                            Text(
                              "200+ Supporters",
                              style:
                              TextStyle(color: isLight
                                  ? const Color(0xFF2B124C)
                                  : const Color(0xFF632AAE), fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            // SELECTED AMOUNT
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: 180,
                decoration: BoxDecoration(
                  color: isLight? Colors.grey.shade200 : Colors.black12,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "₦$selectedAmount",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // AMOUNT CHIPS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: amounts.map((amount) {
                final bool isSelected = selectedAmount == amount;
                return GestureDetector(
                  onTap: () {
                    setState(() => selectedAmount = amount);
                  },
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? isLight
                          ? const Color(0xFF2B124C)
                          : const Color(0xFF632AAE)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected
                            ? isLight
                            ? const Color(0xFF2B124C)
                            : const Color(0xFF632AAE)
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Text(
                      "₦$amount",
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : isLight? Colors.black : Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // NAME FIELD
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(
                hintText: "Your name",
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // MESSAGE FIELD
            TextField(
              controller: messageCtrl,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Write a message",
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // ANONYMOUS CHECKBOX
            Row(
              children: [
                Checkbox(
                  value: anonymous,
                  onChanged: (v) {
                    setState(() => anonymous = v!);
                  },
                  activeColor: isLight
                      ? const Color(0xFF2B124C)
                      : const Color(0xFF632AAE),
                ),
                const Text("Remain Anonymous"),
              ],
            ),
            const SizedBox(height: 20),
            // DONATE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLight ? const Color(0xFF2B124C) : const Color(0xFF632AAE),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Donate ₦$selectedAmount",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
