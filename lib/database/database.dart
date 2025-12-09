import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:uuid/uuid.dart';

part 'database.g.dart';

// Tabelas
@DataClassName('MuscleGroup')
class MuscleGroups extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get color => text().withDefault(const Constant('#FF6B6B'))();
  IntColumn get order => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('TrainingSession')
class TrainingSessions extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()(); // A, B, C, D, etc.
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SessionMuscleGroup')
class SessionMuscleGroups extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId => text().references(TrainingSessions, #id, onDelete: KeyAction.cascade)();
  TextColumn get muscleGroupId => text().references(MuscleGroups, #id, onDelete: KeyAction.cascade)();
  IntColumn get order => integer().withDefault(const Constant(0))();
  
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Exercise')
class Exercises extends Table {
  TextColumn get id => text()();
  TextColumn get sessionMuscleGroupId => text().references(SessionMuscleGroups, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  IntColumn get plannedSeries => integer()();
  IntColumn get plannedReps => integer()();
  IntColumn get intervalSeconds => integer().withDefault(const Constant(60))();
  IntColumn get order => integer().withDefault(const Constant(0))();
  
  // --- ADICIONE ESTA LINHA ---
  BoolColumn get isUnilateral => boolean().withDefault(const Constant(false))();
  
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ExerciseSeries')
class ExerciseSeriesList extends Table {
  TextColumn get id => text()();
  TextColumn get exerciseId => text().references(Exercises, #id, onDelete: KeyAction.cascade)();
  IntColumn get seriesNumber => integer()();
  IntColumn get actualReps => integer().nullable()();
  RealColumn get weightKg => real().nullable()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('WorkoutSession')
class WorkoutSessions extends Table {
  TextColumn get id => text()();
  TextColumn get trainingSessionId => text().references(TrainingSessions, #id, onDelete: KeyAction.cascade)();
  TextColumn get sessionMuscleGroupId => text().references(SessionMuscleGroups, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get startedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get completedAt => dateTime().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('WorkoutHistory')
class WorkoutHistories extends Table {
  TextColumn get id => text()();
  TextColumn get workoutSessionId => text().references(WorkoutSessions, #id, onDelete: KeyAction.cascade)();
  TextColumn get exerciseId => text().references(Exercises, #id, onDelete: KeyAction.cascade)();
  IntColumn get completedSeries => integer()();
  RealColumn get maxWeightKg => real().nullable()();
  // Armazena a soma de (Reps * Carga) de todas as séries
  RealColumn get totalVolumeLoad => real().withDefault(const Constant(0.0))();
  DateTimeColumn get completedAt => dateTime().withDefault(currentDateAndTime)();
  
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('WorkoutHistorySet')
class WorkoutHistorySets extends Table {
  TextColumn get id => text()();
  // Vincula com o registro do histórico do exercício
  TextColumn get workoutHistoryId => text().references(WorkoutHistories, #id, onDelete: KeyAction.cascade)();
  IntColumn get reps => integer()();
  RealColumn get weightKg => real()();
  IntColumn get seriesOrder => integer()(); // Para saber se foi a 1ª, 2ª, 3ª série...
  
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('MuscleRecovery')
class MuscleRecoveries extends Table {
  TextColumn get id => text()();
  TextColumn get muscleGroupId => text().references(MuscleGroups, #id, onDelete: KeyAction.cascade)();
  BoolColumn get isRecovered => boolean().withDefault(const Constant(true))();
  DateTimeColumn get lastWorkoutDate => dateTime().nullable()(); // Data do último treino
  DateTimeColumn get recoveredAt => dateTime().nullable()(); // Data que o usuário marcou recuperação

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [
  MuscleGroups,
  TrainingSessions,
  SessionMuscleGroups,
  Exercises,
  ExerciseSeriesList,
  WorkoutSessions,
  WorkoutHistories,
  MuscleRecoveries,
  WorkoutHistorySets,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // 1. AUMENTE A VERSÃO PARA 5
  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Migrações antigas...
        if (from < 3) {
          await m.addColumn(exercises, exercises.isUnilateral);
        }
        
        // Se a versão era menor que 4, cria a tabela nova
        if (from < 4) {
          await m.createTable(workoutHistorySets);
        }

        // 2. NOVA REGRA: Se a versão for menor que 5, adiciona a coluna que está faltando
        // Isso vai rodar mesmo se seu app já estiver na versão 4
        if (from < 5) {
          // Adiciona a coluna totalVolumeLoad na tabela workoutHistories
          await m.addColumn(workoutHistories, workoutHistories.totalVolumeLoad);
        }
      },
    );
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'muscle_app_db');
  }

  // MUSCLE GROUPS
  Future<List<MuscleGroup>> getAllMuscleGroups() {
    return select(muscleGroups).watch().first;
  }

  Future<int> insertMuscleGroup(MuscleGroup group) {
    return into(muscleGroups).insert(group);
  }

  Future<bool> updateMuscleGroup(MuscleGroup group) {
    return update(muscleGroups).replace(group);
  }

  Future<int> deleteMuscleGroup(String id) {
    return (delete(muscleGroups)..where((tbl) => tbl.id.equals(id))).go();
  }

  // TRAINING SESSIONS
  Future<List<TrainingSession>> getAllTrainingSessions() {
    return select(trainingSessions).watch().first;
  }

  Future<TrainingSession?> getTrainingSessionById(String id) {
    return (select(trainingSessions)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertTrainingSession(TrainingSession session) {
    return into(trainingSessions).insert(session);
  }

  Future<bool> updateTrainingSession(TrainingSession session) {
    return update(trainingSessions).replace(session);
  }

  Future<int> deleteTrainingSession(String id) {
    return (delete(trainingSessions)..where((tbl) => tbl.id.equals(id))).go();
  }

  // SESSION MUSCLE GROUPS
  Future<List<SessionMuscleGroup>> getSessionMuscleGroups(String sessionId) {
    return (select(sessionMuscleGroups)
          ..where((tbl) => tbl.sessionId.equals(sessionId))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.order)]))
        .get();
  }

  Future<int> insertSessionMuscleGroup(SessionMuscleGroup smg) {
    return into(sessionMuscleGroups).insert(smg);
  }

  Future<bool> updateSessionMuscleGroup(SessionMuscleGroup smg) {
    return update(sessionMuscleGroups).replace(smg);
  }

  Future<int> deleteSessionMuscleGroup(String id) {
    return (delete(sessionMuscleGroups)..where((tbl) => tbl.id.equals(id))).go();
  }

  // EXERCISES
  Future<List<Exercise>> getExercisesBySessionMuscleGroup(String sessionMuscleGroupId) {
    return (select(exercises)
          ..where((tbl) => tbl.sessionMuscleGroupId.equals(sessionMuscleGroupId))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.order)]))
        .get();
  }

  Future<int> insertExercise(Exercise exercise) {
    return into(exercises).insert(exercise);
  }

  Future<bool> updateExercise(Exercise exercise) {
    return update(exercises).replace(exercise);
  }

  Future<int> deleteExercise(String id) {
    return (delete(exercises)..where((tbl) => tbl.id.equals(id))).go();
  }

  // EXERCISE SERIES
  Future<List<ExerciseSeries>> getExerciseSeriesList(String exerciseId) {
    return (select(exerciseSeriesList)
          ..where((tbl) => tbl.exerciseId.equals(exerciseId))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.seriesNumber)]))
        .get();
  }

  Future<int> insertExerciseSeries(ExerciseSeries series) {
    return into(exerciseSeriesList).insert(series);
  }

  Future<bool> updateExerciseSeries(ExerciseSeries series) {
    return update(exerciseSeriesList).replace(series);
  }

  Future<void> updateExerciseSeriesWithData(
    String seriesId,
    int? actualReps,
    double? weightKg,
  ) async {
    await (update(exerciseSeriesList)..where((tbl) => tbl.id.equals(seriesId))).write(
      ExerciseSeriesListCompanion(
        actualReps: actualReps != null ? Value(actualReps) : const Value.absent(),
        weightKg: weightKg != null ? Value(weightKg) : const Value.absent(),
        isCompleted: const Value(true),
        completedAt: Value(DateTime.now()),
      ),
    );
  }

  // WORKOUT SESSIONS
  Future<int> insertWorkoutSession(WorkoutSession session) {
    return into(workoutSessions).insert(session);
  }

  Future<bool> updateWorkoutSession(WorkoutSession session) {
    return update(workoutSessions).replace(session);
  }

  // WORKOUT HISTORY
  Future<int> insertWorkoutHistory(WorkoutHistory history) {
    return into(workoutHistories).insert(history);
  }

  Future<List<WorkoutHistory>> getWorkoutHistoryByExercise(String exerciseId) {
    return (select(workoutHistories)
          ..where((tbl) => tbl.exerciseId.equals(exerciseId))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.completedAt, mode: OrderingMode.desc)]))
        .get();
  }

  // WORKOUT HISTORY SETS
  Future<int> insertWorkoutHistorySet(WorkoutHistorySet set) {
    return into(workoutHistorySets).insert(set);
  }

  Future<List<WorkoutHistorySet>> getSetsForHistory(String historyId) {
    return (select(workoutHistorySets)
          ..where((tbl) => tbl.workoutHistoryId.equals(historyId))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.seriesOrder)]))
        .get();
  }

  // --- ESTATÍSTICAS PARA EVOLUÇÃO ---

  // 1. Evolução Detalhada de um Exercício (Peso Máximo + Volume Load)
  // Retorna: Data, Peso Máximo (kg), Volume Load Total (kg)
  Future<List<Map<String, dynamic>>> getExerciseHistoryDetails(String exerciseId) async {
    final query = select(workoutHistories)
      ..where((tbl) => tbl.exerciseId.equals(exerciseId))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.completedAt)]);

    final results = await query.get();

    return results.map((h) {
      return {
        'date': h.completedAt,
        'weight': h.maxWeightKg ?? 0.0,
        'volume': h.totalVolumeLoad, // Agora incluímos o Volume Load
      };
    }).toList();
  }

  // Mantido para compatibilidade (pode ser removido se não for usado)
  Future<List<Map<String, dynamic>>> getExerciseWeightEvolution(String exerciseId) async {
    final details = await getExerciseHistoryDetails(exerciseId);
    return details.map((d) => {
      'date': d['date'],
      'weight': d['weight'],
    }).toList();
  }

  // 2. Volume Load (Carga Total) por Grupo Muscular
  // Retorna o Volume Load (Reps * Kg * Séries) agrupado por dia
  Future<List<Map<String, dynamic>>> getMuscleGroupVolumeEvolution(String muscleGroupId) async {
    // Precisamos fazer JOIN: History -> WorkoutSession -> SessionMuscleGroup
    // Para filtrar pelo muscleGroupId

    final query = select(workoutHistories).join([
      innerJoin(
        workoutSessions,
        workoutSessions.id.equalsExp(workoutHistories.workoutSessionId),
      ),
      innerJoin(
        sessionMuscleGroups,
        sessionMuscleGroups.id.equalsExp(workoutSessions.sessionMuscleGroupId),
      ),
    ])
      ..where(sessionMuscleGroups.muscleGroupId.equals(muscleGroupId))
      ..orderBy([OrderingTerm(expression: workoutHistories.completedAt)]);

    final rows = await query.get();

    // Agrupamento manual por dia (Drift simple query)
    final Map<String, double> dailyVolumeLoad = {}; // Key: "YYYY-MM-DD", Value: Total Volume Load

    for (var row in rows) {
      final history = row.readTable(workoutHistories);
      final dateKey =
          "${history.completedAt.year}-${history.completedAt.month}-${history.completedAt.day}";

      // SOMA O VOLUME LOAD (Em vez de somar 1 série)
      // Se for um registro antigo sem volume calculado, usamos 0.0
      final volume = history.totalVolumeLoad;

      dailyVolumeLoad[dateKey] = (dailyVolumeLoad[dateKey] ?? 0.0) + volume;
    }

    // Converter para lista ordenada
    final List<Map<String, dynamic>> result = [];
    final sortedKeys = dailyVolumeLoad.keys.toList()..sort();

    for (var key in sortedKeys) {
      final parts = key.split('-');
      final date = DateTime(
        int.parse(parts[0]),
        int.parse(parts[1]),
        int.parse(parts[2]),
      );
      result.add({
        'date': date,
        'volume': dailyVolumeLoad[key], // Agora a chave é 'volume' contendo Kg totais
      });
    }

    return result;
  }

  // --- MÉTODOS DE RECUPERAÇÃO ---

  Future<MuscleRecovery?> getRecoveryStatus(String muscleGroupId) {
    return (select(muscleRecoveries)
          ..where((tbl) => tbl.muscleGroupId.equals(muscleGroupId)))
        .getSingleOrNull();
  }

  Future<void> setMuscleFatigued(String muscleGroupId) async {
    // Verifica se já existe registro
    final existing = await getRecoveryStatus(muscleGroupId);
    final now = DateTime.now();

    if (existing != null) {
      await update(muscleRecoveries).replace(
        existing.copyWith(
          isRecovered: false,
          lastWorkoutDate: Value(now),
        ),
      );
    } else {
      await into(muscleRecoveries).insert(
        MuscleRecovery(
          id: const Uuid().v4(),
          muscleGroupId: muscleGroupId,
          isRecovered: false,
          lastWorkoutDate: now,
          recoveredAt: null,
        ),
      );
    }
  }

  Future<void> setMuscleRecovered(String muscleGroupId, DateTime recoveryDate) async {
    final existing = await getRecoveryStatus(muscleGroupId);

    if (existing != null) {
      await update(muscleRecoveries).replace(
        existing.copyWith(
          isRecovered: true,
          recoveredAt: Value(recoveryDate),
        ),
      );
    } else {
      // Caso raro onde não havia registro anterior
      await into(muscleRecoveries).insert(
        MuscleRecovery(
          id: const Uuid().v4(),
          muscleGroupId: muscleGroupId,
          isRecovered: true,
          lastWorkoutDate: null,
          recoveredAt: recoveryDate,
        ),
      );
    }
  }

  // 3. Buscar todos exercícios que já têm histórico (para preencher o filtro)
  Future<List<Exercise>> getExercisesWithHistory(String muscleGroupId) async {
    // Join reverso para pegar exercícios que pertencem a um grupo muscular e tem histórico
    final query = select(exercises).join([
      innerJoin(
        workoutHistories,
        workoutHistories.exerciseId.equalsExp(exercises.id),
      ),
      innerJoin(
        sessionMuscleGroups,
        sessionMuscleGroups.id.equalsExp(exercises.sessionMuscleGroupId),
      ),
    ])
      ..where(sessionMuscleGroups.muscleGroupId.equals(muscleGroupId))
      ..groupBy([exercises.id]); // Distinct exercises

    return query.map((row) => row.readTable(exercises)).get();
  }
}
