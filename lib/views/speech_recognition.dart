import 'package:curus_health_app/controllers/speech_recognition_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SpeechRecognition extends GetWidget<SpeechRecognitionController> {
  SpeechRecognition({Key? key}) : super(key: key);
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 2.0,
        backgroundColor: Colors.white,
        toolbarHeight: 60.0,
        title: Text(
          "Say something",
          textAlign: TextAlign.left,
          style: GoogleFonts.gloriaHallelujah(
            fontSize: 22,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              color: Colors.white,
              child: Obx(() {
                print('obx change: ${controller.isListening}');
                return Text(
                  // If listening is active show the recognized words
                  /**/
                  controller.speechEnabled.value
                      ? controller.isListening
                              .value // speechToText.value.isListening
                          ? 'Listening...'
                          : 'Tap to start listening...'
                      // If listening isn't active but could be tell the user
                      // how to start it, otherwise indicate that speech
                      // recognition is not yet ready or not supported on
                      // the target device
                      : 'Speech service unavailable!',
                  style: GoogleFonts.gloriaHallelujah(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                );
              }),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(5.0),
                    //bottom: Radius.zero,
                  ),
                ),
                child: Scrollbar(
                  child: TextField(
                    textAlignVertical: TextAlignVertical.top,
                    controller: controller.textCtrl,
                    maxLines: null,
                    minLines: null,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    expands: true,
                    decoration: const InputDecoration(
                      hintText: 'Say or type something',
                      contentPadding:
                          EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.25),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.25),
                      ),
                    ),
                    style: GoogleFonts.gloriaHallelujah(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            // If not yet listening for speech start, otherwise stop
            () async {
          print(
              'controller.speechToText.value.isNotListening: ${controller.speechToText.isNotListening}');
          if (controller.speechToText.isNotListening) {
            await controller.startListening();
            // controller.isListening(true);
            print('sdgndd');
          } else {
            await controller.stopListening();
            // controller.isListening(false);
            print('lasdfc');
          }
        },
        tooltip: 'Listen',
        child: Icon(
            controller.speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
    );
  }
}
/*
                        child: Text(
                          // If listening is active show the recognized words
                          controller.speechToText.value.isListening
                              ? controller.lastWords.value
                          // If listening isn't active but could be tell the user
                          // how to start it, otherwise indicate that speech
                          // recognition is not yet ready or not supported on
                          // the target device
                              : controller.speechEnabled
                              ? 'Tap the microphone to start listening...'
                              : 'Speech not available',
                        )
 */
