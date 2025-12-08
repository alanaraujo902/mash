import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../database/database.dart';
import '../providers/muscle_group_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/neon_card.dart';
import '../utils/app_colors.dart';

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

  // Helper para criar decoração de input consistente com o tema
  InputDecoration _buildInputDecoration(String label, bool isNeon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: isNeon ? Colors.grey[400] : null,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: isNeon
            ? BorderSide(color: AppColors.neonPurple.withOpacity(0.5))
            : const BorderSide(),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: isNeon
            ? BorderSide(color: AppColors.neonPurple.withOpacity(0.5))
            : BorderSide(color: Colors.grey.withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: isNeon ? AppColors.neonGreen : Theme.of(context).primaryColor,
          width: 2,
        ),
      ),
      filled: isNeon,
      fillColor: isNeon ? Colors.black26 : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

  @override
  Widget build(BuildContext context) {
    final muscleGroups = context.watch<MuscleGroupProvider>().muscleGroups;
    final isNeon = context.watch<ThemeProvider>().isNeon;

    // Cores dinâmicas
    final titleColor = isNeon ? AppColors.neonGreen : Colors.black87;
    final loadingColor = isNeon ? AppColors.neonPurple : Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Evolução'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- ÁREA DE FILTROS (Com NeonCard) ---
            NeonCard(
              isNeon: isNeon,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Dropdown Grupo Muscular
                  DropdownButtonFormField<String>(
                    decoration: _buildInputDecoration('Grupo Muscular', isNeon),
                    dropdownColor: isNeon ? AppColors.neonCard : null,
                    style: TextStyle(
                      color: isNeon ? Colors.white : Colors.black87,
                      fontSize: 16,
                    ),
                    value: _selectedMuscleGroup?.id,
                    items: muscleGroups.map((g) {
                      return DropdownMenuItem(
                        value: g.id,
                        child: Text(g.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      final group = muscleGroups.firstWhere((g) => g.id == value);
                      _onMuscleGroupChanged(group);
                    },
                  ),
                  const SizedBox(height: 16),

                  // Dropdown Exercício
                  DropdownButtonFormField<String>(
                    decoration: _buildInputDecoration('Exercício (Opcional)', isNeon),
                    dropdownColor: isNeon ? AppColors.neonCard : null,
                    style: TextStyle(
                      color: isNeon ? Colors.white : Colors.black87,
                      fontSize: 16,
                    ),
                    value: _selectedExercise?.id,
                    disabledHint: Text(
                      'Selecione um grupo primeiro',
                      style: TextStyle(color: isNeon ? Colors.grey : null),
                    ),
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

            const SizedBox(height: 24),

            // --- TÍTULO DO GRÁFICO ---
            if (_selectedMuscleGroup != null)
              Text(
                _selectedExercise == null
                    ? 'Volume: ${_selectedMuscleGroup!.name} (Séries)'
                    : 'Carga: ${_selectedExercise!.name} (Kg)',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: titleColor,
                      fontWeight: FontWeight.bold,
                      shadows: isNeon
                          ? [
                              Shadow(
                                color: AppColors.neonGreen.withOpacity(0.5),
                                blurRadius: 10,
                              )
                            ]
                          : null,
                    ),
                textAlign: TextAlign.center,
              ),

            const SizedBox(height: 24),

            // --- GRÁFICO ---
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator(color: loadingColor))
                  : _selectedMuscleGroup == null
                      ? _buildEmptyState(isNeon)
                      : _chartData.isEmpty
                          ? Center(
                              child: Text(
                                'Sem dados históricos para exibir.',
                                style: TextStyle(
                                  color: isNeon ? Colors.grey : Colors.black54,
                                ),
                              ),
                            )
                          : _selectedExercise == null
                              ? _buildVolumeChart(isNeon) // Barras (Séries)
                              : _buildWeightChart(isNeon), // Linha (Peso)
            ),
          ],
        ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isNeon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.show_chart,
            size: 64,
            color: isNeon ? AppColors.neonPurple.withOpacity(0.5) : Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Selecione um grupo muscular',
            style: TextStyle(
              color: isNeon ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // GRÁFICO DE LINHA (PESO) - Estilo Neon Green
  Widget _buildWeightChart(bool isNeon) {
    final lineColor = isNeon ? AppColors.neonGreen : Theme.of(context).primaryColor;
    final gridColor = isNeon ? Colors.white10 : Colors.grey.withOpacity(0.2);
    final textColor = isNeon ? Colors.grey[400] : Colors.black54;

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) => FlLine(
            color: gridColor,
            strokeWidth: 1,
          ),
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= 0 && value.toInt() < _chartData.length) {
                  final date = _chartData[value.toInt()]['date'] as DateTime;
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      DateFormat('dd/MM').format(date),
                      style: TextStyle(fontSize: 10, color: textColor),
                    ),
                  );
                }
                return const Text('');
              },
              interval: 1,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: TextStyle(fontSize: 10, color: textColor),
                );
              },
            ),
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
            color: lineColor,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: isNeon ? Colors.black : Colors.white,
                  strokeWidth: 2,
                  strokeColor: lineColor,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  lineColor.withOpacity(isNeon ? 0.3 : 0.2),
                  lineColor.withOpacity(0.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // GRÁFICO DE BARRAS (SÉRIES) - Estilo Neon Purple
  Widget _buildVolumeChart(bool isNeon) {
    final barColor = isNeon ? AppColors.neonPurple : Theme.of(context).primaryColor;
    final gridColor = isNeon ? Colors.white10 : Colors.grey.withOpacity(0.2);
    final textColor = isNeon ? Colors.grey[400] : Colors.black54;

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: _getMaxSeries() * 1.2,
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
                      style: TextStyle(fontSize: 10, color: textColor),
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
              interval: 1,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: TextStyle(fontSize: 10, color: textColor),
                );
              },
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 1,
          getDrawingHorizontalLine: (value) => FlLine(
            color: gridColor,
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: _chartData.asMap().entries.map((entry) {
          final int val = entry.value['series'] as int;
          return BarChartGroupData(
            x: entry.key,
            barRods: [
              BarChartRodData(
                toY: val.toDouble(),
                gradient: isNeon
                    ? const LinearGradient(
                        colors: [AppColors.neonPurple, AppColors.secondary],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      )
                    : null,
                color: isNeon ? null : barColor,
                width: 16,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
              ),
            ],
            showingTooltipIndicators: [0],
          );
        }).toList(),
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            // Tooltip com cor de fundo escura no Neon
            getTooltipColor: (group) => isNeon ? AppColors.neonCard : Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                rod.toY.round().toString(),
                TextStyle(
                  color: isNeon ? AppColors.neonGreen : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
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
