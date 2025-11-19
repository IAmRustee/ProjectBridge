import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LayoutUI(),
    );
  }
}

class LayoutUI extends StatelessWidget {
  const LayoutUI({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double buttonSize = size.width * 0.11;
    final double textSize = size.width * 0.05;

    return Scaffold(
      backgroundColor: const Color(0xFF2D1242),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ----------- TOP BOX -----------
                Container(
                  height: size.height * 0.35,
                  margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.08,
                    vertical: size.height * 0.015,
                  ),
                  padding: EdgeInsets.all(size.width * 0.10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextField(
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(
                      hintText: "English translation here...",
                      border: InputBorder.none,
                    ),
                    style: TextStyle(color: Colors.black, fontSize: textSize),
                  ),
                ),

                SizedBox(height: size.height * 0.02),

                // ----------- MIDDLE BUTTONS -----------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _bubble(
                      Icons.description,
                      buttonSize,
                      Colors.white,
                      Colors.black,
                    ),
                    SizedBox(width: size.width * 0.03),
                    _bubble(Icons.copy, buttonSize, Colors.white, Colors.black),
                    SizedBox(width: size.width * 0.03),
                    _bubble(Icons.cut, buttonSize, Colors.white, Colors.black),
                  ],
                ),

                SizedBox(height: size.height * 0.02),

                // ----------- BOTTOM BOX -----------
                Container(
                  height: size.height * 0.30,
                  margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.08,
                    vertical: size.height * 0.01,
                  ),
                  padding: EdgeInsets.all(size.width * 0.10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    "Osaka-ben words here...",
                    style: TextStyle(color: Colors.grey, fontSize: textSize),
                  ),
                ),
              ],
            ),

            // ----------- BOTTOM BUTTONS -----------
            Positioned(
              bottom: size.height * 0.01,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _bubble(Icons.close, buttonSize, Colors.white, Colors.black),
                  SizedBox(width: size.width * 0.05),
                  _bubble(
                    Icons.mic,
                    buttonSize * 1.5,
                    Colors.red,
                    Colors.white,
                  ),
                  SizedBox(width: size.width * 0.05),
                  _bubble(Icons.add, buttonSize, Colors.white, Colors.black),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _bubble(IconData icon, double size, Color background, Color iconColor) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(color: background, shape: BoxShape.circle),
    child: Icon(icon, size: size * 0.55, color: iconColor),
  );
}
