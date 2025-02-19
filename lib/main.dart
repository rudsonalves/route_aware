import 'package:flutter/material.dart';
import 'package:route_aware/data/app_counter.dart';
import 'package:route_aware/my_app.dart';

void main() async {
  // Initialize Flutter binding
  WidgetsFlutterBinding.ensureInitialized();

  final app = AppCounter.instance;
  await app.initialize();

  runApp(const MyApp());
}
