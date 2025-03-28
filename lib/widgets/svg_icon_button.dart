import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIconButton extends StatelessWidget {
  final String assetPath;
  final VoidCallback onPressed;
  final double size;
  final Color? color;

  const SvgIconButton({
    super.key,
    required this.assetPath,
    required this.onPressed,
    this.size = 24.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        assetPath,
        width: size,
        height: size,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      ),
    );
  }
}
