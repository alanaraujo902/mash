# Arquitetura do Muscle App

## Visão Geral

O Muscle App segue uma arquitetura em camadas com separação clara de responsabilidades:

```
┌─────────────────────────────────────┐
│         Camada de Apresentação      │
│      (Screens / UI Components)      │
└────────────────┬────────────────────┘
                 │
┌────────────────▼────────────────────┐
│      Camada de Gerenciamento        │
│        (Providers / State)          │
└────────────────┬────────────────────┘
                 │
┌────────────────▼────────────────────┐
│      Camada de Persistência         │
│      (Database / Drift ORM)         │
└─────────────────────────────────────┘
```

## Componentes Principais

### 1. Camada de Apresentação (Screens)

**Responsabilidades:**
- Renderizar a interface do usuário
- Capturar interações do usuário
- Exibir dados do estado

**Arquivos:**
- `home_screen.dart`: Navegação principal
- `training_sessions_screen.dart`: Lista de sessões
- `create_training_session_screen.dart`: Criação de sessão
- `training_detail_screen.dart`: Detalhes da sessão
- `exercise_list_screen.dart`: Lista de exercícios
- `add_exercise_screen.dart`: Adição de exercício
- `workout_screen.dart`: Execução de treino
- `evolution_screen.dart`: Visualização de progresso

### 2. Camada de Gerenciamento de Estado (Providers)

**Padrão:** Provider Pattern com ChangeNotifier

**Providers:**

#### MuscleGroupProvider
```dart
- loadMuscleGroups()
- addMuscleGroup(name, color)
- updateMuscleGroup(id, name, color)
- deleteMuscleGroup(id)
- getColorFromHex(hexColor)
```

#### TrainingSessionProvider
```dart
- loadTrainingSessions()
- createTrainingSession(name, muscleGroupIds)
- loadSessionMuscleGroups(sessionId)
- getSessionMuscleGroups(sessionId)
- setActiveSession(sessionId)
- deleteTrainingSession(id)
- updateTrainingSession(id, name, description)
- addMuscleGroupToSession(sessionId, muscleGroupId)
- removeMuscleGroupFromSession(smgId)
```

#### ExerciseProvider
```dart
- loadExercises(sessionMuscleGroupId)
- getExercises(sessionMuscleGroupId)
- addExercise(sessionMuscleGroupId, name, series, reps, interval)
- updateExercise(exerciseId, name, series, reps, interval)
- deleteExercise(exerciseId)
- loadExerciseSeries(exerciseId)
- getExerciseSeries(exerciseId)
- updateExerciseSeries(seriesId, actualReps, weightKg)
- completeExerciseSeries(seriesId)
```

#### WorkoutProvider
```dart
- startWorkout(trainingSessionId, sessionMuscleGroupId)
- setCurrentExercise(exercise)
- completeExerciseSeries(seriesId, actualReps, weightKg)
- startInterval(seconds)
- updateIntervalTime(remainingSeconds)
- stopInterval()
- finishWorkout(completedSeries)
- reset()
```

### 3. Camada de Persistência (Database)

**Tecnologia:** Drift (SQLite ORM)

**Tabelas:**

```
MuscleGroups
├── id (PK)
├── name
├── color
├── order
└── createdAt

TrainingSessions
├── id (PK)
├── name
├── description
├── createdAt
└── updatedAt

SessionMuscleGroups
├── id (PK)
├── sessionId (FK)
├── muscleGroupId (FK)
└── order

Exercises
├── id (PK)
├── sessionMuscleGroupId (FK)
├── name
├── plannedSeries
├── plannedReps
├── intervalSeconds
├── order
└── createdAt

ExerciseSeriesList
├── id (PK)
├── exerciseId (FK)
├── seriesNumber
├── actualReps
├── weightKg
├── completedAt
└── isCompleted

WorkoutSessions
├── id (PK)
├── trainingSessionId (FK)
├── sessionMuscleGroupId (FK)
├── startedAt
├── completedAt
└── isCompleted

WorkoutHistories
├── id (PK)
├── workoutSessionId (FK)
├── exerciseId (FK)
├── completedSeries
├── maxWeightKg
└── completedAt
```

## Fluxo de Dados

### Criar Sessão de Treino
```
UI (CreateTrainingSessionScreen)
    ↓
TrainingSessionProvider.createTrainingSession()
    ↓
Database.insertTrainingSession()
Database.insertSessionMuscleGroup() × N
    ↓
Provider notifica listeners
    ↓
UI atualiza
```

### Executar Treino
```
UI (WorkoutScreen)
    ↓
ExerciseProvider.updateExerciseSeries()
    ↓
Database.updateExerciseSeriesWithData()
    ↓
WorkoutProvider.completeExerciseSeries()
    ↓
Provider notifica listeners
    ↓
UI atualiza (próxima série ou intervalo)
```

### Visualizar Evolução
```
UI (EvolutionScreen)
    ↓
Database.getWorkoutHistoryByExercise()
    ↓
Processar dados para gráficos
    ↓
Renderizar com fl_chart
```

## Padrões de Design

### 1. Provider Pattern
- Gerenciamento de estado centralizado
- Reatividade automática com `notifyListeners()`
- Fácil acesso via `context.read()` e `context.watch()`

### 2. Repository Pattern
- Database atua como repositório
- Abstração de queries SQL
- Métodos de conveniência

### 3. Separation of Concerns
- Screens: apenas apresentação
- Providers: lógica de negócio
- Database: persistência

## Dependências

```
Provider (6.1.5+1)
├── Gerenciamento de estado
└── Notificação de mudanças

Drift (2.30.0)
├── ORM para SQLite
├── Geração de código
└── Type-safe queries

Flutter
├── Material Design 3
├── Navigation
└── UI Components

fl_chart (1.1.1)
├── Gráficos de linha
├── Gráficos de barra
└── Visualizações

uuid (4.5.2)
└── Geração de IDs únicos
```

## Inicialização da Aplicação

```dart
main()
    ↓
AppDatabase() - Inicializa Drift
    ↓
MultiProvider
    ├── MuscleGroupProvider
    ├── TrainingSessionProvider
    ├── ExerciseProvider
    └── WorkoutProvider
    ↓
MaterialApp
    ↓
HomeScreen
```

## Tratamento de Erros

- Try-catch em operações de banco de dados
- SnackBar para feedback ao usuário
- Validação de entrada em formulários
- Null-safety com tipos não-nulos

## Performance

- Queries reativas com `.watch()`
- Lazy loading de dados
- Índices no banco de dados
- Memoização de cálculos

## Segurança

- Dados armazenados localmente
- Sem transmissão de dados sensíveis
- Validação de entrada
- Preparado para autenticação futura

## Escalabilidade

### Pronto para:
- Integração com Supabase
- Autenticação de usuário
- Sincronização em nuvem
- Multi-dispositivo
- Compartilhamento de dados

### Pontos de Extensão:
- `Database` class para adicionar novos DAOs
- `Providers` para adicionar nova lógica
- `Screens` para novas funcionalidades
- `Models` para novos dados

## Testes

Recomendações para testes:

```dart
// Unit Tests
- Providers (lógica de negócio)
- Database queries

// Widget Tests
- Screens individuais
- Interações de UI

// Integration Tests
- Fluxos completos
- Sincronização de dados
```

## Documentação Adicional

- [Flutter Architecture](https://flutter.dev/docs/development/data-and-backend/state-mgmt)
- [Drift Documentation](https://drift.simonbinder.eu/)
- [Provider Documentation](https://pub.dev/packages/provider)

---

**Última atualização:** Dezembro 2025
