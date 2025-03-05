import 'package:allplant/core/router/app_router.dart';
import 'package:allplant/core/theme/app_theme.dart';
import 'package:allplant/features/cubit/plant/plant_cubit.dart';
import 'package:allplant/features/models/plant.dart';
import 'package:allplant/features/repository/plant_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //TODO DO THE INITIALIZING AT INTRO SCREEN OR SOMETHING
  // Initialize Hive for Flutter
  
  await Hive.initFlutter();
  
  // Register your Plant adapter
  Hive.registerAdapter(PlantAdapter());
  
  // Open the 'plants' box (this opens it once for the entire app)
  await Hive.openBox<Plant>('plants');
  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<PlantCubit>(
          create: (context) => PlantCubit(PlantRepository()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'Plant App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
    );
  }
}
