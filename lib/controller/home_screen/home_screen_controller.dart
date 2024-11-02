import 'package:get/get.dart';
import 'package:getx/data/data.dart';
import 'package:getx/model/model.dart';

class HomeScreenController extends GetxController {
  List<RxInt> itemCounts = List.generate(ItemsData.length, (index) => 1.obs);
  RxList<String> selectedImages = <String>[].obs;
  Rx<num> total = 0.obs;

  void calculateTotal() {
    total.value = 0;
    for (var item in item) {
      total.value += item.count * item.price;
    }
  }

  void increment(int index) {
    itemCounts[index].value++;
    item[index] =
        Cart(price: item[index].price, count: itemCounts[index].value);
    calculateTotal();
  }

  void decrement(int index) {
    if (itemCounts[index].value > 1) {
      itemCounts[index].value--;
      item[index] =
          Cart(price: item[index].price, count: itemCounts[index].value);
      calculateTotal();
    }
  }

  void addImage(String image) {
    selectedImages.add(image);
  }
}
