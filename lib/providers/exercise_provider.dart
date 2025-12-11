import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import '../database/database.dart';

class ExerciseProvider extends ChangeNotifier {
  final AppDatabase database;
  Map<String, List<Exercise>> _exercisesBySessionMuscleGroup = {};
  Map<String, List<ExerciseSeries>> _exerciseSeriesList = {};
  
  // Cache para histórico
  Map<String, List<WorkoutHistory>> _exerciseHistories = {};

  ExerciseProvider(this.database);

  Future<void> loadExercises(String sessionMuscleGroupId) async {
    _exercisesBySessionMuscleGroup[sessionMuscleGroupId] =
        await database.getExercisesBySessionMuscleGroup(sessionMuscleGroupId);
    notifyListeners();
  }

  List<Exercise> getExercises(String sessionMuscleGroupId) {
    return _exercisesBySessionMuscleGroup[sessionMuscleGroupId] ?? [];
  }

  Future<void> addExercise(
    String sessionMuscleGroupId,
    String name,
    int plannedSeries,
    int plannedReps,
    int intervalSeconds,
    bool isUnilateral, // <--- NOVO PARÂMETRO
  ) async {
    final currentExercises = getExercises(sessionMuscleGroupId);
    final exercise = Exercise(
      id: const Uuid().v4(),
      sessionMuscleGroupId: sessionMuscleGroupId,
      name: name,
      plannedSeries: plannedSeries,
      plannedReps: plannedReps,
      intervalSeconds: intervalSeconds,
      isUnilateral: isUnilateral, // <--- SALVAR NO BANCO
      order: currentExercises.length,
      createdAt: DateTime.now(),
    );

    await database.insertExercise(exercise);

    // Criar séries vazias
    for (int i = 1; i <= plannedSeries; i++) {
      final series = ExerciseSeries(
        id: const Uuid().v4(),
        exerciseId: exercise.id,
        seriesNumber: i,
        actualReps: null,
        weightKg: null,
        completedAt: null,
        isCompleted: false,
      );
      await database.insertExerciseSeries(series);
    }

    await loadExercises(sessionMuscleGroupId);
  }

  Future<void> updateExercise(
    String exerciseId,
    String name,
    int plannedSeries,
    int plannedReps,
    int intervalSeconds,
    bool isUnilateral, // <--- NOVO PARÂMETRO
  ) async {
    // Buscar o exercício em todos os grupos para atualizar
    for (var exercisesList in _exercisesBySessionMuscleGroup.values) {
      final exerciseIndex = exercisesList.indexWhere((e) => e.id == exerciseId);
      if (exerciseIndex != -1) {
        final exercise = exercisesList[exerciseIndex];
        final updated = exercise.copyWith(
          name: name,
          plannedSeries: plannedSeries,
          plannedReps: plannedReps,
          intervalSeconds: intervalSeconds,
          isUnilateral: isUnilateral, // <--- ATUALIZAR
        );
        await database.updateExercise(updated);
        exercisesList[exerciseIndex] = updated;
        notifyListeners();
        return;
      }
    }
  }

  // Método para reordenar exercícios
  Future<void> reorderExercises(String sessionMuscleGroupId, int oldIndex, int newIndex) async {
    final list = _exercisesBySessionMuscleGroup[sessionMuscleGroupId];

    if (list == null) return;

    // Ajuste necessário do índice quando movemos para baixo
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    // 1. Atualiza a lista localmente (para a UI reagir instantaneamente)
    final item = list.removeAt(oldIndex);
    list.insert(newIndex, item);
    notifyListeners();

    // 2. Atualiza a ordem no Banco de Dados
    // Percorre toda a lista atualizada e salva o novo índice 'order'
    for (int i = 0; i < list.length; i++) {
      final updatedExercise = list[i].copyWith(order: i);
      await database.updateExercise(updatedExercise);
    }

    // Recarrega para garantir sincronia total (opcional, mas seguro)
    await loadExercises(sessionMuscleGroupId);
  }

  Future<void> deleteExercise(String exerciseId) async {
    await database.deleteExercise(exerciseId);
    notifyListeners();
  }

  Future<void> loadExerciseSeries(String exerciseId) async {
    _exerciseSeriesList[exerciseId] =
        await database.getExerciseSeriesList(exerciseId);
    notifyListeners();
  }

  List<ExerciseSeries> getExerciseSeries(String exerciseId) {
    return _exerciseSeriesList[exerciseId] ?? [];
  }

  // Métodos para histórico
  Future<void> loadExerciseHistory(String exerciseId) async {
    _exerciseHistories[exerciseId] = 
        await database.getWorkoutHistoryByExercise(exerciseId);
    notifyListeners();
  }

  List<WorkoutHistory> getExerciseHistory(String exerciseId) {
    return _exerciseHistories[exerciseId] ?? [];
  }

  Future<void> updateExerciseSeries(
    String seriesId,
    int? actualReps,
    double? weightKg,
  ) async {
    await database.updateExerciseSeriesWithData(
      seriesId,
      actualReps,
      weightKg,
    );
    notifyListeners();
  }

  Future<void> completeExerciseSeries(String seriesId) async {
    await database.updateExerciseSeriesWithData(
      seriesId,
      null,
      null,
    );
    notifyListeners();
  }

  // Verifica se todas as séries de todos os exercícios do grupo estão concluídas
  Future<bool> checkAllExercisesCompleted(String sessionMuscleGroupId) async {
    // 1. Pega todos os exercícios desse grupo
    final exercises = await database.getExercisesBySessionMuscleGroup(sessionMuscleGroupId);

    for (var exercise in exercises) {
      // 2. Para cada exercício, pega as séries
      final seriesList = await database.getExerciseSeriesList(exercise.id);

      // 3. Se houver alguma série NÃO completada, retorna falso
      if (seriesList.any((s) => !s.isCompleted)) {
        return false;
      }
    }
    // Se passou por tudo e não retornou false, então tudo está completo
    return true;
  }

  // Finaliza o treino e salva no histórico
  Future<void> finishSessionMuscleGroup(
    String sessionMuscleGroupId,
    String trainingSessionId,
  ) async {
    final now = DateTime.now();

    // 1. Registrar a Sessão Geral
    final workoutSessionId = const Uuid().v4();
    final workoutSession = WorkoutSession(
      id: workoutSessionId,
      trainingSessionId: trainingSessionId,
      sessionMuscleGroupId: sessionMuscleGroupId,
      startedAt: now.subtract(const Duration(hours: 1)),
      completedAt: now,
      isCompleted: true,
    );

    await database.insertWorkoutSession(workoutSession);

    // 2. Processar cada exercício
    final exercises = await database.getExercisesBySessionMuscleGroup(sessionMuscleGroupId);

    for (var exercise in exercises) {
      final seriesList = await database.getExerciseSeriesList(exercise.id);

      final completedSeries = seriesList.where((s) => s.isCompleted).toList();

      if (completedSeries.isNotEmpty) {
        double maxWeight = 0;
        double volumeLoad = 0.0;

        // Calcula totais primeiro
        for (var s in completedSeries) {
          final reps = s.actualReps ?? 0;
          final weight = s.weightKg ?? 0.0;
          
          if (weight > maxWeight) maxWeight = weight;
          
          double seriesVolume = (reps * weight);
          if (exercise.isUnilateral) seriesVolume *= 2;
          
          volumeLoad += seriesVolume;
        }

        // --- CORREÇÃO AQUI: Salvar o PAI (History) PRIMEIRO ---
        final historyId = const Uuid().v4();
        
        final history = WorkoutHistory(
          id: historyId,
          workoutSessionId: workoutSessionId,
          exerciseId: exercise.id,
          completedSeries: completedSeries.length,
          maxWeightKg: maxWeight > 0 ? maxWeight : null,
          totalVolumeLoad: volumeLoad,
          completedAt: now,
        );

        await database.insertWorkoutHistory(history);

        // --- AGORA salvamos os FILHOS (Sets Detalhados) ---
        int orderCounter = 1;
        for (var s in completedSeries) {
          final reps = s.actualReps ?? 0;
          final weight = s.weightKg ?? 0.0;

          await database.insertWorkoutHistorySet(
            WorkoutHistorySet(
              id: const Uuid().v4(),
              workoutHistoryId: historyId, // Link correto com o Pai já criado
              reps: reps,
              weightKg: weight,
              seriesOrder: orderCounter++,
              feedback: s.feedback, // Copiando o feedback
            ),
          );
        }
      }

      // --- O RESET ACONTECE AQUI ---
      for (var series in seriesList) {
        // Usamos o copyWith para criar uma versão atualizada da série.
        // MANTEMOS weightKg e actualReps (para servirem de sugestão no próximo treino)
        // ALTERAMOS apenas isCompleted para false e completedAt para null
        final resetSeries = series.copyWith(
          isCompleted: false,
          completedAt: const Value(null),
          feedback: const Value(null), // Limpar feedback
          // weightKg e actualReps não são passados, então são mantidos automaticamente
        );

        // Atualiza no banco de dados
        await database.updateExerciseSeries(resetSeries);
      }
    }

    // NOVO: Marca o TREINO INTEIRO como concluído quando finalizar um grupo
    // Verifica se todos os grupos deste treino foram concluídos (têm histórico)
    final allGroups = await database.getSessionMuscleGroups(trainingSessionId);
    bool allGroupsCompleted = true;
    
    for (var group in allGroups) {
      final groupExercises = await database.getExercisesBySessionMuscleGroup(group.id);
      bool groupHasHistory = false;
      
      for (var exercise in groupExercises) {
        final history = await database.getWorkoutHistoryByExercise(exercise.id);
        if (history.isNotEmpty) {
          groupHasHistory = true;
          break;
        }
      }
      
      if (!groupHasHistory) {
        allGroupsCompleted = false;
        break;
      }
    }

    // Se todos os grupos foram concluídos, marca o treino como feito
    if (allGroupsCompleted) {
      await (database.update(database.trainingSessions)
        ..where((tbl) => tbl.id.equals(trainingSessionId)))
        .write(const TrainingSessionsCompanion(isDone: Value(true)));

      // Verifica se todos os treinos estão concluídos para resetar o ciclo
      final allSessions = await database.getAllTrainingSessions();
      final allSessionsDone = allSessions.every((s) => s.isDone);
      
      if (allSessionsDone) {
        // Reseta todos os treinos
        for (var session in allSessions) {
          await (database.update(database.trainingSessions)
            ..where((tbl) => tbl.id.equals(session.id)))
            .write(const TrainingSessionsCompanion(isDone: Value(false)));
        }
      }
    }

    // Notifica a tela para recarregar se necessário
    notifyListeners();
  }

  // NOVO: Salvar Feedback na Série (Temporário)
  Future<void> saveSeriesFeedback(String seriesId, String feedbackJson) async {
    await (database.update(database.exerciseSeriesList)
      ..where((tbl) => tbl.id.equals(seriesId)))
      .write(ExerciseSeriesListCompanion(
        feedback: Value(feedbackJson),
      ));
  }

  // NOVO: Calcula o volume total (tonelagem) atual da sessão em tempo real
  Future<double> getCurrentSessionVolume(String sessionMuscleGroupId) async {
    double totalVolume = 0.0;
    
    // 1. Pega todos os exercícios do grupo
    final exercises = await database.getExercisesBySessionMuscleGroup(sessionMuscleGroupId);

    for (var exercise in exercises) {
      // 2. Pega as séries de cada exercício
      final seriesList = await database.getExerciseSeriesList(exercise.id);
      
      for (var series in seriesList) {
        // 3. Soma apenas se estiver completada e tiver dados válidos
        if (series.isCompleted && series.actualReps != null && series.weightKg != null) {
          double seriesVol = series.actualReps! * series.weightKg!;
          
          // Se for unilateral, duplica o volume (perna esq + dir)
          if (exercise.isUnilateral) {
            seriesVol *= 2;
          }
          
          totalVolume += seriesVol;
        }
      }
    }
    
    return totalVolume;
  }
}
