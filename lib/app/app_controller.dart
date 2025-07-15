import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:print_script/app/consts/const_default_gradients.dart';
import 'package:print_script/app/enums/fonts.dart';
import 'package:print_script/app/enums/language/enum_languages.dart';
import 'package:print_script/app/enums/editor_themes.dart';

import 'components/code_editor/code_field/code_controller.dart';
import 'consts/const_default_code.dart';

class Controller extends ChangeNotifier {
  static final Controller _instance = Controller._internal();

  Controller._internal();

  factory Controller() {
    return _instance;
  }

  static String code = defaultCode;
  static var selectedFont = ValueNotifier(EditorFont.sourceCodePro);
  static var selectedLanguage = ValueNotifier(LanguageTypes.javascript);
  static var selectedTheme = ValueNotifier(ThemeType.irBlack);

  static ValueNotifier<GradientPalette> backgroundColor = ValueNotifier<GradientPalette>(GradientPalette.PurpleHaze);
  static ValueNotifier<double> padding = ValueNotifier(60);
  static ValueNotifier<double> opactity = ValueNotifier(0.8);
  static ValueNotifier<bool> showLines = ValueNotifier(true);
  static ValueNotifier<double> borderRadius = ValueNotifier(20);
  static ValueNotifier<bool> exporting = ValueNotifier(false);
  static ValueNotifier<bool> showWindowheader = ValueNotifier(true);
  static ValueNotifier<bool> showWatermark = ValueNotifier(false);
  static ValueNotifier<String> watermarkText = ValueNotifier("Made with SnapInk");
  static ValueNotifier<double> watermarkOpacity = ValueNotifier(0.5);

  static var codeController = CodeController(text: Controller.code, language: Controller.selectedLanguage.value.languageValue);

  set setShowWindowHeader(bool value) {
    showWindowheader.value = value;
    notifyListeners();
  }

  set setFont(EditorFont font) {
    selectedFont.value = font;
    notifyListeners();
  }

  setLoading(bool v) {
    exporting.value = v;
  }

  setColor(GradientPalette newColor) {
    backgroundColor.value = newColor;
    notifyListeners();
  }

  setTheme(ThemeType newTeme) {
    selectedTheme.value = newTeme;
    notifyListeners();
  }

  setOpactivity(double newOpactity) {
    opactity.value = newOpactity;
    notifyListeners();
  }

  setPadding(double newPaddin) {
    padding.value = newPaddin;
    notifyListeners();
  }

  setShowLines(bool v) {
    showLines.value = v;
    notifyListeners();
  }

  void setBorderRadius(double v) {
    borderRadius.value = v;
    notifyListeners();
  }

  void setShowWatermark(bool value) {
    showWatermark.value = value;
    notifyListeners();
  }

  void setWatermarkText(String text) {
    watermarkText.value = text;
    notifyListeners();
  }

  void setWatermarkOpacity(double opacity) {
    watermarkOpacity.value = opacity;
    notifyListeners();
  }

  void reset() {
    code = defaultCode;
    selectedFont.value = EditorFont.sourceCodePro;
    selectedLanguage.value = LanguageTypes.javascript;
    selectedTheme.value = ThemeType.irBlack;
    backgroundColor.value = GradientPalette.PurpleHaze;
    padding.value = 60;
    opactity.value = 0.8;
    showLines.value = true;
    borderRadius.value = 20;
    exporting.value = false;
    showWindowheader.value = true;
    showWatermark.value = false;
    watermarkText.value = "Made with SnapInk";
    watermarkOpacity.value = 0.5;
    codeController.text = code;

    notifyListeners();
  }
}
