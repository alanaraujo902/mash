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
  
  // NOVA COLUNA NO NÍVEL DO TREINO
  BoolColumn get isDone => boolean().withDefault(const Constant(false))();
  
  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SessionMuscleGroup')
class SessionMuscleGroups extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId => text().references(TrainingSessions, #id, onDelete: KeyAction.cascade)();
  TextColumn get muscleGroupId => text().references(MuscleGroups, #id, onDelete: KeyAction.cascade)();
  IntColumn get order => integer().withDefault(const Constant(0))();
  
  // NOVA COLUNA: Indica se o grupo foi concluído no ciclo atual
  BoolColumn get isDone => boolean().withDefault(const Constant(false))();
  
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
  
  // Campo temporário para feedback
  TextColumn get feedback => text().nullable()();
  
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
  
  // Campo permanente para feedback
  TextColumn get feedback => text().nullable()();
  
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

// NOVA TABELA: Histórico de Recuperação
@DataClassName('RecoveryHistoryLog')
class RecoveryHistoryLogs extends Table {
  TextColumn get id => text()();
  TextColumn get muscleGroupId => text().references(MuscleGroups, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get fatigueDate => dateTime()(); // Quando o treino acabou
  DateTimeColumn get recoveredDate => dateTime()(); // Quando o user marcou recuperado
  IntColumn get durationInHours => integer()(); // Duração calculada

  @override
  Set<Column> get primaryKey => {id};
}

// NOVA TABELA: Contexto Diário
@DataClassName('DailyContext')
class DailyContexts extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()(); // Data do registro (sem hora, para unicidade)
  TextColumn get sleepTags => text()(); // JSON List
  TextColumn get nutritionTags => text()(); // JSON List
  TextColumn get stressTags => text()(); // JSON List
  TextColumn get notes => text().nullable()(); // Campo extra opcional

  @override
  Set<Column> get primaryKey => {id};
}

// NOVA TABELA: Refeições
@DataClassName('Meal')
class Meals extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()(); // Data da refeição
  IntColumn get mealIndex => integer()(); // Refeição 1, 2, 3...
  
  // Nutrientes solicitados
  RealColumn get calories => real().withDefault(const Constant(0.0))();
  RealColumn get carbs => real().withDefault(const Constant(0.0))();
  RealColumn get protein => real().withDefault(const Constant(0.0))(); // Proteína (essencial para músculo)
  RealColumn get totalFat => real().withDefault(const Constant(0.0))();
  RealColumn get saturatedFat => real().withDefault(const Constant(0.0))();
  RealColumn get fiber => real().withDefault(const Constant(0.0))();
  RealColumn get sodium => real().withDefault(const Constant(0.0))();
  RealColumn get calcium => real().withDefault(const Constant(0.0))();
  
  @override
  Set<Column> get primaryKey => {id};
}

// NOVA TABELA: Metas do Usuário
@DataClassName('UserGoal')
class UserGoals extends Table {
  TextColumn get id => text()(); // Usaremos um ID fixo 'main'
  RealColumn get caloriesTarget => real().withDefault(const Constant(2000.0))();
  RealColumn get carbsTarget => real().withDefault(const Constant(250.0))();
  RealColumn get proteinTarget => real().withDefault(const Constant(150.0))();
  RealColumn get fatTarget => real().withDefault(const Constant(70.0))();
  
  @override
  Set<Column> get primaryKey => {id};
}

// TABELA DE PROGRESSO DO USUÁRIO (Salva onde ele está no plano)
@DataClassName('RunningProgress')
class RunningProgresses extends Table {
  TextColumn get id => text()();
  IntColumn get currentLevel => integer().withDefault(const Constant(1))(); // Nível de dificuldade (1 a 30)
  IntColumn get weekDay => integer().withDefault(const Constant(1))(); // Dia 1, 2 ou 3 da semana
  DateTimeColumn get lastRunDate => dateTime().nullable()();
  
  @override
  Set<Column> get primaryKey => {id};
}

// TABELA DE HISTÓRICO DE CORRIDA
@DataClassName('RunningLog')
class RunningLogs extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  IntColumn get levelCompleted => integer()();
  IntColumn get durationSeconds => integer()();
  RealColumn get distanceKm => real().nullable()(); // Opcional, se o user quiser digitar
  // Feedback: 1 (Muito Fácil) a 5 (Impossível/Falha)
  IntColumn get feedbackScore => integer()(); 
  // NOVO: 'running' ou 'cycling'
  TextColumn get type => text().withDefault(const Constant('running'))(); 
  
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
  DailyContexts,
  RecoveryHistoryLogs,
  Meals,
  UserGoals,
  RunningProgresses,
  RunningLogs,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // Versão atualizada para 15 (sistema híbrido: corrida + bike)
  @override
  int get schemaVersion => 15;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        // Cria a meta padrão ao instalar
        await into(userGoals).insert(
          UserGoal(id: 'main', caloriesTarget: 2000, carbsTarget: 250, proteinTarget: 150, fatTarget: 70)
        );
        // Inicializa os dois tipos
        await into(runningProgresses).insert(
          RunningProgress(id: 'running', currentLevel: 1, weekDay: 1, lastRunDate: null)
        );
        await into(runningProgresses).insert(
          RunningProgress(id: 'cycling', currentLevel: 1, weekDay: 1, lastRunDate: null)
        );
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
        
        if (from < 6) {
          try { 
            await m.createTable(muscleRecoveries); 
          } catch (_) {}
        }
        
        // Migração v7: Adicionar colunas de feedback
        if (from < 7) {
          await m.addColumn(exerciseSeriesList, exerciseSeriesList.feedback);
          await m.addColumn(workoutHistorySets, workoutHistorySets.feedback);
        }
        
        // Migração v8: Adicionar coluna isDone para ciclo de treino (grupos)
        if (from < 8) {
          await m.addColumn(sessionMuscleGroups, sessionMuscleGroups.isDone);
        }
        
        // Migração v9: Adicionar coluna isDone no nível da sessão de treino
        if (from < 9) {
          await m.addColumn(trainingSessions, trainingSessions.isDone);
        }
        
        // Migração v10: Criar tabela de contexto diário
        if (from < 10) {
          await m.createTable(dailyContexts);
        }
        
        // Migração v11: Criar tabela de histórico de recuperação
        if (from < 11) {
          await m.createTable(recoveryHistoryLogs);
        }
        
        // Migração v12: Criar tabela de refeições
        if (from < 12) {
          await m.createTable(meals);
        }
        
        // Migração v13: Criar tabela de metas do usuário
        if (from < 13) {
          await m.createTable(userGoals);
          // Insere valor padrão para usuários existentes
          await into(userGoals).insert(
            UserGoal(id: 'main', caloriesTarget: 2000, carbsTarget: 250, proteinTarget: 150, fatTarget: 70)
          );
        }
        
        // Migração v14: Criar tabelas de corrida adaptativa
        if (from < 14) {
          await m.createTable(runningProgresses);
          await m.createTable(runningLogs);
          // Migra o usuário antigo para 'running' (o id 'main' vira 'running' na lógica, mas vamos criar novo para garantir)
          await into(runningProgresses).insert(
            RunningProgress(id: 'running', currentLevel: 1, weekDay: 1, lastRunDate: null)
          );
        }

        // Migração v15: Adicionar suporte a Bike (cycling)
        if (from < 15) {
          // Adiciona coluna type nos logs
          await m.addColumn(runningLogs, runningLogs.type);
          
          // Verifica se existe 'running', se não, cria
          final existingRunning = await (select(runningProgresses)..where((tbl) => tbl.id.equals('running'))).getSingleOrNull();
          if (existingRunning == null) {
            // Se existir um id 'main' antigo, copia os dados para 'running'
            final oldMain = await (select(runningProgresses)..where((tbl) => tbl.id.equals('main'))).getSingleOrNull();
            if (oldMain != null) {
              // Copia os dados do 'main' para 'running'
              await into(runningProgresses).insert(
                RunningProgress(
                  id: 'running',
                  currentLevel: oldMain.currentLevel,
                  weekDay: oldMain.weekDay,
                  lastRunDate: oldMain.lastRunDate,
                )
              );
              // Deleta o 'main' antigo
              await (delete(runningProgresses)..where((tbl) => tbl.id.equals('main'))).go();
            } else {
              // Se não existe nem 'main' nem 'running', cria 'running' do zero
              await into(runningProgresses).insert(
                RunningProgress(id: 'running', currentLevel: 1, weekDay: 1, lastRunDate: null)
              );
            }
          }
          
          // Cria o progresso da Bike (sempre cria, se não existir)
          final existingCycling = await (select(runningProgresses)..where((tbl) => tbl.id.equals('cycling'))).getSingleOrNull();
          if (existingCycling == null) {
            await into(runningProgresses).insert(
              RunningProgress(id: 'cycling', currentLevel: 1, weekDay: 1, lastRunDate: null)
            );
          }
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

  // MÉTODOS DE ACESSO PARA HISTÓRICO DE RECUPERAÇÃO
  Future<int> insertRecoveryLog(RecoveryHistoryLog log) {
    return into(recoveryHistoryLogs).insert(log);
  }

  Future<List<RecoveryHistoryLog>> getRecoveryHistory(String muscleGroupId) {
    return (select(recoveryHistoryLogs)
          ..where((tbl) => tbl.muscleGroupId.equals(muscleGroupId))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.recoveredDate, mode: OrderingMode.desc)]))
        .get();
  }

  // MÉTODOS DE CONTEXTO DIÁRIO
  Future<DailyContext?> getDailyContextByDate(DateTime date) {
    // Filtra pelo dia (ignorando hora)
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    
    return (select(dailyContexts)
      ..where((tbl) => tbl.date.isBiggerOrEqualValue(start) & tbl.date.isSmallerThanValue(end))
      ..limit(1))
      .getSingleOrNull();
  }

  Future<int> insertDailyContext(DailyContext context) {
    return into(dailyContexts).insert(context);
  }

  // MÉTODOS DE ACESSO A DIETA
  Future<List<Meal>> getMealsByDate(DateTime date) {
    // Filtra pelo dia (00:00 até 23:59)
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    
    return (select(meals)
      ..where((tbl) => tbl.date.isBiggerOrEqualValue(start) & tbl.date.isSmallerThanValue(end))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.mealIndex)]))
      .get();
  }

  Future<int> insertMeal(Meal meal) {
    return into(meals).insert(meal);
  }

  Future<bool> updateMeal(Meal meal) {
    return update(meals).replace(meal);
  }

  Future<int> deleteMeal(String id) {
    return (delete(meals)..where((tbl) => tbl.id.equals(id))).go();
  }

  // MÉTODOS DE ACESSO A METAS
  Future<UserGoal?> getUserGoal() {
    return (select(userGoals)..where((tbl) => tbl.id.equals('main'))).getSingleOrNull();
  }

  Future<void> updateUserGoal(UserGoal goal) {
    return update(userGoals).replace(goal);
  }

  // MÉTODOS DE ACESSO - CORRIDA (Mantidos para compatibilidade)
  Future<RunningProgress?> getRunningProgress() {
    return getProgressByType('running');
  }

  Future<void> updateRunningProgress(int newLevel, int newDay, DateTime? date) async {
    await updateProgressByType('running', newLevel, newDay, date);
  }

  // NOVOS MÉTODOS: Suporte a tipos
  Future<RunningProgress?> getProgressByType(String type) {
    return (select(runningProgresses)..where((tbl) => tbl.id.equals(type))).getSingleOrNull();
  }

  Future<void> updateProgressByType(String type, int newLevel, int newDay, DateTime? date) async {
    // Garante que o registro existe (para casos de migração bugada)
    final exists = await (select(runningProgresses)..where((tbl) => tbl.id.equals(type))).getSingleOrNull();
    if (exists == null) {
       await into(runningProgresses).insert(
          RunningProgress(id: type, currentLevel: newLevel, weekDay: newDay, lastRunDate: date)
       );
    } else {
      await (update(runningProgresses)..where((tbl) => tbl.id.equals(type))).write(
        RunningProgressesCompanion(
          currentLevel: Value(newLevel),
          weekDay: Value(newDay),
          lastRunDate: Value(date),
        ),
      );
    }
  }

  Future<void> insertRunningLog(RunningLog log) {
    return into(runningLogs).insert(log);
  }

  Future<List<RunningLog>> getRunningLogs() {
    return (select(runningLogs)
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.date, mode: OrderingMode.desc)]))
      .get();
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
