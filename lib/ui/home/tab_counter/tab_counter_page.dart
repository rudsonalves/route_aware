import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:route_aware/data/app_counter.dart';

class TabCounterPage extends StatefulWidget {
  const TabCounterPage({super.key});

  @override
  State<TabCounterPage> createState() => _TabCounterPageState();
}

class _TabCounterPageState extends State<TabCounterPage>
    with AutomaticKeepAliveClientMixin {
  final app = AppCounter.instance;

  @override
  void initState() {
    super.initState();

    app.message.addListener(_newMessage);
  }

  void _newMessage() {
    if (app.message.value == MessageType.changeValue) {
      log('Change value');
      app.setMessageType(MessageType.none);
      app.reloadCounter();
      setState(() {});
    }
  }

  @override
  void dispose() {
    app.message.removeListener(_newMessage);

    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            ValueListenableBuilder(
              valueListenable: app.counter,
              builder: (context, value, _) {
                return Text(
                  '$value',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: app.incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
