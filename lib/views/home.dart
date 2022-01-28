import 'package:curus_health_app/controllers/home_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Home extends GetWidget<HomeController> {
  Home({Key? key}) : super(key: key);

  final RxList<Container> listTiles = RxList();

  Container listTile(int index) {
    final list = controller.list;
    String name = list[index].firstName + " " + list[index].lastName;
    Container imageArea = Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            child: CircleAvatar(
              child: Image(
                image: NetworkImage(list[index].imageURL),
              ),
              radius: 40.0,
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
    var namePrefix = (list[index].gender == 'Male' ? 'Mr' : 'Ms') + '. ';
    Container nameArea = Container(
      padding: const EdgeInsets.only(
        left: 10.0,
        top: 10.0,
      ),
      width: double.maxFinite,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Text(
        namePrefix + name,
        style: GoogleFonts.gloriaHallelujah(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    Container contentArea = Container(
      padding: const EdgeInsets.only(
        left: 10.0,
        top: 10.0,
        bottom: 15.0,
      ),
      width: double.maxFinite,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Text(
        list[index].description,
        style: GoogleFonts.gloriaHallelujah(
          fontSize: 15,
          color: Colors.black,
        ),
      ),
    );
    Container result = Container(
      margin: const EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 0.0),
      padding: const EdgeInsets.all(2.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            blurRadius: 5.0,
            spreadRadius: .5,
            offset: Offset(1.0, 3.0),
          ),
        ],
      ),
      child: Column(
        children: [
          imageArea,
          GestureDetector(
            onTap: () async {},
            child: Column(
              children: [
                nameArea,
                contentArea,
              ],
            ),
          ),
        ],
      ),
    );
    return result;
  }

  void updateList() async {
    listTiles.value = List<Container>.generate(
      controller.list.length,
      (index) => listTile(
        index,
      ),
    )..add(
        Container(
          height: 12.0,
        ),
      );
  }

  Future<void> onRefresh() async {
    await controller.fetchPatientList();
    updateList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          elevation: 2.0,
          backgroundColor: Colors.white,
          toolbarHeight: 60.0,
          title: Text(
            "Home",
            textAlign: TextAlign.left,
            style: GoogleFonts.gloriaHallelujah(
              fontSize: 22,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                // updateList();
                onRefresh();
              },
              icon: const Icon(
                MdiIcons.refresh,
              ),
            ),
          ],
        ),
      ),
      body: Scrollbar(
        child: Obx(
          () {
            updateList();
            return ListView(
              children: listTiles,
            );
          },
        ),
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FittedBox(
          child: FloatingActionButton(
            child: const Icon(
              MdiIcons.microphone
            ),
            onPressed: () async {
              Get.toNamed('/stt');
              print('hello');
              // Get.to();
            },
          ),
        ),
      ),
    );
  }
}

/*
          Flexible(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: Text(
                    "First name: ${list[index].firstName}",
                    style: GoogleFonts.gloriaHallelujah(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: Text(
                    "First name: ${list[index].lastName}",
                    style: GoogleFonts.gloriaHallelujah(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
*/
