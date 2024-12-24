import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../app_controller.dart';
import '../widget_to_image_controller.dart';

class ExportAndResetButton extends StatelessWidget {
  const ExportAndResetButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ShadButton(
          child: ValueListenableBuilder(
            builder: (context, value, _) {
              if (value) return Center(child: LinearProgressIndicator());
              return Text(
                "Export image",
              );
            },
            valueListenable: Controller.exporting,
          ),
          onPressed: () async {
            Controller().setLoading(true);
            await widgetsToImageController.capture();
            Controller().setLoading(false);
          },
        ),
        ShadButton.secondary(
          onPressed: () {
            Controller().reset();
          },
          child: Text(
            "Reset",
          ),
        ),
      ],
    );
  }
}

WidgetsToImageController widgetsToImageController = WidgetsToImageController();
