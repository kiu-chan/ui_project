import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

// Color
const Color primaryColor = Color.fromRGBO(56, 175, 127, 1);
const Color textColor = Color(0xFF333333);
const Color secondColor = Color.fromRGBO(234, 255, 247, 1);

// Text style
final TextStyle appBarStyle = TextStyle(
  fontSize: 22,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

final TextStyle headLineStyle = TextStyle(
  fontSize: 18,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

final TextStyle bodyStyle = TextStyle(
  fontSize: 18,
  color: textColor,
);

final TextStyle viewAllStyle = TextStyle(
  fontSize: 18,
  color: primaryColor,
);

final TextStyle headStyle = TextStyle(
  fontSize: 22,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

// Back button
class back extends StatelessWidget {
  const back({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          LucideIcons.arrowLeft,
        ),
      ),
    );
  }
}
