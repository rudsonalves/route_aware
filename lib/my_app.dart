import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

import 'my_app.route.dart';

part 'my_app.g.dart';

@Main('lib/ui')
class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
