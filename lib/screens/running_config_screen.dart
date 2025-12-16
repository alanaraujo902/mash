import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/running_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/neon_card.dart';
import '../utils/app_colors.dart';

class RunningConfigScreen extends StatefulWidget {
  const RunningConfigScreen({Key? key}) : super(key: key);

  @override
  State<RunningConfigScreen> createState() => _RunningConfigScreenState();
}

class _RunningConfigScreenState extends State<RunningConfigScreen> {
  // Controles manuais
  double _level = 1;
  double _warmupMin = 5;
  double _runSec = 60;
  double _walkSec = 120;
  double _reps = 8;
  double _cooldownMin = 5;
  
  bool _isManualMode = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadValues();
    });
  }

  void _loadValues() {
    final provider = context.read<RunningProvider>();
    final session = provider.getEffectiveSession();
    
    setState(() {
      _level = (provider.progress?.currentLevel ?? 1).toDouble();
      _warmupMin = session.warmupMinutes.toDouble();
      _runSec = session.runSeconds.toDouble();
      _walkSec = session.walkSeconds.toDouble();
      _reps = session.repetitions.toDouble();
      _cooldownMin = session.cooldownMinutes.toDouble();
      
      // Verifica se já existe uma customização ativa
      _isManualMode = provider.hasCustomSession;
    });
  }

  void _updateManualSession() {
    setState(() {
      _isManualMode = true;
    });
    
    final session = RunningSessionStructure(
      level: _level.toInt(),
      description: "Personalizado",
      warmupMinutes: _warmupMin.toInt(),
      runSeconds: _runSec.toInt(),
      walkSeconds: _walkSec.toInt(),
      repetitions: _reps.toInt(),
      cooldownMinutes: _cooldownMin.toInt(),
    );
    
    context.read<RunningProvider>().setCustomSession(session);
  }

  void _resetToAuto() {
    setState(() {
      _isManualMode = false;
    });
    context.read<RunningProvider>().clearCustomSession();
    
    // Recarrega valores do automático
    final provider = context.read<RunningProvider>();
    final session = provider.getSessionForLevel(_level.toInt());
    
    setState(() {
      _warmupMin = session.warmupMinutes.toDouble();
      _runSec = session.runSeconds.toDouble();
      _walkSec = session.walkSeconds.toDouble();
      _reps = session.repetitions.toDouble();
      _cooldownMin = session.cooldownMinutes.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isNeon = context.watch<ThemeProvider>().isNeon;
    final provider = context.watch<RunningProvider>();

    // REMOVIDO O SCAFFOLD E APPBAR, RETORNA APENAS O CONTEÚDO
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. SELETOR DE NÍVEL (Permanente)
          NeonCard(
            isNeon: isNeon,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nível de Progressão (Permanente)",
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
                    provider.updateLevelManually(val.toInt());
                    _resetToAuto(); 
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // 2. CUSTOMIZAÇÃO DO TREINO ATUAL (Temporário)
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
                
                _buildSliderRow("Aquecimento", _warmupMin, 0, 20, " min", (v) { _warmupMin = v; _updateManualSession(); }, isNeon),
                _buildSliderRow("Correr (Trote)", _runSec, 0, 600, " s", (v) { _runSec = v; _updateManualSession(); }, isNeon, divisions: 60),
                _buildSliderRow("Caminhar", _walkSec, 0, 300, " s", (v) { _walkSec = v; _updateManualSession(); }, isNeon, divisions: 30),
                _buildSliderRow("Repetições", _reps, 1, 20, "x", (v) { _reps = v; _updateManualSession(); }, isNeon, divisions: 19),
                _buildSliderRow("Desaquecimento", _cooldownMin, 0, 20, " min", (v) { _cooldownMin = v; _updateManualSession(); }, isNeon),

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
                        "${((_warmupMin*60 + _reps*(_runSec+_walkSec) + _cooldownMin*60)/60).toStringAsFixed(0)} min",
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

  Widget _buildSliderRow(
    String label, 
    double value, 
    double min, 
    double max, 
    String unit, 
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
              Text(label, style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text("${value.toInt()}$unit", style: TextStyle(fontWeight: FontWeight.bold, color: isNeon ? Colors.white70 : Colors.black87)),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            activeColor: isNeon ? AppColors.neonPurple : Colors.blue,
            onChanged: (val) {
              setState(() => onChanged(val));
            },
          ),
        ],
      ),
    );
  }
}
