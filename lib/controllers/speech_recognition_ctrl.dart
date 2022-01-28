import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class SpeechRecognitionController extends GetxController {
  final speechToText = SpeechToText();
  final isListening = false.obs;
  final speechEnabled = false.obs;
  final lastWords = ''.obs;
  final textCtrl = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    speechEnabled(await speechToText.initialize());
    /**/isListening.listen((p0) {
      isListening(speechToText.isListening);
      print("isListening.listen: ${isListening.value}");
    });
  }

  /// Each time to start a speech recognition session
  Future<void> startListening() async {
    await speechToText
        .listen(
      onResult: _onSpeechResult,
      listenMode: ListenMode.search,
    )
        .whenComplete(() {
      lastWords(textCtrl.text);
      isListening(speechToText.isListening);
    });
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  Future<void> stopListening() async {
    await speechToText.stop();
    print('stopListening()');
    isListening(false);
    // setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    textCtrl.text = lastWords.value + result.recognizedWords;
    textCtrl.selection = TextSelection.fromPosition(
      TextPosition(
        offset: textCtrl.text.length,
      ),
    );
    if (speechToText.isNotListening) {
      isListening(false);
    }
  }
}
