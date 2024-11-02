import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/controller/home_screen/home_screen_controller.dart';
import 'package:getx/data/data.dart';
import 'package:getx/utils/color_constrain.dart';
import 'package:getx/utils/font_constrain.dart';
import 'package:getx/view/item_view.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;
  var _cartQuantityItems = 0;

  final HomeScreenController _homeScreenController =
      Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      cartKey: cartKey,
      height: 30,
      width: 30,
      opacity: 0.85,
      dragAnimation: const DragToCartAnimationOptions(
        rotation: true,
      ),
      jumpAnimation: const JumpAnimationOptions(),
      createAddToCartAnimation: (runAddToCartAnimation) {
        this.runAddToCartAnimation = runAddToCartAnimation;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstrain.primary,
          title: Center(
            child: Container(
              margin: const EdgeInsets.only(right: 50),
              height: 50,
              width: 200,
              child: Image.asset(
                "assets/Homelogo.png",
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: GridView.builder(
                    itemCount: ItemsData.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5.0,
                            crossAxisSpacing: 5.0,
                            childAspectRatio: 0.8),
                    itemBuilder: (context, index) {
                      // ignore: non_constant_identifier_names
                      return ItemView(
                        onClick: listClick,
                        index: index,
                      );
                    })),
            Container(
              height: 90,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: ColorConstrain.secondary),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      width: 95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border:
                            Border.all(width: 2, color: Colors.yellow.shade700),
                        color: ColorConstrain.primary,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.yellow.shade700.withOpacity(0.6),
                            spreadRadius: 4,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Add To Cart",
                          style: TextStyle(
                            fontSize: FontConstrain.text,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  AddToCartIcon(
                    key: cartKey,
                    icon: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.yellow.shade700.withOpacity(0.4),
                            spreadRadius: 6,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.shopping_cart,
                        color: ColorConstrain.primary,
                      ),
                    ),
                    badgeOptions: const BadgeOptions(
                      active: true,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              _homeScreenController.selectedImages.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorConstrain.secondary,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.yellow.shade700
                                          .withOpacity(0.6),
                                      spreadRadius: 4,
                                      blurRadius: 5,
                                    ),
                                  ],
                                  border: Border.all(
                                    width: 2,
                                    color: ColorConstrain.primary,
                                  ),
                                ),
                                child: ClipOval(
                                  child: GestureDetector(
                                    onLongPress: () {
                                      _homeScreenController.selectedImages
                                          .removeAt(index);

                                      if (_cartQuantityItems > 0) {
                                        _cartQuantityItems--;
                                        cartKey.currentState!.runCartAnimation(
                                            _cartQuantityItems.toString());
                                      }
                                    },
                                    child: Image.asset(
                                      _homeScreenController
                                          .selectedImages[index],
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: ColorConstrain.secondary,
          width: 280,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  color: ColorConstrain.primary,
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/profile.jpg")),
                    SizedBox(height: 10),
                    Text(
                      "Ali Ammar",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "aliammar0342@gmail.com",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.home, color: ColorConstrain.primary),
                title:
                    const Text("Home", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading:
                    Icon(Icons.shopping_bag, color: ColorConstrain.primary),
                title: const Text(
                  "Order",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: ColorConstrain.primary),
                title: const Text("Settings",
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void listClick(GlobalKey widgetKey) async {
    await runAddToCartAnimation(widgetKey);
    await cartKey.currentState!
        .runCartAnimation((++_cartQuantityItems).toString());
  }
}
