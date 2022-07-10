import 'package:flutter/material.dart';
import 'package:testingbloc/chart.dart';
import 'package:testingbloc/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi Bloc provider',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(body: HomePageInitial()),
    );
  }
}
