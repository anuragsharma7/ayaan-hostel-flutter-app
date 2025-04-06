import 'package:anayahostelapp/home_screen.dart';
import 'package:flutter/material.dart';

class TabBarCustom extends StatelessWidget {
  const TabBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const TabBarExample(),
    );
  }
}

class TabBarExample extends StatelessWidget {
  const TabBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          backgroundColor: Colors.blue.shade100,
          bottom: TabBar(
            dividerColor: Colors.transparent,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.girl_rounded)),
              Tab(icon: Icon(Icons.people_alt_rounded)),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(child: HomeScreen()),
            Center(child: Text("Staff list")),
          ],
        ),
      ),
    );
  }
}
