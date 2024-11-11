import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:print_script/app/app_controller.dart';
import 'package:print_script/app/utils/file_name_generator.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'components/wrapped_code_editor.dart';
import 'components/sidebar.dart';
import 'app_mobile.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey mainContainerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(builder: (context,sizingInformation) {

        if(sizingInformation.isMobile){
          return MobileApp();
        }
        return Flex(
          direction: Axis.horizontal,
          children: [
            SizedBox(
              width: 320,
              child: AppToolBar(),
            ),
            Expanded(
              flex: 6,
              child: DropTarget(
                onDragDone: (details) async {
                  //TODO: filter media files
                  if (details.files.isNotEmpty) {
                    final code = await details.files.first.readAsString();
                    Controller.codeController.setCode(code);
                  }
                },
                child: Container(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(text: TextSpan(children: [
                              TextSpan(text: "Start typing or ",),
                              TextSpan(text: "Pick/drop a file onto editor",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = Controller().importFile,
                              ),
                            ]))
                          ],
                        ),
                      ),
                      Expanded(
                          child: Container(
                        child: Center(
                          child: SingleChildScrollView(
                              child: CodeEditor(
                            key: mainContainerKey,
                          )),
                        ),
                      )),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton.icon(
                              label: const Text(
                                "Made by ildeberto",
                              ),
                              icon: const Icon(FontAwesome.fire_solid),
                              onPressed: () => launchDevProfile(),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            TextButton.icon(
                                label: const Text(
                                  "Github",
                                ),
                                icon: const Icon(FontAwesome.github_alt_brand),
                                onPressed: () => launchGithub()),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
