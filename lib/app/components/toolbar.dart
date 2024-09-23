import 'package:dotted_border/dotted_border.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:print_script/app/controller.dart';
import 'package:print_script/app/widget_to_image_controller.dart';
import 'package:flutter/cupertino.dart' as cuppertino;
import '../const_default_gradients.dart';
import '../file_name_generator.dart';

class CodeToolBar extends StatelessWidget {
  CodeToolBar({super.key});
Controller controller=Controller();
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: const TextSpan(style: TextStyle(fontSize: 20), children: [
                  TextSpan(text: 'Code'),
                  TextSpan(
                      text: 'Ink', style: TextStyle(fontWeight: FontWeight.bold))
                ]),
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Background",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.start,
              children: [
                for (List<Color> gradient in gradients)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                    child: InkWell(
                      onTap: () {
                       controller.setColor(gradient);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: gradient)),
                            height: 35,
                            width: 35),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(4),
                    child: Container(
                      color: Colors.transparent,
                      height: 30,
                      width: 30,
                      child: const Icon(Icons.add),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Padding",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ValueListenableBuilder(
                    builder: (context,value,_) {
                      return Slider.adaptive(
                          min: 0,
                          max: 100,
                          value: value,
                          onChanged: (v) {
                            controller.setPadding(v);
                          });
                    }, valueListenable: Controller.padding,
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Theme",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Language",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  var bytes = await widgetsToImageController.capture();
                  await FileSaver.instance
                      .saveFile(name: generateName, bytes: bytes);
                },
                child: const Text("Export")),
          ],
        ),
      ),
    );
  }
}

WidgetsToImageController widgetsToImageController = WidgetsToImageController();
