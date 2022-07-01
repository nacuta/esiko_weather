import 'package:flutter/material.dart';

class Sun extends StatelessWidget {
  const Sun({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 105,
      height: 200,
      child: Image.asset(
        'assets/sun.png',
        fit: BoxFit.fitWidth,
        width: 200,
        height: 300,
      ),
    );
  }
}
