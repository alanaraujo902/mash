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

  // Seletor de Data
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dieta & Nutrição'),
        actions: [
          TextButton.icon(
            onPressed: () => _pickDate(context),
            icon: const Icon(Icons.calendar_today, size: 16),
            label: Text(
              DateFormat('dd/MM/yyyy').format(provider.selectedDate),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
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
              // 1. CARD DE TOTAIS
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
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildMacroInfo('Calorias', '${totals['calories']!.toStringAsFixed(0)} kcal', isNeon),
                        _buildMacroInfo('Carbo', '${totals['carbs']!.toStringAsFixed(1)} g', isNeon),
                        _buildMacroInfo('Prot', '${totals['protein']!.toStringAsFixed(1)} g', isNeon),
                        _buildMacroInfo('Gord', '${totals['totalFat']!.toStringAsFixed(1)} g', isNeon),
                      ],
                    ),
                    const Divider(height: 24),
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

  Widget _buildMacroInfo(String label, String value, bool isNeon) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isNeon ? Colors.white : Colors.black87)),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
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
              _buildInput(controllers['carbs']!, 'Carboidratos (g)', isNeon),
              _buildInput(controllers['protein']!, 'Proteínas (g)', isNeon),
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
              context.read<DietProvider>().addMeal(
                calories: double.tryParse(controllers['calories']!.text) ?? 0,
                carbs: double.tryParse(controllers['carbs']!.text) ?? 0,
                protein: double.tryParse(controllers['protein']!.text) ?? 0,
                totalFat: double.tryParse(controllers['totalFat']!.text) ?? 0,
                saturatedFat: double.tryParse(controllers['saturatedFat']!.text) ?? 0,
                fiber: double.tryParse(controllers['fiber']!.text) ?? 0,
                sodium: double.tryParse(controllers['sodium']!.text) ?? 0,
                calcium: double.tryParse(controllers['calcium']!.text) ?? 0,
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
        keyboardType: TextInputType.number,
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
