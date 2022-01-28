import 'dart:convert';
import 'package:curus_health_app/models/patient_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final list = List<PatientData>.of([]).obs;

  @override
  void onInit() {
    fetchPatientList();
    super.onInit();
  }

  Future<List<PatientData>> fetchPatientList() async {
    final String response =
        await rootBundle.loadString('assets/mock_data.json');
    final List data = await json.decode(response);
    // list(List.of([]));
    // print('type: ${list.runtimeType}');
    for (var element in data) {
      list.add(
        PatientData(
          firstName: element['first_name'],
          lastName: element['last_name'],
          gender: element['gender'],
          description: element['description'],
          imageURL: element['image'],
        ),
      );
      if (kDebugMode) {
        print(element);
      }
    }
    return list;
  }
}
