import 'package:aegis/screens/contact.dart';
import 'package:aegis/screens/history.dart';
import 'package:aegis/screens/home.dart';
import 'package:aegis/screens/profile.dart';
import 'package:aegis/themes/app_colors.dart';
import 'package:aegis/themes/app_fonts.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [Home(), Contact(), History(), Profile()];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: pages[_currentIndex],
      ),
      bottomNavigationBar: NavigationBar(
        height: 64,
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.background,
        selectedIndex: _currentIndex,
        labelTextStyle: WidgetStatePropertyAll(
          AppFonts.caption.copyWith(color: AppColors.primary),
        ),
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: AppColors.muted),
            selectedIcon: Icon(Icons.home_rounded, color: AppColors.primary),
            label: 'Home',
            tooltip: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.group_outlined, color: AppColors.muted),
            selectedIcon: Icon(Icons.group_rounded, color: AppColors.primary),
            label: 'Contacts',
            tooltip: 'Contacts',
          ),
          NavigationDestination(
            icon: Icon(Icons.history, color: AppColors.muted),
            selectedIcon: Icon(Icons.history_rounded, color: AppColors.primary),
            label: 'History',
            tooltip: 'History',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline, color: AppColors.muted),
            selectedIcon: Icon(Icons.person, color: AppColors.primary),
            label: 'Profile',
            tooltip: 'Profile',
          ),
        ],
      ),
    );
  }
}
