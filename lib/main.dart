import 'package:flutter/material.dart';

//REMOVE WHEN TL ALGO IS PRESENT
import 'dart:math';

import 'package:flutter/services.dart'; //Placeholder for Translation alogirithm

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
  final Random rand = Random();

  //Hint texts
  String topPlaceholder = "Translated text will appear here";
  String bottomPlaceholder = "Type text to be translated here.";

  //Functional Text
  String translatedText = "";
  String osakaText = "";

  //Mic variables

  bool micState = false;
  MaterialColor micColor = Colors.blueGrey;

  //PLACEHOLDER FOR TL ALGO
  //REMOVE IN FINAL CODE --+--
  List<String> placeholderTLStrings = [
    'But it refused',
    'PLACEHOLDER',
    'What are you saying?',
    'Idk what ur saying but this method works',
  ];

  void _PLACEHOLDER_METHOD() {} //REMOVE IN FINAL CODE --+--
  void _updateText() {
    setState(() {
      //To Do when backend is finished.
      translatedText = osakaText;
    });
  }

  //Update mic icon method when pressed
  void _updateMicState() {
    setState(() {
      //change mic icon and background colorbased on micState
      micState = !micState;
      micColor = micState == false ? Colors.blueGrey : Colors.red;
    });
  }

  //WIP: Call translation algo
  void _translate() {
    //call the backend algo for translation
    setState(() {
      translatedText = inputController.text.isEmpty
          ? ""
          : (inputController.text +
                placeholderTLStrings[rand.nextInt(
                  (placeholderTLStrings.length - 1),
                )]);
      //WIP: Replace with proper translation method call
    });
  }

  // ----------- UTILITY METHODS ------------
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  // ----------- BUTTON FUNCTIONALITIES ------------
  //Copy method
  void _copyTranslatedText() {
    if (translatedText.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: translatedText));
      _showSnackBar('Text copied to clipboard!');
    }
    _showSnackBar('There is no text to copy');
  }

  //paste Method
  void _pasteText() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data != null && data.text != null && data.text!.isNotEmpty) {
      setState(() {
        inputController.text = data.text!;
      });
      _showSnackBar('Text pasted from clipboard!');
    } else {
      _showSnackBar('Clipboard is empty.');
    }
  }

  //cut method
  void _cutTranslatedText() {
    if (translatedText.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: translatedText));
      _showSnackBar('Text copied to clipboard!');
    }
    _showSnackBar('There is no text to cut');
    setState(() {
      translatedText = "";
    });
  }

  //Clear both translated text and inputController
  void _clearAll() {
    setState(() {
      inputController.clear();
      translatedText = "";
    });
  }

  // ----------- FRONTENT CODE ------------
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double buttonSize = size.width * 0.11;
    final double textSize = size.width * 0.04;

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
                    controller: TextEditingController(
                      text: translatedText.isEmpty
                          ? "Translated text will appear here"
                          : translatedText,
                    ),
                    readOnly: true,
                    maxLines: null,
                    expands: true,
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
                        _pasteText();
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
                        _copyTranslatedText();
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
                        _cutTranslatedText();
                      },
                    ),
                    SizedBox(width: size.width * 0.03),
                    _rippleButton(
                      //Clear All button
                      Icons.clear_all,
                      buttonSize,
                      Colors.white,
                      Colors.black,
                      onTap: () {
                        _clearAll();
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
                    //Import audio file button
                    Icons.add,
                    buttonSize,
                    Colors.white,
                    Colors.black,
                  ),
                  SizedBox(width: size.width * 0.05),
                  _rippleButton(
                    //Mic button
                    micState == false ? Icons.mic_off : Icons.mic,
                    buttonSize * 1.5,
                    micColor,
                    Colors.white,
                    onTap: () {
                      _updateMicState();
                    },
                  ),
                  SizedBox(width: size.width * 0.05),
                  _rippleButton(
                    //Confirm button
                    Icons.check,
                    buttonSize,
                    Colors.white,
                    Colors.black,
                    onTap: () {
                      _translate();
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

// ----------- WIDGETS ------------
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
