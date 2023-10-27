import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MainLayout(),
    );
  }
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Emplman")),
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          Center(child: Text("Employees")),
          Center(child: Text("Eligible")),
          Center(child: Text("Managers")),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            label: "Employees",
            icon: Icon(FluentIcons.people_team_24_regular),
            activeIcon: Icon(FluentIcons.people_team_24_filled),
          ),
          BottomNavigationBarItem(
            label: "Eligible",
            icon: Icon(FluentIcons.person_add_24_regular),
            activeIcon: Icon(FluentIcons.person_add_24_filled),
          ),
          BottomNavigationBarItem(
            label: "Managers",
            icon: Icon(FluentIcons.person_24_regular),
            activeIcon: Icon(FluentIcons.person_24_filled),
          ),
        ],
      ),
    );
  }
}
