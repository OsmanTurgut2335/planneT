//nav routera falan değiştirmek ?

import 'package:allplant/core/constants/app_colors.dart';
import 'package:allplant/pages/add_plant.dart';
import 'package:allplant/pages/calendar_screen.dart';
import 'package:allplant/pages/home_screen.dart';
import 'package:allplant/pages/my_plants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        // GoRouterState.uri, geçerli URI bilgisini verir.
        final currentLocation = state.uri.path;
        int currentIndex = 0;
        if (currentLocation.startsWith('/plants')) {
          currentIndex = 1;
        } else if (currentLocation.startsWith('/calendar')) {
          currentIndex = 2;
        }
        return Scaffold(body: child, bottomNavigationBar: CustomBottomNavBar(currentIndex: currentIndex));
      },
      routes: [
        GoRoute(path: '/', name: 'home', builder: (BuildContext context, GoRouterState state) => const HomeScreen()),
        GoRoute(
          path: '/plants',
          name: 'plants',
          builder: (BuildContext context, GoRouterState state) => const MyPlantsScreen(),
        ),
        GoRoute(
          path: '/calendar',
          name: 'calendar',
          builder: (BuildContext context, GoRouterState state) => const CalendarScreen(),
        ),
        GoRoute(
          path: '/add-plant',
          name: 'addPlant',
          builder: (BuildContext context, GoRouterState state) => const AddPlantScreen(), // Bitki ekleme ekranı
        ),
      ],
    ),
  ],
);

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        
        color: AppColors.deepPine, // Background color
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), // Adds padding around nav bar
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        
        backgroundColor: Colors.transparent, // Keeps container background
        elevation: 0, // Removes shadow
        selectedItemColor: AppColors.navBarIconColor, // Icon color when selected
        unselectedItemColor: AppColors.navBarIconColor.withValues(alpha:  0.7), // Dimmed for unselected

        type: BottomNavigationBarType.fixed, // Keeps icons static in place
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/plants');
              break;
            case 2:
              context.go('/calendar');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home,), label: 'Ev'),
          //  BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Plant'),
          BottomNavigationBarItem(icon: Icon(Icons.local_florist), label: 'Bitkilerim'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Takvim'),
        ],
      ),
    );
  }
}
