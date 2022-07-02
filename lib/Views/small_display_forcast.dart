import 'package:flutter/material.dart';

class SmallDisplayForcast extends StatelessWidget {
  const SmallDisplayForcast(
      {super.key,
      required this.imagePath,
      required this.forcastDay,
      required this.forcastMaxTemp,
      required this.forcastMinTemp});
  final String imagePath;
  final String forcastDay;
  final String forcastMaxTemp;
  final String forcastMinTemp;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      color: const Color(0xFF7D73E6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 0.8),
              child: Text(
                forcastDay.substring(0, forcastDay.length).toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.9,
                ),
                textScaleFactor: 0.9,
              ),
            ),
            Image(
              image: NetworkImage(imagePath),
              height: 40,
            ),
            Text(
              forcastMaxTemp,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              forcastMinTemp,
            ),
          ],
        ),
      ),
    );
  }
}
