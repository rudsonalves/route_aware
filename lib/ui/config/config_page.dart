import 'package:flutter/material.dart';
import 'package:route_aware/data/app_counter.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  static const routeName = '/config';

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final app = AppCounter.instance;
  late final ValueNotifier<int> counter;

  @override
  void initState() {
    super.initState();

    final value = app.readValue();
    if (value != null) {
      counter = ValueNotifier(value);
    }
  }

  Future<void> _incrementCounter() async {
    counter.value++;
    app.sendMessage(MessageType.changeValue);
  }

  Future<void> _decrementCounter() async {
    counter.value--;
    app.sendMessage(MessageType.changeValue);
  }

  Future<void> _resetCounter() async {
    counter.value = 0;
    app.sendMessage(MessageType.changeValue);
  }

  Future<void> _backToHome() async {
    app.saveValue(counter.value);
    await Future.delayed(Duration(milliseconds: 400));
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Config'),
        centerTitle: true,
        elevation: 5,
        leading: IconButton(
          onPressed: _backToHome,
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton.filled(
                onPressed: _incrementCounter,
                icon: Icon(Icons.add),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ValueListenableBuilder(
                  valueListenable: counter,
                  builder: (context, value, _) {
                    return Text(
                      value.toString(),
                      style: TextStyle(fontSize: 32),
                    );
                  },
                ),
              ),
              IconButton.filled(
                onPressed: _decrementCounter,
                icon: Icon(Icons.remove),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: FilledButton(onPressed: _resetCounter, child: Text('Reset')),
          ),
        ],
      ),
    );
  }
}
