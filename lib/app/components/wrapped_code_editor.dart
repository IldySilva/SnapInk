import 'package:flutter/material.dart';
import 'package:print_script/app/consts/const_default_gradients.dart';
import 'package:print_script/app/app_controller.dart';
import 'package:print_script/app/components/image_wrapper.dart';
import 'package:print_script/app/enums/fonts.dart';
import 'package:print_script/app/enums/editor_themes.dart';
import 'code_editor/code_editor.dart';
import 'export_and_reset_button.dart';

class CodeEditor extends StatefulWidget {
  CodeEditor({super.key});

  @override
  State<CodeEditor> createState() => _CodeEditorState();
}

class _CodeEditorState extends State<CodeEditor> {
  ValueNotifier<double?> containerWidth = ValueNotifier(null);

  double? containerHeight;
  ValueNotifier<double> dragAreaSize = ValueNotifier(100);
  ValueNotifier<bool> resizing = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (context, value, _) {
        return SizedBox(
          width: containerWidth.value,
          child: WidgetsToImageWrapper(
            controller: widgetsToImageController,
            child: ListenableBuilder(
              builder: (context, value) {
                return AnimatedContainer(
                  padding: EdgeInsets.all(Controller.padding.value),
                  decoration: BoxDecoration(gradient: LinearGradient(colors: Controller.backgroundColor.value.gradient)),
                  duration: const Duration(milliseconds: 300),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(Controller.borderRadius.value),
                        child: ValueListenableBuilder(
                          builder: (context, theme, _) {
                            return CodeTheme(
                                data: CodeThemeData(styles: theme.themeValue),
                                child: AnimatedOpacity(
                                  opacity: Controller.opactity.value,
                                  duration: const Duration(milliseconds: 300),
                                  child: CodeField(
                                    textStyle: Controller.selectedFont.value.getTextStyle(),
                                    onChanged: (x) => Controller.code = x,
                                    wrap: true,
                                    gutterStyle: GutterStyle(showFoldingHandles: false, showErrors: false, showLineNumbers: Controller.showLines.value),
                                    controller: Controller.codeController,
                                  ),
                                ));
                          },
                          valueListenable: Controller.selectedTheme,
                        ),
                      ),
                      // Watermark - positioned outside the rounded corners
                      ValueListenableBuilder<bool>(
                        valueListenable: Controller.showWatermark,
                        builder: (context, showWatermark, child) {
                          if (!showWatermark) return const SizedBox.shrink();
                          
                          return Positioned(
                            bottom: -2,
                            right: 8,
                            child: ValueListenableBuilder<String>(
                              valueListenable: Controller.watermarkText,
                              builder: (context, watermarkText, child) {
                                return ValueListenableBuilder<double>(
                                  valueListenable: Controller.watermarkOpacity,
                                  builder: (context, watermarkOpacity, child) {
                                    return AnimatedOpacity(
                                      opacity: watermarkOpacity,
                                      duration: const Duration(milliseconds: 300),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          watermarkText,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white.withOpacity(0.8),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                      Positioned(
                        right: 1,
                        top: 0.7,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.resizeLeft,
                          onHover: (v) {
                            resizing.value = true;
                          },
                          onExit: (v) {
                            resizing.value = false;
                          },
                          child: GestureDetector(
                            onPanUpdate: (details) {
                              if (containerWidth.value == null) {
                                final box = (widget.key as GlobalKey).currentContext!.findRenderObject() as RenderBox;
                                containerWidth.value = box.size.width;
                              }

                              if (containerWidth.value != null) {
                                containerWidth.value = containerWidth.value! + details.delta.dx;
                                dragAreaSize.value += details.delta.dy;
                              }
                            },
                            child: ValueListenableBuilder(
                              builder: (context, onHover, _) {
                                return AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    decoration: BoxDecoration(
                                      color: onHover ? Theme.of(context).colorScheme.onPrimaryContainer : Colors.transparent,
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                    ),
                                    width: 10,
                                    height: 400);
                              },
                              valueListenable: resizing,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              listenable: Controller(),
            ),
          ),
        );
      },
      valueListenable: containerWidth,
    );
  }
}
