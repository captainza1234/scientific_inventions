  import 'package:flutter/material.dart';
  import 'package:hive_flutter/hive_flutter.dart';
  import 'screens/home_page.dart';
  import 'screens/add_page.dart';

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    await Hive.openBox('inventionsBox'); // เปิดฐานข้อมูล Hive
    runApp(const MyApp());
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Science Invention App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/add': (context) => const AddPage(),
        },
      );
    }
  }
