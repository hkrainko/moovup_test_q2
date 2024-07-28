import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moovup_test/presentation/routes/route.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell _navigationShell;

  const ScaffoldWithNavBar({super.key, required navigationShell})
      : _navigationShell = navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navigationShell,
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'List',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Map',
        ),
      ],
      currentIndex: _navigationShell.currentIndex,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        // Handle navigation to the page
        switch (index) {
          case 0:
            HomeRoute().go(context);
            break;
          case 1:
            MapRoute().go(context);
            break;
        }
      },
    );
  }
}
