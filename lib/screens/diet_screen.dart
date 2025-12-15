import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/diet_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/neon_card.dart';
import '../utils/app_colors.dart';

class DietScreen extends StatefulWidget {
  const DietScreen({Key? key}) : super(key: key);

  @override
  State<DietScreen> createState() => _DietScreenState();
}

class _DietScreenState extends State<DietScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => 
      context.read<DietProvider>().loadMeals(DateTime.now())
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final provider = context.read<DietProvider>();
    final isNeon = context.read<ThemeProvider>().isNeon;
    final picked = await showDatePicker(
      context: context,
      initialDate: provider.selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        if (isNeon) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.dark(
                primary: AppColors.neonPurple,
                onPrimary: Colors.white,
                surface: AppColors.neonCard,
                onSurface: Colors.white,
              ),
              dialogBackgroundColor: AppColors.neonBackground,
            ),
            child: child!,
          );
        }
        return child!;
      },
    );
    if (picked != null) {
      provider.loadMeals(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isNeon = context.watch<ThemeProvider>().isNeon;
    final provider = context.watch<DietProvider>();
    final totals = provider.dailyTotals;
    final goals = provider.userGoal;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dieta & Nutrição'),
        actions: [
          // DATA
          TextButton.icon(
            onPressed: () => _pickDate(context),
            icon: const Icon(Icons.calendar_today, size: 16),
            label: Text(
              DateFormat('dd/MM').format(provider.selectedDate),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          // CONFIGURAÇÃO DE METAS
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Configurar Metas',
            onPressed: () => _showGoalsDialog(context, isNeon, provider),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddMealDialog(context, isNeon),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. CARD DE RESUMO COM PROGRESSO
              NeonCard(
                isNeon: isNeon,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Resumo do Dia',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isNeon ? AppColors.neonGreen : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // CALORIAS (Destaque Maior)
                    _buildProgressBar(
                      label: 'Calorias',
                      current: totals['calories']!,
                      target: goals?.caloriesTarget ?? 2000,
                      color: Colors.orange,
                      isNeon: isNeon,
                      unit: 'kcal',
                    ),
                    const SizedBox(height: 16),

                    // MACROS (Agora um abaixo do outro)
                    _buildProgressBar(
                      label: 'Proteína',
                      current: totals['protein']!,
                      target: goals?.proteinTarget ?? 150,
                      color: Colors.blue,
                      isNeon: isNeon,
                      unit: 'g',
                    ),
                    const SizedBox(height: 16),
                    _buildProgressBar(
                      label: 'Carboidratos',
                      current: totals['carbs']!,
                      target: goals?.carbsTarget ?? 250,
                      color: Colors.green,
                      isNeon: isNeon,
                      unit: 'g',
                    ),
                    const SizedBox(height: 16),
                    _buildProgressBar(
                      label: 'Gordura',
                      current: totals['totalFat']!,
                      target: goals?.fatTarget ?? 70,
                      color: Colors.redAccent,
                      isNeon: isNeon,
                      unit: 'g',
                    ),

                    const Divider(height: 32),
                    
                    // MICROS (Texto Simples)
                    Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildMicroInfo('Saturada: ${totals['saturatedFat']!.toStringAsFixed(1)}g', isNeon),
                        _buildMicroInfo('Fibras: ${totals['fiber']!.toStringAsFixed(1)}g', isNeon),
                        _buildMicroInfo('Sódio: ${totals['sodium']!.toStringAsFixed(0)}mg', isNeon),
                        _buildMicroInfo('Cálcio: ${totals['calcium']!.toStringAsFixed(0)}mg', isNeon),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 24),
              Text(
                'Refeições (${provider.dailyMeals.length})',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),

              // 2. LISTA DE REFEIÇÕES
              if (provider.dailyMeals.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Center(child: Text("Nenhuma refeição registrada hoje.", style: TextStyle(color: Colors.grey))),
                )
              else
                ...provider.dailyMeals.map((meal) {
                  return NeonCard(
                    isNeon: isNeon,
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ExpansionTile(
                      title: Text(
                        'Refeição ${meal.mealIndex}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isNeon ? Colors.white : Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        '${meal.calories.toStringAsFixed(0)} kcal',
                        style: TextStyle(color: isNeon ? AppColors.neonGreen : Colors.green),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => provider.deleteMeal(meal.id),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Wrap(
                            spacing: 12,
                            runSpacing: 8,
                            children: [
                              _buildDetailTag('Carb: ${meal.carbs}g', isNeon),
                              _buildDetailTag('Prot: ${meal.protein}g', isNeon),
                              _buildDetailTag('Gord: ${meal.totalFat}g', isNeon),
                              _buildDetailTag('Sat: ${meal.saturatedFat}g', isNeon),
                              _buildDetailTag('Fib: ${meal.fiber}g', isNeon),
                              _buildDetailTag('Sod: ${meal.sodium}mg', isNeon),
                              _buildDetailTag('Cal: ${meal.calcium}mg', isNeon),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  // WIDGET DE BARRA DE PROGRESSO
  Widget _buildProgressBar({
    required String label,
    required double current,
    required double target,
    required Color color,
    required bool isNeon,
    required String unit,
  }) {
    double progress = target > 0 ? (current / target) : 0.0;
    if (progress > 1.0) progress = 1.0;
    final percentage = (progress * 100).toStringAsFixed(0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                label, 
                style: TextStyle(
                  fontSize: 14, 
                  fontWeight: FontWeight.w600,
                  color: isNeon ? Colors.white : Colors.black87
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${current.toStringAsFixed(0)} / ${target.toStringAsFixed(0)}$unit',
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold,
                color: isNeon ? Colors.white : Colors.black87
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color, width: 1),
              ),
              child: Text(
                '$percentage%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: isNeon ? Colors.grey[800] : Colors.grey[200],
            color: color,
            minHeight: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildMicroInfo(String text, bool isNeon) {
    return Text(text, style: TextStyle(fontSize: 11, color: isNeon ? Colors.grey[400] : Colors.grey[700]));
  }

  Widget _buildDetailTag(String text, bool isNeon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isNeon ? Colors.white10 : Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(text, style: TextStyle(fontSize: 11, color: isNeon ? Colors.white70 : Colors.black87)),
    );
  }

  // DIALOG DE METAS
  Future<void> _showGoalsDialog(BuildContext context, bool isNeon, DietProvider provider) async {
    final goals = provider.userGoal;
    
    // Converte os números para String, trocando ponto por vírgula para exibir
    String format(double val) => val.toString().replaceAll('.', ',');

    final calCtrl = TextEditingController(text: format(goals?.caloriesTarget ?? 2000));
    final protCtrl = TextEditingController(text: format(goals?.proteinTarget ?? 150));
    final carbCtrl = TextEditingController(text: format(goals?.carbsTarget ?? 250));
    final fatCtrl = TextEditingController(text: format(goals?.fatTarget ?? 70));

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isNeon ? AppColors.neonCard : null,
        title: Text('Definir Metas Diárias', style: TextStyle(color: isNeon ? Colors.white : null)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildInput(calCtrl, 'Calorias (kcal)', isNeon),
              _buildInput(protCtrl, 'Proteínas (g)', isNeon),
              _buildInput(carbCtrl, 'Carboidratos (g)', isNeon),
              _buildInput(fatCtrl, 'Gorduras (g)', isNeon),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              // Provider já tem o helper parseValue que trata vírgula
              provider.saveGoals(
                calories: provider.parseValue(calCtrl.text),
                protein: provider.parseValue(protCtrl.text),
                carbs: provider.parseValue(carbCtrl.text),
                fat: provider.parseValue(fatCtrl.text),
              );
              Navigator.pop(ctx);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  // DIALOG DE ADICIONAR REFEIÇÃO (Com suporte a vírgula)
  Future<void> _showAddMealDialog(BuildContext context, bool isNeon) async {
    final controllers = {
      'calories': TextEditingController(),
      'carbs': TextEditingController(),
      'protein': TextEditingController(),
      'totalFat': TextEditingController(),
      'saturatedFat': TextEditingController(),
      'fiber': TextEditingController(),
      'sodium': TextEditingController(),
      'calcium': TextEditingController(),
    };

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isNeon ? AppColors.neonCard : null,
        title: Text('Adicionar Refeição', style: TextStyle(color: isNeon ? Colors.white : null)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildInput(controllers['calories']!, 'Calorias (kcal)', isNeon, autoFocus: true),
              _buildInput(controllers['protein']!, 'Proteínas (g)', isNeon),
              _buildInput(controllers['carbs']!, 'Carboidratos (g)', isNeon),
              _buildInput(controllers['totalFat']!, 'Gorduras Totais (g)', isNeon),
              _buildInput(controllers['saturatedFat']!, 'Gorduras Saturadas (g)', isNeon),
              _buildInput(controllers['fiber']!, 'Fibras (g)', isNeon),
              _buildInput(controllers['sodium']!, 'Sódio (mg)', isNeon),
              _buildInput(controllers['calcium']!, 'Cálcio (mg)', isNeon),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              // Envia as STRINGS para o provider tratar a vírgula
              context.read<DietProvider>().addMeal(
                calories: controllers['calories']!.text,
                carbs: controllers['carbs']!.text,
                protein: controllers['protein']!.text,
                totalFat: controllers['totalFat']!.text,
                saturatedFat: controllers['saturatedFat']!.text,
                fiber: controllers['fiber']!.text,
                sodium: controllers['sodium']!.text,
                calcium: controllers['calcium']!.text,
              );
              Navigator.pop(ctx);
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  Widget _buildInput(TextEditingController ctrl, String label, bool isNeon, {bool autoFocus = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: ctrl,
        autofocus: autoFocus,
        // TextInputType.numberWithOptions(decimal: true) é melhor para teclados numéricos
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: TextStyle(color: isNeon ? Colors.white : Colors.black),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: isNeon ? Colors.grey : null),
          border: const OutlineInputBorder(),
          enabledBorder: isNeon ? const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)) : null,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
    );
  }
}