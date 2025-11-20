import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LayoutUI(),
    );
  }
}

class LayoutUI extends StatefulWidget {
  const LayoutUI({super.key});

  @override
  State<LayoutUI> createState() => _LayoutUIState();
}

class _LayoutUIState extends State<LayoutUI> {
  final TextEditingController inputController = TextEditingController();

  //Placeholder Texts
  String topPlaceholder = "Translated text will appear here";
  String bottomPlaceholder = "Type text to be translated here.";

  //Functional Text
  String translatedText = "";
  String osakaText = "";

  bool micState = false;
  void _PLACEHOLDER_METHOD() {}
  void _updateText() {
    setState(() {
      //To Do when backend is finished.
      translatedText = osakaText;
    });
  }

  //Update mic icon method when pressed
  void _updateMicState() {
    setState(() {
      //change mic icon based on micState
      micState = !micState;
    });
  }

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
                // ----------- TOP BOX ------------
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
                    controller: null,
                    maxLines: null,
                    expands: true,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: topPlaceholder,
                      border: InputBorder.none,
                    ),
                    style: TextStyle(color: Colors.black, fontSize: textSize),
                  ),
                ),

                SizedBox(height: size.height * 0.02),

                // ------- MIDDLE BUTTONS ----------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _rippleButton(
                      //Paste Button
                      Icons.content_paste,
                      buttonSize,
                      Colors.white,
                      Colors.black,
                      onTap: () {
                        _PLACEHOLDER_METHOD();
                      },
                    ),
                    SizedBox(width: size.width * 0.03),
                    _rippleButton(
                      //Copy Button
                      Icons.copy,
                      buttonSize,
                      Colors.white,
                      Colors.black,
                      onTap: () {
                        _PLACEHOLDER_METHOD();
                      },
                    ),
                    SizedBox(width: size.width * 0.03),
                    _rippleButton(
                      //Cut button
                      Icons.cut,
                      buttonSize,
                      Colors.white,
                      Colors.black,
                      onTap: () {
                        _PLACEHOLDER_METHOD();
                      },
                    ),
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
                  child: TextField(
                    controller: inputController,
                    maxLines: null,
                    expands: true,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: bottomPlaceholder,
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        onPressed: inputController.clear,
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                    style: TextStyle(color: Colors.black, fontSize: textSize),
                  ),
                ),
              ],
            ),

            // ------- BOTTOM BUTTONS ----------
            Positioned(
              bottom: size.height * 0.01,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _rippleButton(
                    Icons.add,
                    buttonSize,
                    Colors.white,
                    Colors.black,
                  ),
                  SizedBox(width: size.width * 0.05), //Import audio file button
                  _rippleButton(
                    //Mic button
                    micState == false ? Icons.mic_off : Icons.mic,
                    buttonSize * 1.5,
                    Colors.red,
                    Colors.white,
                    onTap: () {
                      _updateMicState();
                    },
                  ),
                  SizedBox(width: size.width * 0.05),
                  _rippleButton(
                    //Submit button
                    Icons.check,
                    buttonSize,
                    Colors.white,
                    Colors.black,
                    onTap: () {
                      _updateText();
                    },
                  ),
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

Widget _rippleButton(
  IconData icon,
  double size,
  Color background,
  Color iconColor, {
  VoidCallback? onTap,
}) {
  return InkWell(
    borderRadius: BorderRadius.circular(size),
    onTap: onTap,
    child: Ink(
      width: size,
      height: size,
      decoration: BoxDecoration(color: background, shape: BoxShape.circle),
      child: Icon(icon, color: iconColor, size: size * 0.55),
    ),
  );
}
