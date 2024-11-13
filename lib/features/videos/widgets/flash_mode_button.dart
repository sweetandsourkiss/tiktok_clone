import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class FlashModeButton extends StatelessWidget {
  final FlashMode mode;
  final bool isSelected;
  final IconData flashIcon;
  final Function setFlashMode;

  const FlashModeButton({
    super.key,
    required this.mode,
    required this.isSelected,
    required this.setFlashMode,
    required this.flashIcon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => setFlashMode(mode),
      icon: Icon(flashIcon),
      color: isSelected ? Colors.amber.shade200 : Colors.white,
    );
  }
}
