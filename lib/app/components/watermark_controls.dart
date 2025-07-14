import 'package:flutter/material.dart';
import 'package:print_script/app/app_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class WatermarkControls extends StatefulWidget {
  const WatermarkControls({super.key});

  @override
  State<WatermarkControls> createState() => _WatermarkControlsState();
}

class _WatermarkControlsState extends State<WatermarkControls> {
  final Controller _controller = Controller();
  late TextEditingController _textController;
  late ShadSliderController _opacitySliderController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: Controller.watermarkText.value);
    _opacitySliderController = ShadSliderController(initialValue: Controller.watermarkOpacity.value);

    Controller.watermarkText.addListener(() {
      if (_textController.text != Controller.watermarkText.value) {
        _textController.text = Controller.watermarkText.value;
      }
    });

    Controller.watermarkOpacity.addListener(() {
      _opacitySliderController.value = Controller.watermarkOpacity.value;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _opacitySliderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: Controller.showWatermark,
          builder: (context, showWatermark, child) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Watermark",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: ShadSwitch(
                      value: showWatermark,
                      onChanged: (value) => _controller.setShowWatermark(value),
                    ),
                  )
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder<bool>(
          valueListenable: Controller.showWatermark,
          builder: (context, showWatermark, child) {
            if (!showWatermark) return const SizedBox.shrink();
            
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Watermark Text',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                ShadInput(
                  controller: _textController,
                  placeholder: const Text('Enter watermark text'),
                  onChanged: (value) => _controller.setWatermarkText(value),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Watermark Opacity',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                ShadSlider(
                  controller: _opacitySliderController,
                  min: 0.1,
                  max: 1.0,
                  onChanged: (value) => _controller.setWatermarkOpacity(value),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
