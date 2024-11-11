import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:print_script/app/app_controller.dart';
import 'package:print_script/app/consts/const_extensions_file.dart';
import 'package:print_script/app/utils/file_name_generator.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
      body: ResponsiveBuilder(builder: (context, sizingInformation) {
        if (sizingInformation.isMobile) {
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
                        height: 90,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Start typing or "),
                            ShadButton.link(
                              child: Text(
                                "Pick/drop a file onto editor",
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                              padding: EdgeInsets.zero,
                              onPressed: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: extensionsAlloweds,
                                );
                                if (result != null) {
                                  final code =
                                      await result.xFiles.first.readAsString();
                                  Controller.codeController.setCode(code);
                                }
                              },
                            )
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
