import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:getx/controller/home_screen/home_screen_controller.dart';
import 'package:getx/data/data.dart';
import 'package:getx/utils/color_constrain.dart';
import 'package:getx/utils/font_constrain.dart';

class ItemView extends StatelessWidget {
  final int index;
  final void Function(GlobalKey) onClick;
  final GlobalKey widgetKey = GlobalKey();

  ItemView({super.key, required this.index, required this.onClick});

  final HomeScreenController _homeScreenController =
      Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return GetX<HomeScreenController>(builder: (GetxContext) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            onClick(widgetKey);
            String selectedImage = ItemsData[index]["image"];

            _homeScreenController.addImage(selectedImage);
          },
          child: Container(
            width: 50,
            height: 100,
            decoration: BoxDecoration(
                color: ColorConstrain.primary,
                borderRadius: BorderRadius.circular(25)),
            child: Stack(
              children: [
                Positioned(
                  left: 10,
                  right: 10,
                  top: 5,
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Container(
                      key: widgetKey,
                      child: Image.asset(
                        "${ItemsData[index]["image"]}",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 1,
                  child: Container(
                    height: 90,
                    width: 162,
                    decoration: BoxDecoration(
                        color: ColorConstrain.secondary,
                        borderRadius: BorderRadius.circular(25)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10, left: 30),
                          child: Text(
                            "${ItemsData[index]["item_name"]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: FontConstrain.text),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 35),
                          child: Text(
                            "RS : ${ItemsData[index]["price"]}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: FontConstrain.sub_text),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 70,
                              margin: const EdgeInsets.only(top: 10, right: 10),
                              decoration: BoxDecoration(
                                  color: ColorConstrain.primary,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        _homeScreenController.decrement(index);
                                      },
                                      child: const Icon(Icons.remove)),
                                  Text(
                                    "${_homeScreenController.itemCounts[index].value}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 15),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        _homeScreenController.increment(index);
                                      },
                                      child: const Icon(Icons.add)),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
