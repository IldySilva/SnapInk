import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../app_controller.dart';
import '../enums/editor_themes.dart';

class CustomTheme extends StatelessWidget {
  const CustomTheme({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
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
    );
  }
}
