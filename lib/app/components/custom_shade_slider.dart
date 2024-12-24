import 'package:flutter/material.dart';
import 'package:print_script/app/widget_to_image_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CustomShadSlider extends StatelessWidget {
  const CustomShadSlider({
    super.key,
    required this.shadSliderController,
    required this.title,
    required this.onChanged,
    this.max,
    this.min,
  });

  final ShadSliderController shadSliderController;
  final double? min;
  final double? max;
  final void Function(double)? onChanged;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          ShadSlider(
            min: min,
            max: max,
            controller: shadSliderController,
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}
