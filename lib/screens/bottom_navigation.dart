import 'package:agile_tech/controllers/bottom_navigation_controller.dart';
import 'package:agile_tech/screens/home_screen.dart';
import 'package:agile_tech/screens/profile_screen.dart';
import 'package:agile_tech/screens/reports_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(BottomNavigationController());

    return GetBuilder<BottomNavigationController>(
      builder: (context) {
        return Scaffold(
          body: IndexedStack(
            index: controller.tabIndex,
            children: const [
              HomePage(),
              ReportsScreen(),
              ProfileScreen()
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.redAccent,
            unselectedItemColor: Colors.grey,
            currentIndex: controller.tabIndex,
            onTap: controller.changeTabIndex,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.construction),
                label: 'Equipos',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.edit_note),
                label: 'Reportes',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_2_rounded),
                label: 'Pérfil',
              )
            ],
          ),
        );
      }
    );
  }
}