import 'package:flutter/material.dart';
import 'package:route_aware/data/app_counter.dart';
import 'package:routefly/routefly.dart';

import 'my_app.route.dart';

part 'my_app.g.dart';

@Main('lib/ui')
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
    return MaterialApp.router(
      routerConfig: Routefly.routerConfig(
        routes: routes,
        initialPath: routePaths.home.path,
      ),

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
