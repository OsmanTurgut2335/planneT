import 'package:allplant/core/constants/app_colors.dart';
import 'package:allplant/features/models/plant.dart';
import 'package:allplant/features/pages/add_plant.dart';
import 'package:allplant/features/pages/calendar_screen.dart';
import 'package:allplant/features/pages/home_screen.dart';
import 'package:allplant/features/pages/my_plants.dart';
import 'package:allplant/features/pages/plant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        final currentLocation = state.uri.path;
        int currentIndex = 0;

        if (currentLocation.startsWith('/plants') || currentLocation.startsWith('/plant-detail')) {
          currentIndex = 1; // Ensure detail screens also highlight "Plants"
        } else if (currentLocation.startsWith('/calendar')) {
          currentIndex = 2;
        }

        return Scaffold(body: child, bottomNavigationBar: CustomBottomNavBar(currentIndex: currentIndex));
      },
      routes: [
        GoRoute(path: '/', name: 'home', builder: (context, state) => const HomeScreen()),
        GoRoute(path: '/plants', name: 'plants', builder: (context, state) => const MyPlantsScreen()),
        GoRoute(path: '/calendar', name: 'calendar', builder: (context, state) => const CalendarScreen()),
        GoRoute(path: '/add-plant', name: 'addPlant', builder: (context, state) => const AddPlantScreen()),

        // 🌱 Plant Detail Screen (Inside ShellRoute, so it has NavBar)
        GoRoute(
          path: '/plant-detail/:id',
          name: 'plantDetail',
          builder: (context, state) {
            if (state.extra == null || state.extra is! Plant) {
              return const Scaffold(extendBody: true, body: Center(child: Text('Error: No plant data found.')));
            }

            final plant = state.extra as Plant;
            return PlantDetailScreen(plant: plant);
          },
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
      decoration: const BoxDecoration(
        color: AppColors.deepPine,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Theme(
        data: Theme.of(context).copyWith(
          // Splash efektini kaldır
          splashFactory: NoSplash.splashFactory,
          // Highlight (dokunma anındaki parlama) efektini kaldır
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: AppColors.deepPine,
          currentIndex: currentIndex,
          selectedItemColor: AppColors.navBarIconColor,
          unselectedItemColor: AppColors.navBarIconColor.withOpacity(0.7),
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            switch (index) {
              case 0:
                context.go('/');
              case 1:
                context.go('/plants');
              case 2:
                context.go('/calendar');
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ev'),
            BottomNavigationBarItem(icon: Icon(Icons.local_florist), label: 'Bitkilerim'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Takvim'),
          ],
        ),
      ),
    );
  }
}
