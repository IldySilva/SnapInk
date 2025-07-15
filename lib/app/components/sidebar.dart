import 'package:flutter/material.dart';
import 'package:print_script/app/app_controller.dart';
import 'package:print_script/app/components/app_description.dart';
import 'package:print_script/app/components/colors_list.dart';
import 'package:print_script/app/components/theme.dart';
import 'package:print_script/app/components/watermark_controls.dart';
import 'package:print_script/app/components/window_controls.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../consts/const_default_gradients.dart';
import 'custom_shade_slider.dart';
import 'export_and_reset_button.dart';
import 'gradiant_background.dart';
import 'letter_font.dart';
import 'lines_of_number.dart';
import 'programming_languanges.dart';

class AppToolBar extends StatefulWidget {
  AppToolBar({super.key});

  @override
  State<AppToolBar> createState() => _AppToolBarState();
}

class _AppToolBarState extends State<AppToolBar> {
  final Controller _controller = Controller();

  late ShadSliderController _shadSliderPaddingController;
  late ShadSliderController _shadSliderOpacityController;
  late ShadSliderController _shadSliderRoundnessController;

  @override
  void initState() {
    super.initState();
    _shadSliderPaddingController = ShadSliderController(initialValue: Controller.padding.value);

    Controller.padding.addListener(() {
      _shadSliderPaddingController.value = Controller.padding.value;
    });

    _shadSliderOpacityController = ShadSliderController(initialValue: Controller.opactity.value);

    Controller.opactity.addListener(() {
      _shadSliderOpacityController.value = Controller.opactity.value;
    });

    _shadSliderRoundnessController = ShadSliderController(initialValue: Controller.borderRadius.value);

    Controller.borderRadius.addListener(() {
      _shadSliderRoundnessController.value = Controller.borderRadius.value;
    });
  }

  @override
  void dispose() {
    _shadSliderPaddingController.dispose();
    _shadSliderRoundnessController.dispose();
    _shadSliderOpacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppDescription(),
              GradiantBackground(
                onChanged: (GradientPalette? newValue) => _controller.setColor(newValue!),
              ),
              const SizedBox(height: 6),
              ColorsList(controller: _controller),
              const SizedBox(height: 8),
              CustomTheme(),
              const SizedBox(height: 8),
              ProgrammingLanguages(),
              const SizedBox(height: 8),
              LetterFont(),
              LineOfNumbers(onChanged: (v) => _controller.setShowLines(v)),
              WindowControls(onChanged: (v) => _controller.setShowWindowHeader = v),
              WatermarkControls(),
              const SizedBox(height: 8),
              CustomShadSlider(
                min: 0,
                max: 100,
                title: "Padding",
                shadSliderController: _shadSliderPaddingController,
                onChanged: (value) => _controller.setPadding(value),
              ),
              CustomShadSlider(
                min: 0.6,
                max: 1,
                title: "Opacity",
                shadSliderController: _shadSliderOpacityController,
                onChanged: (value) => _controller.setOpactivity(value),
              ),
              CustomShadSlider(
                min: 0,
                max: 60,
                title: "Roundness",
                shadSliderController: _shadSliderRoundnessController,
                onChanged: (value) => _controller.setBorderRadius(value),
              ),
              const Divider(),
              ExportAndResetButton(),
            ],
          ),
        ),
      ),
    );
  }
}
