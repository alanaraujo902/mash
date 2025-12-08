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

    // Estilo Neon com borda gradiente
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: const LinearGradient(
          colors: [AppColors.neonPurple, AppColors.neonGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonPurple.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(-4, -4),
          ),
          BoxShadow(
            color: AppColors.neonGreen.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(1.5), // Espessura da borda
        decoration: BoxDecoration(
          color: AppColors.neonCard,
          borderRadius: BorderRadius.circular(borderRadius - 1.5),
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}

