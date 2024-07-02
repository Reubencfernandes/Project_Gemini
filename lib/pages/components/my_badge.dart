import 'package:color_hash/color_hash.dart';
import 'package:flutter/cupertino.dart';

class MyBadge extends StatelessWidget {
  final String text;
  const MyBadge({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    Color badgeColor = ColorHash(text).toColor();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: lightenColor(badgeColor, 0.6),
          fontFamily: 'Inter',
          fontSize: 12,
        ),
      ),
    );
  }

  static Color lightenColor(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}
