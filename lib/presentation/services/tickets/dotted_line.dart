import 'package:flutter/material.dart';

class DottedLine extends StatelessWidget {
  final double height;
  final double spacing;
  final double thickness;
  final Color color;

  const DottedLine({
    super.key,
    this.height = 1,
    this.spacing = 6,
    this.thickness = 3,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        int count = (width / (spacing + thickness)).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            count,
                (_) => Container(
              width: thickness,
              height: height,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      },
    );
  }
}
