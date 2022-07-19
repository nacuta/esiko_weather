import 'package:flutter/material.dart';

class Sun extends StatelessWidget {
  const Sun({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 85,
      height: 100,
      child: Image.asset(
        'assets/sun.png',
        // fit: BoxFit.fitWidth,
        // width: 100,
        // height: 150,
      ),
    );
  }
}
