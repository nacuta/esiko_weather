import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testingbloc/bloc/data_from_json_bloc.dart';
import 'package:testingbloc/chart.dart';
import 'package:testingbloc/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi Bloc provider',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          body: BlocProvider(
        create: (context) => DataFromJsonBloc()..add(GetListFromJson('Arad')),
        child: const HomePageInitial(),
      )),
    );
  }
}
