import 'package:flutter/material.dart';

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
    final isLight = Theme.of(context).brightness == Brightness.light;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
        decoration: BoxDecoration(
          color: selected
              ? isLight
              ? const Color(0xFF2B124C)
              : const Color(0xFF632AAE)
              : Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: selected ? isLight
                ? const Color(0xFF2B124C)
                : const Color(0xFF632AAE) : isLight
                ? const Color(0xFF2B124C)
                : const Color(0xFF632AAE),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          "₦$amount",
          style: TextStyle(
            color: selected ? Colors.white : isLight
                ? const Color(0xFF2B124C)
                : const Color(0xFF632AAE) ,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
