import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// Widget que aplica borda gradiente neon aos cards quando o tema neon estiver ativo
class NeonCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final bool isNeon;

  const NeonCard({
    Key? key,
    required this.child,
    this.margin,
    this.padding,
    this.borderRadius = 12.0,
    required this.isNeon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isNeon) {
      // Se não for neon, retorna o card padrão
      return Card(
        margin: margin,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        ),
      );
    }

    // Estilo Neon com borda sólida gradiente de 2px + sombra
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          // Sombra neon roxa (topo esquerdo)
          BoxShadow(
            color: AppColors.neonPurple.withOpacity(0.5),
            blurRadius: 15,
            offset: const Offset(-4, -4),
            spreadRadius: 1,
          ),
          // Sombra neon verde (baixo direito)
          BoxShadow(
            color: AppColors.neonGreen.withOpacity(0.5),
            blurRadius: 15,
            offset: const Offset(4, 4),
            spreadRadius: 1,
          ),
          // Sombra geral para profundidade
          BoxShadow(
            color: AppColors.neonPurple.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          // Borda gradiente roxo→verde alinhada com o glow (2px)
          gradient: const LinearGradient(
            colors: [AppColors.neonPurple, AppColors.neonGreen],
            begin: Alignment.topLeft, // Alinhado com sombra roxa
            end: Alignment.bottomRight, // Alinhado com sombra verde
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(2), // Linha sólida de 2 pixels
          decoration: BoxDecoration(
            color: AppColors.neonCard,
            borderRadius: BorderRadius.circular(borderRadius - 2),
          ),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }
}

