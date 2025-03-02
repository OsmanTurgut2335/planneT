import 'package:allplant/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:allplant/pages/add_plant.dart';
import 'package:allplant/pages/calendar_screen.dart';
import 'package:allplant/pages/home_screen.dart';
import 'package:allplant/pages/my_plants.dart';

void main() {
  group('Router Navigation Tests', () {
    testWidgets('Initial route shows HomeScreen', (WidgetTester tester) async {
      // Pump your app with the router configuration.
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: appRouter,
        ),
      );
      await tester.pumpAndSettle();

      // Verify that HomeScreen is displayed.
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

      // Verify that the MyPlants widget is visible.
      expect(find.byType(MyPlants), findsOneWidget);
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

    // For unknown routes, instead of checking internal configuration,
    // you can verify that an error screen (or fallback) is shown.
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

      // In your router you might have a fallback page (or it might redirect to home).
      // For this test, we assert that the unknown route is not staying on '/unknown'
      // by verifying that HomeScreen or some known widget is displayed.
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
