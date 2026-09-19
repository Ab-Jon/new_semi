import 'package:flutter/material.dart';
import 'package:semi_bill/presentation/services/data/data_amount.dart';
import 'package:semi_bill/themes/app_theme.dart';
import 'package:semi_bill/ui/ionicons.dart';
import 'package:semi_bill/ui/semi_ui.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        backgroundColor: context.pageBg,
        leading: const SemiBackButton(),
        title: const Text('Data'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          SemiCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.asset(
                    'assets/images/gift_banner.jpg',
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
                  child: Row(
                    children: [
                      const SemiAvatar(size: 40),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text('09045667844', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                      ),
                      Container(
                        decoration: BoxDecoration(color: context.iconWash, shape: BoxShape.circle),
                        padding: const EdgeInsets.all(8),
                        child: Icon(Ionicons.heart_outline, color: context.brand, size: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SemiCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select Network', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _network('MTN', 'assets/images/mtn.png', context),
                    _network('9 Mobile', 'assets/images/9mobile.png', context),
                    _network('Airtel', 'assets/images/airtel.png', context),
                    _network('Glo', 'assets/images/glo.png', context),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SemiCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select Beneficiary', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                const SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search beneficiary',
                    prefixIcon: Icon(Ionicons.search_outline, color: context.brand),
                  ),
                ),
                const SizedBox(height: 8),
                _beneficiary('08134243438'),
                Divider(color: context.hairline),
                _beneficiary('08134243438'),
                Divider(color: context.hairline),
                _beneficiary('08134243438'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SemiButton(
            label: 'Proceed',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const DataDetailsScreen()));
            },
          ),
        ],
      ),
    );
  }

  Widget _network(String name, String asset, BuildContext context) {
    return Column(
      children: [
        Container(
          height: 52,
          width: 52,
          decoration: BoxDecoration(
            color: context.iconWash,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(8),
          child: Image.asset(asset, fit: BoxFit.contain),
        ),
        const SizedBox(height: 6),
        Text(name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _beneficiary(String phone) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const SemiAvatar(size: 40),
      title: Text(phone, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}
