import 'package:flutter/material.dart';
import 'package:print_script/app/app_controller.dart';
import 'package:print_script/app/components/code_editor/window_header/components/colored_circle_buttons.dart';
import 'package:print_script/app/enums/editor_themes.dart';

class WindowHeader extends StatelessWidget {
  const WindowHeader({super.key});

  final windowSize = 50.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: windowSize,
      color: Colors.black.withOpacity(0.09),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left:20.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: ColoredCircleButtons()),
              )),
          Flexible(
              child: Align(
                  alignment: Alignment.center,
                  child: TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey,fontSize: 12),
                    decoration: InputDecoration(
                      border: InputBorder.none,hintText: "Untitled-1"),))),
          Flexible(
              child:SizedBox.expand())
        ],
      ),
    );
  }
}
