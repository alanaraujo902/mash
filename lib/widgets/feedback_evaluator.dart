import 'dart:convert';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class FeedbackEvaluator extends StatefulWidget {
  final bool isNeon;
  final Function(String jsonResult) onFeedbackChanged;

  const FeedbackEvaluator({
    Key? key,
    required this.isNeon,
    required this.onFeedbackChanged,
  }) : super(key: key);

  @override
  State<FeedbackEvaluator> createState() => _FeedbackEvaluatorState();
}

class _FeedbackEvaluatorState extends State<FeedbackEvaluator> {
  // Estado do formulário
  String? _progression; // Carga leve, ideal, etc.
  final Set<String> _limiters = {}; // Dor, Fôlego, etc.
  final Set<String> _sensations = {}; // Pump, Satisfação

  // Dados Estáticos
  final List<String> _progressionOptions = [
    'Leve demais',
    'Ideal / Ótimo',
    'Pesado (Tolerável)',
    'Quase falha (RIR 1-2)',
    'Falha total',
  ];

  final Map<String, List<String>> _limiterCategories = {
    'Geral': ['Força', 'Gás/Cardio', 'Mental', 'Técnica'],
    'Dor/Desconforto': ['Articular', 'Muscular Aguda', 'Tendão', 'Lombar', 'Ombro', 'Joelho'],
    'Fadiga Local': ['Queimação', 'Câimbra', 'Falha Estabilizador'],
    'Mecânica': ['Mobilidade', 'Amplitude', 'Respiração'],
  };

  final List<String> _sensationOptions = [
    'Pump Alto',
    'Pump Baixo',
    'Sentiu Alvo',
    'Não sentiu Alvo',
    'Satisfação',
    'Frustração',
  ];

  void _updateFeedback() {
    final data = {
      'progression': _progression,
      'limiters': _limiters.toList(),
      'sensations': _sensations.toList(),
    };
    widget.onFeedbackChanged(jsonEncode(data));
  }

  @override
  Widget build(BuildContext context) {
    final textColor = widget.isNeon ? Colors.white : Colors.black87;
    final subtitleColor = widget.isNeon ? AppColors.neonGreen : Colors.blue[800];
    final chipColor = widget.isNeon ? AppColors.neonPurple.withOpacity(0.1) : Colors.grey[100];
    final selectedChipColor = widget.isNeon ? AppColors.neonPurple.withOpacity(0.4) : Colors.blue[100];
    final borderColor = widget.isNeon ? AppColors.neonPurple.withOpacity(0.5) : Colors.grey[300]!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        _buildHeader('📊 Como foi a carga?', subtitleColor),
        Wrap(
          spacing: 8,
          children: _progressionOptions.map((option) {
            final isSelected = _progression == option;
            return ChoiceChip(
              label: Text(option),
              selected: isSelected,
              onSelected: (selected) {
                setState(() => _progression = selected ? option : null);
                _updateFeedback();
              },
              selectedColor: selectedChipColor,
              backgroundColor: chipColor,
              labelStyle: TextStyle(
                color: isSelected ? (widget.isNeon ? Colors.white : Colors.blue[900]) : textColor,
                fontSize: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: isSelected ? (widget.isNeon ? AppColors.neonGreen : Colors.blue) : borderColor),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 16),
        _buildHeader('⚠️ O que limitou?', subtitleColor),
        ..._limiterCategories.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 4),
                child: Text(entry.key, style: TextStyle(color: Colors.grey, fontSize: 11)),
              ),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: entry.value.map((tag) {
                  final isSelected = _limiters.contains(tag);
                  return FilterChip(
                    label: Text(tag),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) _limiters.add(tag);
                        else _limiters.remove(tag);
                      });
                      _updateFeedback();
                    },
                    selectedColor: widget.isNeon ? Colors.red.withOpacity(0.3) : Colors.red[100],
                    backgroundColor: chipColor,
                    checkmarkColor: widget.isNeon ? Colors.redAccent : Colors.red,
                    labelStyle: TextStyle(
                      fontSize: 11,
                      color: isSelected ? (widget.isNeon ? Colors.white : Colors.red[900]) : textColor,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: BorderSide(color: isSelected ? Colors.redAccent : borderColor),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        }).toList(),

        const SizedBox(height: 16),
        _buildHeader('🧠 Sensação Final', subtitleColor),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: _sensationOptions.map((tag) {
            final isSelected = _sensations.contains(tag);
            return FilterChip(
              label: Text(tag),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) _sensations.add(tag);
                  else _sensations.remove(tag);
                });
                _updateFeedback();
              },
              selectedColor: widget.isNeon ? AppColors.neonGreen.withOpacity(0.3) : Colors.green[100],
              backgroundColor: chipColor,
              labelStyle: TextStyle(
                fontSize: 11,
                color: isSelected ? (widget.isNeon ? Colors.white : Colors.green[900]) : textColor,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
                side: BorderSide(color: isSelected ? AppColors.neonGreen : borderColor),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildHeader(String title, Color? color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}

