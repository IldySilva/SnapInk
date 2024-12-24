import 'package:flutter/material.dart';
import 'package:print_script/app/app_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class WindowControls extends StatelessWidget {
  const WindowControls({
    super.key,
    required this.onChanged,
  });

  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (context, value, _) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Window controls",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Transform.scale(
                scale: 0.8,
                child: ShadSwitch(
                  value: value,
                  onChanged: onChanged,
                ),
              )
            ],
          ),
        );
      },
      valueListenable: Controller.showWindowheader,
    );
  }
}
