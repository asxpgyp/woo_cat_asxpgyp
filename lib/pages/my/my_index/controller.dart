import 'package:get/get.dart';
import 'package:woo_2025_cat/common/index.dart';
import 'package:woo_2025_cat/pages/index.dart';

class MyIndexController extends GetxController {
  MyIndexController();

  _initData() {
    update(["my_index"]);
  }

  // 地址编辑页 type 1 billing 2 shipping
  void onToAddress(String type) {
    Get.toNamed(RouteNames.myMyAddress, arguments: {"type": type});
  }

  // 注销
  void onLogout() {
    UserService.to.logout();
    Get.find<MainController>().onJumpToPage(0);
  }

  void onTap() {}

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
