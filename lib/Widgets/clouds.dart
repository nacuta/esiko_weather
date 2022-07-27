import 'package:flutter/material.dart';

class Clouds extends StatelessWidget {
  const Clouds({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Image.asset(
        'assets/cloud.png',
        // fit: BoxFit.fitWidth,
        // width: 200,
        // height: 300,
        color: Colors.white70.withOpacity(1),
      ),
    );
  }
}
