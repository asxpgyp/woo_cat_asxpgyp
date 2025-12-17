import 'package:get/get.dart';

class CheckboxController extends GetxController {
  CheckboxController();

  bool checked = false;

  void onChanged(bool? checked) {
    this.checked = checked!;
    update(["checkbox"]);
  }

  _initData() {
    update(["checkbox"]);
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
