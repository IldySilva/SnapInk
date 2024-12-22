import 'package:flutter/material.dart';

class AppDescription extends StatelessWidget {
  const AppDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 16, left: 8),
      child: Row(
        children: [
          Image.asset(
            "assets/getink_icon.png",
            scale: 12,
          ),
          SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('SnapInk', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)), Text("Take a beautiful snap of your code")],
          ),
        ],
      ),
    );
  }
}
