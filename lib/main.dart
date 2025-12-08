import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database/database.dart';
import 'providers/muscle_group_provider.dart';
import 'providers/training_session_provider.dart';
import 'providers/exercise_provider.dart';
import 'providers/workout_provider.dart';
import 'providers/recovery_provider.dart';
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
      ],
      child: MaterialApp(
        title: 'Muscle App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6366F1),
            brightness: Brightness.light,
          ),
          fontFamily: 'Roboto',
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6366F1),
            brightness: Brightness.dark,
          ),
          fontFamily: 'Roboto',
        ),
        themeMode: ThemeMode.system,
        home: const HomeScreen(),
      ),
    );
  }
}
