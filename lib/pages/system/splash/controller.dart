import 'package:get/get.dart';

import '../../../common/index.dart';

class SplashController extends GetxController {
  SplashController();

  String title = "";

  _jumpToPage() {
    // 欢迎页
    Future.delayed(const Duration(seconds: 1), () {
      // 是否首次打开
      if (ConfigService.to.isAlreadyOpen) {
        Get.offAllNamed(RouteNames.systemMain);
      } else {
        Get.offAllNamed(RouteNames.systemWelcome);
      }
    });
  }

  _initData() {
    update(["splash"]);
  }

  void onTap(int ticket) {
    title = "GetBuilder->点击了$ticket个按钮";
    update(["splash_title"]);
  }

  @override
  void onInit() {
    super.onInit();
    // 设置系统样式
    AppTheme.setSystemStyle();
  }

  @override
  void onReady() {
    super.onReady();
    // _initData();
    _jumpToPage();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
