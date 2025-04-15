import 'package:flutter/material.dart';
import 'package:print_script/app/app_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../consts/const_default_gradients.dart';

class GradiantBackground extends StatelessWidget {
  const GradiantBackground({
    super.key,
    required this.onChanged,
  });

  final  ValueChanged<GradientPalette?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Flex(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      direction: Axis.horizontal,
      children: [
        Text("Background"),
        ValueListenableBuilder(
          builder: (context, value, _) {
            return Flexible(
              child: ShadSelect<GradientPalette>(
                initialValue: value,
                onChanged: onChanged,
                selectedOptionBuilder: (context, value) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        value.cleanName,
                        style: const TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Container(decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: value.gradient)), height: 16, width: 50),
                    ],
                  );
                },
                options: GradientPalette.values.map((e) => ShadOption(
                      value: e,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            e.cleanName,
                            style: const TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Container(decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: e.gradient)), height: 16, width: 16),
                        ],
                      ),
                    )),
              ),
            );
          },
          valueListenable: Controller.backgroundColor,
        ),
      ],
    );
  }
}
