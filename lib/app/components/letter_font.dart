import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../app_controller.dart';
import '../enums/fonts.dart';

class LetterFont extends StatelessWidget {
  const LetterFont({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
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
    );
  }
}
