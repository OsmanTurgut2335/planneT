import 'package:allplant/core/router/app_router.dart';
import 'package:allplant/features/pages/add_plant.dart';
import 'package:allplant/features/pages/calendar_screen.dart';
import 'package:allplant/features/pages/home_screen.dart';
import 'package:allplant/features/pages/my_plants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Router Navigation Tests', () {
    testWidgets('Initial route shows HomeScreen', (WidgetTester tester) async {
    
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: appRouter,
        ),
      );
      await tester.pumpAndSettle();

     
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Navigating to /plants shows MyPlants screen', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: appRouter,
        ),
      );
      await tester.pumpAndSettle();

      // Navigate programmatically.
      appRouter.go('/plants');
      await tester.pumpAndSettle();


      expect(find.byType(MyPlantsScreen), findsOneWidget);
    });

    testWidgets('Navigating to /calendar shows CalendarScreen', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: appRouter,
        ),
      );
      await tester.pumpAndSettle();

      appRouter.go('/calendar');
      await tester.pumpAndSettle();

      expect(find.byType(CalendarScreen), findsOneWidget);
    });

    testWidgets('Navigating to /add-plant shows AddPlantScreen', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: appRouter,
        ),
      );
      await tester.pumpAndSettle();

      appRouter.go('/add-plant');
      await tester.pumpAndSettle();

      expect(find.byType(AddPlantScreen), findsOneWidget);
    });

    testWidgets('Navigating to an unknown route shows fallback', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: appRouter,
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to an unknown route.
      appRouter.go('/unknown');
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
