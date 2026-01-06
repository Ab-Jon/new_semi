import 'package:flutter/material.dart';

import '../airtime/airtime_summary.dart';

class BettingScreen extends StatelessWidget {
  const BettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Betting',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [_banner(), const SizedBox(height: 16), _formCard(context)],
          ),
        ),
      ),
    );
  }

  Widget _banner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        'assets/images/casino.jpg',
        height: 120,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _formCard(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isLight ? Colors.white: Colors.black54,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label('Bet Provider'),
          _providerField(),
          const SizedBox(height: 16),

          _label('User ID'),
          _inputField('Enter your Sporty Bet User ID'),
          const SizedBox(height: 16),

          _label('Amount to pay'),
          const SizedBox(height: 4),
          const Text(
            '₦ 50 - 500,000',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          _amountCard(context),
          const SizedBox(height: 20),
          _payButton(context),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _providerField() {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          /// 🔹 LOGO PLACEHOLDER
          Image.asset(
              'assets/images/sporty.png',
              width: 24,
              height: 24),
          const SizedBox(width: 8),
          const Text('Sporty Bet'),
          const Spacer(),
          const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _inputField(String hint) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.centerLeft,
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _amountCard(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isLight ? Colors.white : Colors.black54,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: const [
          _AmountTile('₦200', 'Pay ₦200', selected: true),
          _AmountTile('₦500', 'Pay ₦500'),
          _AmountTile('₦1000', 'Pay ₦1000'),
          _AmountTile('₦500', 'Pay ₦500'),
          _AmountTile('₦1000', '36 Units'),
          _AmountTile('₦500', 'Pay ₦500'),
          _AmountTile('₦1000', 'Pay ₦1000'),
          _AmountTile('₦1000', 'Pay ₦1000'),
          _AmountTile('₦500', 'Pay ₦500'),
        ],
      ),
    );
  }
}

class _AmountTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool selected;

  const _AmountTile(this.title, this.subtitle, {this.selected = false});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: selected
            ? Border.all(color: isLight
            ? const Color(0xFF2B124C)
            : const Color(0xFF632AAE), width: 1.5)
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: selected ?
              isLight
                  ? const Color(0xFF2B124C)
                  : const Color(0xFF632AAE)
                  : Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

Widget _payButton(BuildContext context) {
  final isLight = Theme.of(context).brightness == Brightness.light;
  return SizedBox(
    width: double.infinity,
    height: 52,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isLight
            ? const Color(0xFF2B124C)
            : const Color(0xFF632AAE),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 0,
      ),
      onPressed: () {
        showWithdrawalSheet(context);
      },
      child: const Text(
        'Make Payment',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
