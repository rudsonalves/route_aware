import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum MessageType { changeValue, none }

class AppCounter {
  AppCounter._();
  static final _instance = AppCounter._();
  static AppCounter get instance => _instance;

  late final SharedPreferences prefs;

  final _message = ValueNotifier<MessageType>(MessageType.none);
  final _counter = ValueNotifier<int>(0);

  final RouteObserver<PageRoute> _routeObserver = RouteObserver<PageRoute>();

  ValueNotifier<MessageType> get message => _message;
  ValueNotifier<int> get counter => _counter;
  RouteObserver get routeObserver => _routeObserver;

  void dispose() {
    _counter.dispose();
    _message.dispose();
  }

  Future<void> initialize() async {
    prefs = await SharedPreferences.getInstance();

    reloadCounter();
  }

  Future<void> reloadCounter() async {
    // read value
    final value = readValue();

    // set value
    if (value != null) {
      _counter.value = value;
    }
  }

  void setMessageType(MessageType type) {
    _message.value = type;
  }

  void sendMessage(MessageType type) {
    _message.value = type;
  }

  int? readValue() {
    return prefs.getInt('counter');
  }

  Future<void> saveValue(int value) async {
    await prefs.setInt('counter', value);
  }

  Future<void> incrementCounter() async {
    _counter.value++;
    await saveValue(_counter.value);
  }

  Future<void> decrementCounter() async {
    _counter.value--;
    await saveValue(_counter.value);
  }
}
