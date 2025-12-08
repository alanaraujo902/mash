import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// Widget que aplica borda gradiente neon sólida de 2px e brilho correspondente
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

    return Container(
      margin: margin,
      // 1. Camada de Sombra/Brilho (O Glow Gradiente)
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          // Sombra Roxa (Vem do topo/esquerda)
          BoxShadow(
            color: AppColors.neonPurple.withOpacity(0.5),
            blurRadius: 16,
            offset: const Offset(-2, -2),
            spreadRadius: 0,
          ),
          // Sombra Verde (Vem de baixo/direita)
          BoxShadow(
            color: AppColors.neonGreen.withOpacity(0.5),
            blurRadius: 16,
            offset: const Offset(2, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Container(
        // 2. Camada da Borda Gradiente (O fundo colorido que vira a borda)
        padding: const EdgeInsets.all(2.0), // AQUI ESTÁ A ESPESSURA DA BORDA SÓLIDA
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: const LinearGradient(
            colors: [AppColors.neonPurple, AppColors.neonGreen],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Container(
          // 3. Camada do Conteúdo (O miolo escuro)
          decoration: BoxDecoration(
            color: AppColors.neonCard,
            // Subtraímos a espessura da borda para o radius ficar perfeito internamente
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

