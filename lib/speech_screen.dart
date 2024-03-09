import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  String recongnizedText = "";
  bool isListening = false;

  @override
  void initState() {
    super.initState();
    _initSpeechState();

  }


  void _initSpeechState() async {
    await _speechToText.initialize();
    setState(() {
      isListening = false;
      print(isListening);
    });
  }

  void _startListening() {
    if (_speechToText.isAvailable) {
      _speechToText.listen(
        onResult: (result) {
          setState(() {
            recongnizedText = result.recognizedWords;
            if (result.finalResult) {

              isListening = false;
            }
          });
        },
      );

      setState(() {
        isListening = true;
      });
    } else {
      print("Speech recognition is not available.");
    }
  }



  void _copyText() {
    Clipboard.setData(ClipboardData(text: recongnizedText));

    _showSnackBar("Text Copied");
  }

  void clearText() {
    setState(() {
      recongnizedText = "";
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 1),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {
                _startListening();
              },
              icon: Icon(
                isListening ? Icons.mic : Icons.mic_none,
              ),
              iconSize: 100,
              color: isListening ? Colors.red : Colors.grey,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.sizeOf(context).height / 4,
              width: MediaQuery.sizeOf(context).width,
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                recongnizedText.isNotEmpty ? recongnizedText : "Result here...",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: recongnizedText.isNotEmpty ? _copyText : null,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Copy",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: recongnizedText.isNotEmpty ? clearText : null,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Clear",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
