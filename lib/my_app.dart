import 'package:flutter/material.dart';
import 'package:route_aware/data/app_counter.dart';
import 'package:route_aware/ui/config/config_page.dart';
import 'package:route_aware/ui/home/home_page.dart';
import 'package:route_aware/ui/home/tab_counter/tab_counter_page.dart';
import 'package:route_aware/ui/home/tab_other/tab_other_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final app = AppCounter.instance;

  @override
  void initState() {
    super.initState();

    app.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (_) => const HomePage(),
        TabCounterPage.routeName: (_) => const TabCounterPage(),
        TabOtherPage.routeName: (_) => const TabOtherPage(),
        ConfigPage.routeName: (_) => const ConfigPage(),
      },
    );
  }
}
