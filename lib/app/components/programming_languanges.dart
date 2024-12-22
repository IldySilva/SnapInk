import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../app_controller.dart';
import '../enums/language/enum_languages.dart';

class ProgrammingLanguages extends StatelessWidget {
  const ProgrammingLanguages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
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
    );
  }
}
