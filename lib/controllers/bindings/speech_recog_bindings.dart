import 'package:get/get.dart';
import '../speech_recognition_ctrl.dart';

class SpeechRecognitionBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpeechRecognitionController>(
      () => SpeechRecognitionController(),
    );
  }
}
