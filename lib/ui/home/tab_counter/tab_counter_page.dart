import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:route_aware/data/app_counter.dart';

class TabCounterPage extends StatefulWidget {
  const TabCounterPage({super.key});

  static const routeName = '/tab_counter';

  @override
  State<TabCounterPage> createState() => _TabCounterPageState();
}

class _TabCounterPageState extends State<TabCounterPage>
    with AutomaticKeepAliveClientMixin, RouteAware {
  final app = AppCounter.instance;

  bool _shouldRefresh = false;

  @override
  void initState() {
    super.initState();

    app.message.addListener(_newMessage);
  }

  void _newMessage() {
    if (app.message.value == MessageType.changeValue && !_shouldRefresh) {
      _shouldRefresh = true;
      log('Change value');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Subscreva a rota atual para ser notificado
    final ModalRoute<dynamic>? route = ModalRoute.of(context);
    if (route is PageRoute) {
      app.routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    app.routeObserver.unsubscribe(this);
    app.message.removeListener(_newMessage);

    super.dispose();
  }

  @override
  void didPopNext() {
    if (_shouldRefresh) {
      _shouldRefresh = false;
      app.sendMessage(MessageType.none);
      app.reloadCounter();
      setState(() {});
    }
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
