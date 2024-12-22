import 'package:flutter/material.dart';
import 'package:print_script/app/app_controller.dart';
import 'package:print_script/app/components/app_description.dart';
import 'package:print_script/app/components/window_controls.dart';
import 'package:print_script/app/enums/language/enum_languages.dart';
import 'package:print_script/app/enums/editor_themes.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../consts/const_default_gradients.dart';
import '../enums/fonts.dart';
import 'dart:ui' as ui;

import 'custom_shade_slider.dart';
import 'export_and_reset_button.dart';
import 'lines_of_number.dart';

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
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppDescription(),
              Flex(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.horizontal,
                children: [
                  Text("Background"),
                  ValueListenableBuilder(
                    builder: (context, value, _) {
                      return Flexible(
                        child: ShadSelect<GradientPalette>(
                          initialValue: value,
                          onChanged: (GradientPalette? newValue) {
                            _controller.setColor(newValue!);
                          },
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
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
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
              ),
              const SizedBox(
                height: 8,
              ),
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Theme"),
                  ValueListenableBuilder(
                    builder: (context, value, _) {
                      return Flexible(
                          child: ShadSelect<ThemeType>(
                        initialValue: value,
                        onChanged: (ThemeType? newValue) {
                          Controller().setTheme(newValue!);
                        },
                        selectedOptionBuilder: (context, value) {
                          return Text(
                            value.cleanName,
                            style: const TextStyle(color: Colors.white),
                          );
                        },
                        options: ThemeType.values.map((e) => ShadOption(
                              value: e,
                              child: Text(
                                e.cleanName,
                                style: const TextStyle(color: Colors.white),
                              ),
                            )),
                      ));
                    },
                    valueListenable: Controller.selectedTheme,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Language"),
                  ValueListenableBuilder(
                    builder: (context, value, _) {
                      return Flexible(
                          child: ShadSelect<LanguageTypes>(
                        initialValue: value,
                        onChanged: (LanguageTypes? newValue) {
                          Controller.selectedLanguage.value = newValue!;
                          Controller.selectedTheme.notifyListeners();
                        },
                        selectedOptionBuilder: (context, value) {
                          return Text(
                            value.cleanName,
                            style: const TextStyle(color: Colors.white),
                          );
                        },
                        options: LanguageTypes.values.map((e) => ShadOption(
                              value: e,
                              child: Text(
                                e.cleanName,
                                style: const TextStyle(color: Colors.white),
                              ),
                            )),
                      ));
                    },
                    valueListenable: Controller.selectedLanguage,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Font"),
                  ValueListenableBuilder(
                    builder: (context, value, _) {
                      return Flexible(
                          child: ShadSelect<EditorFont>(
                        initialValue: value,
                        onChanged: (EditorFont? newValue) {
                          Controller().setFont = newValue!;
                        },
                        selectedOptionBuilder: (context, value) {
                          return Text(
                            value.cleanName,
                            style: const TextStyle(color: Colors.white),
                          );
                        },
                        options: EditorFont.values.map((e) => ShadOption(
                              value: e,
                              child: Text(
                                e.cleanName,
                                style: const TextStyle(color: Colors.white),
                              ),
                            )),
                      ));
                    },
                    valueListenable: Controller.selectedFont,
                  ),
                ],
              ),
              LineOfNumbers(onChanged: (v) => _controller.setShowLines(v)),
              WindowControls(onChanged: (v) => _controller.setShowWindowHeader = v),
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
