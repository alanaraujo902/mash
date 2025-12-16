import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database/database.dart';
import 'providers/muscle_group_provider.dart';
import 'providers/training_session_provider.dart';
import 'providers/exercise_provider.dart';
import 'providers/workout_provider.dart';
import 'providers/recovery_provider.dart';
import 'providers/workout_timer_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/daily_context_provider.dart';
import 'providers/diet_provider.dart';
import 'providers/aerobic_provider.dart';
import 'utils/app_colors.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = AppDatabase();
  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final AppDatabase database;

  const MyApp({Key? key, required this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppDatabase>(create: (_) => database),
        ChangeNotifierProvider(
          create: (_) => MuscleGroupProvider(database)..loadMuscleGroups(),
        ),
        ChangeNotifierProvider(
          create: (_) => TrainingSessionProvider(database)..loadTrainingSessions(),
        ),
        ChangeNotifierProvider(
          create: (_) => ExerciseProvider(database),
        ),
        ChangeNotifierProvider(
          create: (_) => WorkoutProvider(database),
        ),
        ChangeNotifierProvider(
          create: (_) => RecoveryProvider(database)..loadRecoveryData(),
        ),
        ChangeNotifierProvider(
          create: (_) => WorkoutTimerProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DailyContextProvider(database),
        ),
        ChangeNotifierProvider(
          create: (_) => DietProvider(database),
        ),
        ChangeNotifierProvider(
          create: (_) => AerobicProvider(database),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          final isNeon = themeProvider.isNeon;

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Muscle App',
            themeMode: themeProvider.themeMode,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF6366F1),
                brightness: Brightness.light,
              ),
              fontFamily: 'Roboto',
            ),
            darkTheme: isNeon
                ? ThemeData(
                    useMaterial3: true,
                    scaffoldBackgroundColor: AppColors.neonBackground,
                    cardColor: AppColors.neonCard,
                    colorScheme: const ColorScheme.dark(
                      primary: AppColors.neonPurple,
                      secondary: AppColors.neonGreen,
                      surface: AppColors.neonCard,
                    ),
                    fontFamily: 'Roboto',
                  )
                : ThemeData(
                    useMaterial3: true,
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: const Color(0xFF6366F1),
                      brightness: Brightness.dark,
                    ),
                    fontFamily: 'Roboto',
                  ),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
