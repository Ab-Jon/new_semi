import 'package:flutter/material.dart';

import '../airtime/airtime_summary.dart';

class CableTvScreen extends StatelessWidget {
  const CableTvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Cable Tv',
          style: TextStyle(
            color: isLight? Colors.black: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconTheme: IconThemeData(color: isLight? Colors.black : Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _bannerImage(),
              const SizedBox(height: 20),
              _formCard(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bannerImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        'https://images.pexels.com/photos/442150/pexels-photo-442150.jpeg',
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
        color: isLight? Colors.white: Colors.black,
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
          _label('Select Cable'),
          _dropdownField('DSTV', context),
          const SizedBox(height: 16),

          _label('Decoder Number'),
          _inputField('Enter decoder number', context),
          const SizedBox(height: 16),

          _label('Viewing Package'),
          _dropdownField('DSTV Access', context),
          const SizedBox(height: 16),

          _label('Name'),
          _inputField('Customer name', context),
          const SizedBox(height: 16),

          _label('Select Pricing Option'),
          _dropdownField('Select Pricing Option', context),
          const SizedBox(height: 16),

          _label('Amount'),
          const SizedBox(height: 8),

          _paymentButton(context),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }


  Widget _inputField(String hint, BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: isLight? Colors.grey.shade100: Colors.black54,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.centerLeft,
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: isLight? Colors.black:Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _dropdownField(String value, BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: isLight? Colors.grey.shade100: Colors.black54,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            value,
            style: TextStyle(color: isLight? Colors.black: Colors.white),
          ),
          const Spacer(),
          const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _paymentButton(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isLight
                       ? const Color(0xFF2B124C)
                       : const Color(0xFF632AAE),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        onPressed: () {
          showWithdrawalSheet(context);
        },
        child: const Text(
          'Make Payment',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}


