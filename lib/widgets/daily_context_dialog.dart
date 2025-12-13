import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/daily_context_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/app_colors.dart';

class DailyContextDialog extends StatefulWidget {
  const DailyContextDialog({Key? key}) : super(key: key);

  @override
  State<DailyContextDialog> createState() => _DailyContextDialogState();
}

class _DailyContextDialogState extends State<DailyContextDialog> {
  final Set<String> _sleepTags = {};
  final Set<String> _nutritionTags = {};
  final Set<String> _stressTags = {};

  // ATUALIZADO: Agora com opções positivas e negativas misturadas
  final Map<String, List<String>> _options = {
    '💤 Sono': [
      'Dormiu bem',       // Positivo
      'Acordou disposto', // Positivo
      'Sono Profundo',    // Positivo
      'Dormiu mal',
      'Acordou cansado',
      'Dormiu pouco',
      'Insônia',
    ],
    '🍔 Nutrição / Hidratação': [
      'Bem alimentado',   // Positivo
      'Bem hidratado',    // Positivo
      'Creatina em dia',  // Positivo
      'Baixo carboidrato',
      'Pulou refeição',
      'Pouca água',
      'Treino em jejum',
    ],
    '🤯 Stress / Humor': [
      'Motivado',         // Positivo
      'Focado',           // Positivo
      'Energia alta',     // Positivo
      'Tranquilo',        // Positivo
      'Stress alto',
      'Ansiedade',
      'Sem vontade',
      'Cansaço mental',
    ],
  };

  @override
  Widget build(BuildContext context) {
    final isNeon = context.watch<ThemeProvider>().isNeon;
    final bgColor = isNeon ? AppColors.neonCard : Colors.white;
    final textColor = isNeon ? Colors.white : Colors.black87;
    final activeColor = isNeon ? AppColors.neonPurple : Theme.of(context).primaryColor;

    return AlertDialog(
      backgroundColor: bgColor,
      title: Text(
        'Contexto do Dia',
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Como você está hoje? Registre fatores positivos e negativos.',
                style: TextStyle(color: isNeon ? Colors.grey[400] : Colors.grey[600], fontSize: 13),
              ),
              const SizedBox(height: 16),
              
              ..._options.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        entry.key,
                        style: TextStyle(
                          color: isNeon ? AppColors.neonGreen : Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: entry.value.map((tag) {
                        Set<String> targetSet;
                        if (entry.key.contains('Sono')) {
                          targetSet = _sleepTags;
                        } else if (entry.key.contains('Nutri')) {
                          targetSet = _nutritionTags;
                        } else {
                          targetSet = _stressTags;
                        }

                        final isSelected = targetSet.contains(tag);

                        return FilterChip(
                          label: Text(tag),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                targetSet.add(tag);
                              } else {
                                targetSet.remove(tag);
                              }
                            });
                          },
                          // Cores ajustadas para o tema
                          backgroundColor: isNeon ? Colors.white10 : Colors.grey[100],
                          selectedColor: activeColor.withOpacity(0.2),
                          checkmarkColor: activeColor,
                          labelStyle: TextStyle(
                            color: isSelected ? activeColor : (isNeon ? Colors.white70 : Colors.black87),
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: isSelected ? activeColor : Colors.transparent,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Salvar vazio ao pular
            context.read<DailyContextProvider>().saveContext(
              sleepTags: [], nutritionTags: [], stressTags: []
            );
            Navigator.pop(context, true);
          },
          child: const Text('Pular'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: activeColor,
            foregroundColor: Colors.white,
          ),
          onPressed: () async {
            await context.read<DailyContextProvider>().saveContext(
              sleepTags: _sleepTags.toList(),
              nutritionTags: _nutritionTags.toList(),
              stressTags: _stressTags.toList(),
            );
            if (context.mounted) Navigator.pop(context, true);
          },
          child: const Text('Salvar e Treinar'),
        ),
      ],
    );
  }
}
