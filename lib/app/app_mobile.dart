import 'package:flutter/material.dart';

class MobileApp extends StatelessWidget {
  const MobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/getink_icon.png",scale: 12,),
          Text('SnapInk',
              style: TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 20)),
          SizedBox(height: 12),
          Text(
            "😇\nWe're Working on it,\nplease use a tablet or  desktop",
            style: TextStyle(fontSize: 18),textAlign: TextAlign.center,
          ),
        ],
      ),
    ));
  }
}
