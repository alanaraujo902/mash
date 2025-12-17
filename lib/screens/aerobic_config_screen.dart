import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/aerobic_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/neon_card.dart';
import '../utils/app_colors.dart';

class AerobicConfigScreen extends StatefulWidget {
  const AerobicConfigScreen({Key? key}) : super(key: key);

  @override
  State<AerobicConfigScreen> createState() => _AerobicConfigScreenState();
}

class _AerobicConfigScreenState extends State<AerobicConfigScreen> {
  AerobicType _selectedType = AerobicType.running; // Controle local

  // Controles manuais
  double _level = 1;
  double _warmupMin = 5;
  double _mainSec = 60;
  double _recSec = 120;
  double _reps = 8;
  double _cooldownMin = 5;
  
  bool _isManualMode = false;

  // Controllers para os campos de texto
  late TextEditingController _warmupController;
  late TextEditingController _mainController;
  late TextEditingController _recController;
  late TextEditingController _repsController;
  late TextEditingController _cooldownController;

  @override
  void initState() {
    super.initState();
    // Inicializa controllers
    _warmupController = TextEditingController();
    _mainController = TextEditingController();
    _recController = TextEditingController();
    _repsController = TextEditingController();
    _cooldownController = TextEditingController();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadValues();
    });
  }

  @override
  void dispose() {
    _warmupController.dispose();
    _mainController.dispose();
    _recController.dispose();
    _repsController.dispose();
    _cooldownController.dispose();
    super.dispose();
  }

  void _loadValues() {
    final provider = context.read<AerobicProvider>();
    final session = provider.getEffectiveSession(_selectedType);
    
    setState(() {
      _level = (provider.getProgress(_selectedType)?.currentLevel ?? 1).toDouble();
      _warmupMin = session.warmupMinutes.toDouble();
      _mainSec = session.mainIntervalSeconds.toDouble();
      _recSec = session.recoveryIntervalSeconds.toDouble();
      _reps = session.repetitions.toDouble();
      _cooldownMin = session.cooldownMinutes.toDouble();
      
      // Atualiza controllers
      _warmupController.text = _warmupMin.toInt().toString();
      _mainController.text = _mainSec.toInt().toString();
      _recController.text = _recSec.toInt().toString();
      _repsController.text = _reps.toInt().toString();
      _cooldownController.text = _cooldownMin.toInt().toString();
    });
  }

  void _updateManualSession() {
    setState(() => _isManualMode = true);
    
    final session = AerobicSessionStructure(
      type: _selectedType,
      level: _level.toInt(),
      description: "Personalizado",
      warmupMinutes: _warmupMin.toInt(),
      mainIntervalSeconds: _mainSec.toInt(),
      recoveryIntervalSeconds: _recSec.toInt(),
      repetitions: _reps.toInt(),
      cooldownMinutes: _cooldownMin.toInt(),
    );
    
    context.read<AerobicProvider>().setCustomSession(session);
  }

  void _resetToAuto() {
    setState(() => _isManualMode = false);
    context.read<AerobicProvider>().clearCustomSession();
    
    final provider = context.read<AerobicProvider>();
    final session = provider.getSessionForLevel(_selectedType, _level.toInt());
    
    setState(() {
      _warmupMin = session.warmupMinutes.toDouble();
      _mainSec = session.mainIntervalSeconds.toDouble();
      _recSec = session.recoveryIntervalSeconds.toDouble();
      _reps = session.repetitions.toDouble();
      _cooldownMin = session.cooldownMinutes.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isNeon = context.watch<ThemeProvider>().isNeon;
    final provider = context.watch<AerobicProvider>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SELETOR DE TIPO
          NeonCard(
            isNeon: isNeon,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<AerobicType>(
                value: _selectedType,
                dropdownColor: isNeon ? AppColors.neonCard : Colors.white,
                isExpanded: true,
                items: const [
                  DropdownMenuItem(
                    value: AerobicType.running,
                    child: Row(children: [Icon(Icons.directions_run), SizedBox(width: 8), Text("Corrida")]),
                  ),
                  DropdownMenuItem(
                    value: AerobicType.cycling,
                    child: Row(children: [Icon(Icons.directions_bike), SizedBox(width: 8), Text("Bike Spin")]),
                  ),
                ],
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _selectedType = val;
                      _isManualMode = false; // Reseta manual ao trocar tipo
                    });
                    _loadValues(); // Recarrega dados do novo tipo
                  }
                },
              ),
            ),
          ),

          const SizedBox(height: 16),

          // CARD NÍVEL
          NeonCard(
            isNeon: isNeon,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nível de Progressão (${_selectedType == AerobicType.running ? 'Corrida' : 'Bike'})",
                  style: TextStyle(fontWeight: FontWeight.bold, color: isNeon ? AppColors.neonGreen : Colors.black87),
                ),
                const SizedBox(height: 8),
                Text(
                  "Altere aqui se o plano estiver muito fácil ou difícil no geral.",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Nível Atual:"),
                    Text(
                      "${_level.toInt()}",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isNeon ? Colors.white : Colors.black),
                    ),
                  ],
                ),
                Slider(
                  value: _level,
                  min: 1,
                  max: 30,
                  divisions: 29,
                  label: _level.toInt().toString(),
                  activeColor: isNeon ? AppColors.neonGreen : Colors.blue,
                  onChanged: (val) {
                    setState(() => _level = val);
                  },
                  onChangeEnd: (val) {
                    provider.updateLevelManually(_selectedType, val.toInt());
                    _resetToAuto(); 
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // CARD CUSTOMIZAÇÃO
          NeonCard(
            isNeon: isNeon,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ajustar Treino de Hoje",
                            style: TextStyle(fontWeight: FontWeight.bold, color: isNeon ? AppColors.neonPurple : Colors.black87),
                          ),
                          if (_isManualMode)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                "(Modo Personalizado Ativo)",
                                style: TextStyle(fontSize: 10, color: Colors.orange, fontWeight: FontWeight.bold),
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (_isManualMode)
                      TextButton(
                        onPressed: _resetToAuto,
                        child: const Text("Resetar"),
                      ),
                  ],
                ),
                const Divider(),
                
                _buildInputRow("Aquecimento", _warmupMin, 0, 20, " min", _warmupController, (v) { _warmupMin = v; _updateManualSession(); }, isNeon),
                _buildInputRow(
                  _selectedType == AerobicType.running ? "Correr (Forte)" : "RPM Constante / Forte", 
                  _mainSec, 0, 1800, " s", _mainController, (v) { _mainSec = v; _updateManualSession(); }, isNeon, divisions: 60
                ),
                _buildInputRow(
                  _selectedType == AerobicType.running ? "Caminhar (Leve)" : "Recuperação / Leve", 
                  _recSec, 0, 600, " s", _recController, (v) { _recSec = v; _updateManualSession(); }, isNeon, divisions: 20
                ),
                _buildInputRow("Repetições", _reps, 1, 20, "x", _repsController, (v) { _reps = v; _updateManualSession(); }, isNeon, divisions: 19),
                _buildInputRow("Washout/Desaq.", _cooldownMin, 0, 20, " min", _cooldownController, (v) { _cooldownMin = v; _updateManualSession(); }, isNeon),

                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isNeon ? Colors.white10 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Tempo Total Estimado:"),
                      Text(
                        "${((_warmupMin*60 + _reps*(_mainSec+_recSec) + _cooldownMin*60)/60).toStringAsFixed(0)} min",
                        style: TextStyle(fontWeight: FontWeight.bold, color: isNeon ? Colors.white : Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputRow(
    String label, 
    double value, 
    double min,
    double max,
    String unit, 
    TextEditingController controller,
    Function(double) onChanged, 
    bool isNeon,
    {int? divisions}
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label, 
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                "${value.toInt()}$unit", 
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  color: isNeon ? Colors.white70 : Colors.black87,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Campo de texto e slider lado a lado
          Row(
            children: [
              // Campo de texto
              Expanded(
                flex: 2,
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: isNeon ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    suffixText: unit,
                    suffixStyle: TextStyle(
                      color: isNeon ? Colors.white70 : Colors.black87,
                      fontSize: 12,
                    ),
                    filled: true,
                    fillColor: isNeon ? Colors.white10 : Colors.grey.shade100,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: isNeon ? AppColors.neonPurple : Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: isNeon ? AppColors.neonPurple.withOpacity(0.5) : Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: isNeon ? AppColors.neonGreen : Colors.blue,
                        width: 2,
                      ),
                    ),
                  ),
                  onChanged: (text) {
                    final parsed = double.tryParse(text);
                    if (parsed != null && parsed >= min && parsed <= max) {
                      setState(() => onChanged(parsed));
                    }
                  },
                  onSubmitted: (text) {
                    final parsed = double.tryParse(text);
                    if (parsed != null && parsed >= min && parsed <= max) {
                      setState(() {
                        onChanged(parsed);
                        controller.text = parsed.toInt().toString();
                      });
                    } else {
                      // Se inválido, restaura o valor anterior
                      controller.text = value.toInt().toString();
                    }
                  },
                ),
              ),
              const SizedBox(width: 12),
              // Slider
              Expanded(
                flex: 3,
                child: Slider(
                  value: value.clamp(min, max),
                  min: min,
                  max: max,
                  divisions: divisions,
                  activeColor: isNeon ? AppColors.neonPurple : Colors.blue,
                  onChanged: (val) {
                    setState(() {
                      onChanged(val);
                      controller.text = val.toInt().toString();
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

