import 'package:flutter/material.dart';
import 'package:semi_bill/themes/app_theme.dart';

class AmountButton extends StatelessWidget {
  final int amount;
  final bool selected;
  final VoidCallback onTap;

  const AmountButton({
    super.key,
    required this.amount,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
        decoration: BoxDecoration(
          color: selected ? context.brand : context.iconWash,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          '₦$amount',
          style: TextStyle(
            color: selected ? Colors.white : context.brand,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
