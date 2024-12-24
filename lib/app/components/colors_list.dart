import 'package:flutter/material.dart';

import '../app_controller.dart';
import '../consts/const_default_gradients.dart';

class ColorsList extends StatelessWidget {
  const ColorsList({
    super.key,
    required Controller controller,
  }) : _controller = controller;

  final Controller _controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (GradientPalette gradient in GradientPalette.values.getRange(0, 8))
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8, right: 8),
            child: InkWell(
              onTap: () {
                _controller.setColor(gradient);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Container(decoration: BoxDecoration(gradient: LinearGradient(colors: gradient.gradient)), height: 18, width: 18),
              ),
            ),
          ),
      ],
    );
  }
}
