import 'package:boilerplate_flutter/model/place/place_res.dart';
import 'package:boilerplate_flutter/model/product/product.dart';
import 'package:boilerplate_flutter/model/user/trainer.dart';
import 'package:get/get.dart';
//final cBook = Get.find<BookController>();
class BookController extends GetxController {
  Future<BookController> init() async {
    return this;
  }

  var selectTrainner = <Trainers>[].obs;
  var selectPlace = <Place>[].obs;
  var selectLong = 0.0.obs;
  var selectLat = 0.0.obs;
  var selectProduct = <Product>[].obs;
  var scheduleDate = "".obs;
  var scheduleTime = "".obs;
}
