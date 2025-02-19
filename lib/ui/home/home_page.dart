import 'package:flutter/material.dart';
import 'package:route_aware/data/app_counter.dart';
import 'package:route_aware/ui/config/config_page.dart';
import 'package:route_aware/ui/home/tab_counter/tab_counter_page.dart';
import 'package:route_aware/ui/home/tab_other/tab_other_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final app = AppCounter.instance;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    app.dispose();
    _tabController.dispose();

    super.dispose();
  }

  void _toConfigPage() {
    Navigator.pushNamed(context, ConfigPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Home'),
        centerTitle: true,
        bottom: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.account_balance)),
            Tab(icon: Icon(Icons.bolt)),
          ],
          controller: _tabController,
        ),
        actions: [
          IconButton(icon: Icon(Icons.settings), onPressed: _toConfigPage),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [TabCounterPage(), TabOtherPage()],
      ),
    );
  }
}
