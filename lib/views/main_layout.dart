import 'package:emplman/features/employees/widgets/employees_list.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

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
          EmployeesList(),
          Center(child: Text("Eligible")),
          Center(child: Text("Managers")),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _currentIndex,
      //   onTap: (index) => setState(() => _currentIndex = index),
      //   items: const [
      //     BottomNavigationBarItem(
      //       label: "Employees",
      //       icon: Icon(FluentIcons.people_team_24_regular),
      //       activeIcon: Icon(FluentIcons.people_team_24_filled),
      //     ),
      //     BottomNavigationBarItem(
      //       label: "Eligible",
      //       icon: Icon(FluentIcons.person_add_24_regular),
      //       activeIcon: Icon(FluentIcons.person_add_24_filled),
      //     ),
      //     BottomNavigationBarItem(
      //       label: "Managers",
      //       icon: Icon(FluentIcons.person_24_regular),
      //       activeIcon: Icon(FluentIcons.person_24_filled),
      //     ),
      //   ],
      // ),
      bottomNavigationBar: SlidingClippedNavBar(
        selectedIndex: _currentIndex,
        onButtonPressed: (index) => setState(() => _currentIndex = index),
        activeColor: Theme.of(context).colorScheme.primary,
        inactiveColor: Theme.of(context).colorScheme.onSurface,
        backgroundColor: Theme.of(context).colorScheme.surface,
        barItems: [
          BarItem(icon: FluentIcons.people_team_24_regular, title: "Employees"),
          BarItem(icon: FluentIcons.person_add_24_regular, title: "Eligible"),
          BarItem(icon: FluentIcons.grid_24_regular, title: "Departments"),
        ],
      ),
    );
  }
}
