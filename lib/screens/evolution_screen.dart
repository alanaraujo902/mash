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
    // Carregar dados detalhados (Carga + Volume) do exercício
    final historyData = await db.getExerciseHistoryDetails(exercise.id);

    if (mounted) {
      setState(() {
        _chartData = historyData;
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

    // REMOVIDO: Scaffold e AppBar - agora é apenas o conteúdo
    return Padding(
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

            // --- TÍTULO DO GRÁFICO E LEGENDAS ---
            if (_selectedMuscleGroup != null) ...[
              Text(
                _selectedExercise == null
                    ? 'Volume Total por Grupo (kg)'
                    : '${_selectedExercise!.name}',
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
              if (_selectedExercise != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLegendItem(
                        'Carga Máx (Verde)',
                        isNeon ? AppColors.neonGreen : Colors.green,
                      ),
                      const SizedBox(width: 16),
                      _buildLegendItem(
                        'Volume Load (Barra)',
                        isNeon ? AppColors.neonPurple : AppColors.primary,
                      ),
                    ],
                  ),
                ),
            ],

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
                              ? _buildVolumeBarChart(isNeon) // Gráfico Geral (Grupo)
                              : _buildExerciseDetailChart(isNeon), // Gráfico Detalhado (Exercício)
            ),
          ],
        ),
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return Row(
      children: [
        if (text.contains('Barra'))
          Container(width: 12, height: 12, color: color)
        else
          Text(
            '90kg',
            style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.bold, color: color),
          ),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
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

  // --- GRÁFICO DETALHADO POR EXERCÍCIO (Volume + Carga) ---
  Widget _buildExerciseDetailChart(bool isNeon) {
    final barColor =
        isNeon ? AppColors.neonPurple : Theme.of(context).primaryColor;
    final maxWeightColor =
        isNeon ? AppColors.neonGreen : const Color(0xFF00C853); // Verde
    final gridColor = isNeon ? Colors.white10 : Colors.grey.withOpacity(0.2);
    final textColor = isNeon ? Colors.grey[400] : Colors.black54;
    final volumeTextColor = isNeon ? Colors.white : Colors.black87;

    // Calcular máximo
    double maxVolume = 0;
    for (var d in _chartData) {
      final v = (d['volume'] as num).toDouble();
      if (v > maxVolume) maxVolume = v;
    }

    // Aumentamos o teto em 50% (1.5) para caber o texto longo na vertical
    double maxY = (maxVolume == 0 ? 100 : maxVolume) * 1.5;

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY,
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
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                if (value == 0) return const Text('');
                if (value >= 1000) {
                  return Text(
                    '${(value / 1000).toStringAsFixed(1)}k',
                    style: TextStyle(fontSize: 9, color: textColor),
                  );
                }
                return Text(
                  value.toInt().toString(),
                  style: TextStyle(fontSize: 9, color: textColor),
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
          getDrawingHorizontalLine: (_) => FlLine(
            color: gridColor,
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),

        // CONFIGURAÇÃO DOS LABELS VERTICAIS (Volume + Carga)
        barTouchData: BarTouchData(
          enabled: false,
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => Colors.transparent,
            tooltipPadding: EdgeInsets.zero,
            tooltipMargin: 5,
            rotateAngle: -90, // Texto Vertical
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              // Recupera o peso original
              final weight = (_chartData[group.x.toInt()]['weight'] as num);
              // Recupera o volume da barra
              final volume = rod.toY.toInt();

              return BarTooltipItem(
                '$volume ', // Volume por extenso
                TextStyle(
                  color: volumeTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
                children: [
                  TextSpan(
                    text: '(${weight.toStringAsFixed(0)}kg)', // Carga em Verde
                    style: TextStyle(
                      color: maxWeightColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              );
            },
          ),
        ),

        barGroups: _chartData.asMap().entries.map((entry) {
          final double volume = (entry.value['volume'] as num).toDouble();

          return BarChartGroupData(
            x: entry.key,
            showingTooltipIndicators: [0], // Força mostrar sempre
            barRods: [
              BarChartRodData(
                toY: volume,
                gradient: isNeon
                    ? const LinearGradient(
                        colors: [AppColors.neonPurple, AppColors.secondary],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      )
                    : null,
                color: isNeon ? null : barColor,
                width: 18,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(4)),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: maxY,
                  color: isNeon ? Colors.white.withOpacity(0.02) : Colors.grey.withOpacity(0.05),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  // --- GRÁFICO DE BARRAS (Volume Load por Grupo) ---
  Widget _buildVolumeBarChart(bool isNeon) {
    final barColor =
        isNeon ? AppColors.neonPurple : Theme.of(context).primaryColor;
    final gridColor = isNeon ? Colors.white10 : Colors.grey.withOpacity(0.2);
    final textColor = isNeon ? Colors.grey[400] : Colors.black54;
    final valColor = isNeon ? AppColors.neonGreen : Colors.black87;

    // Aumentamos o teto em 50% (1.5) para dar espaço ao texto vertical
    double maxVal = _getMaxVolumeLoad() * 1.5;

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxVal,
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
              reservedSize: 40, // Aumentado para caber números como "10k"
              getTitlesWidget: (value, meta) {
                if (value == 0) return const Text('');
                // Eixo Y continua abreviado para não poluir
                if (value >= 1000) {
                  return Text(
                    '${(value / 1000).toStringAsFixed(1)}k',
                    style: TextStyle(fontSize: 9, color: textColor),
                  );
                }
                return Text(
                  value.toInt().toString(),
                  style: TextStyle(fontSize: 9, color: textColor),
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
          getDrawingHorizontalLine: (value) => FlLine(
            color: gridColor,
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),

        // CONFIGURAÇÃO DOS LABELS VERTICAIS
        barTouchData: BarTouchData(
          enabled: false, // Desabilita o clique para focar na visualização fixa
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => Colors.transparent, // Fundo transparente
            tooltipPadding: EdgeInsets.zero,
            tooltipMargin: 5, // Distância do topo da barra
            rotateAngle: -90, // Gira o texto 90 graus anti-horário (Vertical)
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                rod.toY.toInt().toString(), // Número inteiro completo (ex: 12500)
                TextStyle(
                  color: valColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              );
            },
          ),
        ),

        barGroups: _chartData.asMap().entries.map((entry) {
          final double val = (entry.value['volume'] as num).toDouble();

          return BarChartGroupData(
            x: entry.key,
            showingTooltipIndicators: [0], // Força mostrar o texto sempre
            barRods: [
              BarChartRodData(
                toY: val,
                gradient: isNeon
                    ? const LinearGradient(
                        colors: [AppColors.neonPurple, AppColors.secondary],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      )
                    : null,
                color: isNeon ? null : barColor,
                width: 16,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(4)),
                // Adicionando um fundo bem sutil para a barra, ajuda na noção de escala
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: maxVal,
                  color: isNeon ? Colors.white.withOpacity(0.02) : Colors.grey.withOpacity(0.05),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  // Atualizar para garantir que o maxVal nunca seja zero para evitar erro de renderização
  double _getMaxVolumeLoad() {
    double max = 0;
    for (var item in _chartData) {
      final val = (item['volume'] as num).toDouble();
      if (val > max) max = val;
    }
    // Se for 0, retorna 100 para o gráfico não quebrar e ter uma escala mínima
    return max == 0 ? 100 : max;
  }
}
