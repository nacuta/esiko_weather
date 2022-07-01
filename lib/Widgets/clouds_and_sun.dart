import 'package:flutter/material.dart';
import 'package:testingbloc/Widgets/clouds.dart';
import 'package:testingbloc/Widgets/sun.dart';

class CloudAndSun extends StatelessWidget {
  const CloudAndSun({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 180,
        height: 180,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            const Sun(),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: const Color.fromARGB(137, 138, 137, 137)
                          .withOpacity(0.2),
                      spreadRadius: 10,
                      blurRadius: 50,
                      offset: const Offset(0, 50))
                ],
              ),
              margin: const EdgeInsets.only(top: 50),
              child: const Clouds(),
            )
          ],
        ));
  }
}
