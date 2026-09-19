import 'package:flutter/material.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/ui/ionicons.dart';
import 'package:semi_bill/ui/semi_ui.dart';

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
  void dispose() {
    nameCtrl.dispose();
    messageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        backgroundColor: context.pageBg,
        leading: const SemiBackButton(),
        title: const Text('Donate'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          SemiCard(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.asset(
                    'assets/event.jpg',
                    height: 168,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(height: 168, color: context.iconWash),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Brother's Gathering",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Ionicons.location_outline, size: 15, color: context.brand),
                          const SizedBox(width: 4),
                          Text(
                            'Victory Estate, Lagos',
                            style: TextStyle(color: context.semi.muted, fontSize: 13),
                          ),
                          const Spacer(),
                          Icon(Ionicons.heart, size: 14, color: context.brand),
                          const SizedBox(width: 4),
                          Text(
                            '200+ Supporters',
                            style: TextStyle(color: context.brand, fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              width: 180,
              decoration: BoxDecoration(
                color: context.iconWash,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '₦$selectedAmount',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: amounts.map((amount) {
              final selected = selectedAmount == amount;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: GestureDetector(
                    onTap: () => setState(() => selectedAmount = amount),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: selected ? context.brand : context.iconWash,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '₦$amount',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selected ? Colors.white : context.brand,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          SemiField(controller: nameCtrl, hint: 'Your name'),
          const SizedBox(height: 12),
          TextField(
            controller: messageCtrl,
            maxLines: 3,
            decoration: const InputDecoration(hintText: 'Write a message'),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Checkbox(
                value: anonymous,
                activeColor: context.brand,
                onChanged: (v) => setState(() => anonymous = v ?? false),
              ),
              const Text('Remain Anonymous'),
            ],
          ),
          const SizedBox(height: 8),
          SemiButton(
            label: 'Donate ₦$selectedAmount',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Donation of ₦$selectedAmount recorded')),
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
