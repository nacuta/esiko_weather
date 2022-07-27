import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testingbloc/bloc/data_from_json_bloc.dart';
import 'package:testingbloc/bloc/searchBloc/search_bloc.dart';
import 'package:testingbloc/chart.dart';
import 'package:testingbloc/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ); // To turn off landscape mode
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
          body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                DataFromJsonBloc()..add(GetListFromJson('Arad')),
          ),
          BlocProvider(
            create: (context) => SearchBloc(),
          ),
        ],
        child: const HomePageInitial(),
      )),
    );
  }
}
