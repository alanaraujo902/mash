import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// Widget que aplica borda neon e brilho
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

    // Estilo Neon com Borda SÓLIDA
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: AppColors.neonCard, // Cor de fundo do cartão
        borderRadius: BorderRadius.circular(borderRadius),

        // --- Borda Sólida de 2px ---
        border: Border.all(
          color: AppColors.neonPurple, // Cor sólida (Roxo do brilho)
          width: 2.0, // Espessura sólida de 2 pixels
        ),
        // ----------------------------

        boxShadow: [
          // Sombra neon roxa (brilho de fundo)
          BoxShadow(
            color: AppColors.neonPurple.withOpacity(0.5),
            blurRadius: 15,
            offset: const Offset(0, 0), // Centralizado para brilhar em volta tudo
            spreadRadius: 1,
          ),
          // Sombra secundária para profundidade
          BoxShadow(
            color: AppColors.neonPurple.withOpacity(0.2),
            blurRadius: 30,
            offset: const Offset(0, 4),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}

