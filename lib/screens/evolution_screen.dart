import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../database/database.dart';
import '../providers/muscle_group_provider.dart';

class EvolutionScreen extends StatefulWidget {
  const EvolutionScreen({Key? key}) : super(key: key);

  @override
  State<EvolutionScreen> createState() => _EvolutionScreenState();
}

class _EvolutionScreenState extends State<EvolutionScreen> {
  // Filtros
  MuscleGroup? _selectedMuscleGroup;
  Exercise? _selectedExercise;

  // Listas para Dropdowns
  List<Exercise> _availableExercises = [];

  // Dados dos Gráficos
  List<Map<String, dynamic>> _chartData = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Carregar grupos musculares se ainda não estiverem carregados
    Future.microtask(() {
      context.read<MuscleGroupProvider>().loadMuscleGroups();
    });
  }

  // Ao selecionar um grupo muscular
  Future<void> _onMuscleGroupChanged(MuscleGroup? group) async {
    if (group == null) return;

    setState(() {
      _selectedMuscleGroup = group;
      _selectedExercise = null; // Resetar exercício
      _isLoading = true;
    });

    final db = context.read<AppDatabase>();

    // 1. Carregar exercícios disponíveis para o filtro secundário
    final exercises = await db.getExercisesWithHistory(group.id);

    // 2. Carregar dados de VOLUME (Séries) por padrão
    final volumeData = await db.getMuscleGroupVolumeEvolution(group.id);

    if (mounted) {
      setState(() {
        _availableExercises = exercises;
        _chartData = volumeData;
        _isLoading = false;
      });
    }
  }

  // Ao selecionar um exercício específico
  Future<void> _onExerciseChanged(Exercise? exercise) async {
    if (exercise == null) {
      // Se desmarcar exercício, volta para a visão do Grupo Muscular
      _onMuscleGroupChanged(_selectedMuscleGroup);
      return;
    }

    setState(() {
      _selectedExercise = exercise;
      _isLoading = true;
    });

    final db = context.read<AppDatabase>();
    // Carregar dados de CARGA (Peso)
    final weightData = await db.getExerciseWeightEvolution(exercise.id);

    if (mounted) {
      setState(() {
        _chartData = weightData;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final muscleGroups = context.watch<MuscleGroupProvider>().muscleGroups;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Evolução'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- ÁREA DE FILTROS ---
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Dropdown Grupo Muscular
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Grupo Muscular',
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      value: _selectedMuscleGroup?.id,
                      items: muscleGroups.map((g) {
                        return DropdownMenuItem(
                          value: g.id,
                          child: Text(g.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        final group =
                            muscleGroups.firstWhere((g) => g.id == value);
                        _onMuscleGroupChanged(group);
                      },
                    ),
                    const SizedBox(height: 16),

                    // Dropdown Exercício (Só aparece se tiver grupo selecionado)
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Exercício (Opcional)',
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      value: _selectedExercise?.id,
                      disabledHint: const Text('Selecione um grupo primeiro'),
                      items: _availableExercises.isEmpty
                          ? []
                          : [
                              const DropdownMenuItem(
                                value: null,
                                child: Text('Todos (Ver Volume Total)'),
                              ),
                              ..._availableExercises.map((e) {
                                return DropdownMenuItem(
                                  value: e.id,
                                  child: Text(e.name),
                                );
                              }).toList(),
                            ],
                      onChanged: _selectedMuscleGroup == null
                          ? null
                          : (value) {
                              if (value == null) {
                                _onExerciseChanged(null);
                              } else {
                                final exercise = _availableExercises
                                    .firstWhere((e) => e.id == value);
                                _onExerciseChanged(exercise);
                              }
                            },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // --- TÍTULO DO GRÁFICO ---
            if (_selectedMuscleGroup != null)
              Text(
                _selectedExercise == null
                    ? 'Volume de Treino: ${_selectedMuscleGroup!.name} (Séries)'
                    : 'Progressão de Carga: ${_selectedExercise!.name} (Kg)',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),

            const SizedBox(height: 24),

            // --- GRÁFICO ---
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _selectedMuscleGroup == null
                      ? _buildEmptyState()
                      : _chartData.isEmpty
                          ? const Center(
                              child: Text('Sem dados históricos para exibir.'),
                            )
                          : _selectedExercise == null
                              ? _buildVolumeChart() // Gráfico de Barras (Séries)
                              : _buildWeightChart(), // Gráfico de Linha (Peso)
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.show_chart, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'Selecione um grupo muscular para ver sua evolução',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  // GRÁFICO DE LINHA (PESO)
  Widget _buildWeightChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true, drawVerticalLine: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= 0 && value.toInt() < _chartData.length) {
                  final date = _chartData[value.toInt()]['date'] as DateTime;

                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      DateFormat('dd/MM').format(date),
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                }
                return const Text('');
              },
              interval: 1,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 40),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: _chartData.asMap().entries.map((entry) {
              return FlSpot(
                entry.key.toDouble(),
                (entry.value['weight'] as double),
              );
            }).toList(),
            isCurved: true,
            color: Theme.of(context).primaryColor,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: Theme.of(context).primaryColor.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }

  // GRÁFICO DE BARRAS (SÉRIES)
  Widget _buildVolumeChart() {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: _getMaxSeries() * 1.2, // Um pouco de respiro no topo
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= 0 && value.toInt() < _chartData.length) {
                  final date = _chartData[value.toInt()]['date'] as DateTime;

                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      DateFormat('dd/MM').format(date),
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1, // Mostrar apenas números inteiros
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 1,
        ),
        borderData: FlBorderData(show: false),
        barGroups: _chartData.asMap().entries.map((entry) {
          final int val = entry.value['series'] as int;
          return BarChartGroupData(
            x: entry.key,
            barRods: [
              BarChartRodData(
                toY: val.toDouble(),
                color: Theme.of(context).primaryColor,
                width: 16,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(4)),
              ),
            ],
            showingTooltipIndicators: [0],
          );
        }).toList(),
      ),
    );
  }

  double _getMaxSeries() {
    int max = 0;
    for (var item in _chartData) {
      if ((item['series'] as int) > max) max = item['series'] as int;
    }
    return max.toDouble() == 0 ? 10 : max.toDouble();
  }
}
