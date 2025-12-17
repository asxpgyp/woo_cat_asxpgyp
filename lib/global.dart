import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woo_2025_cat/common/services/wp_http.dart';

import 'common/index.dart';
import 'common/services/config.dart';

class Global {
  static Future<void> init() async {
    // 插件初始化
    WidgetsFlutterBinding.ensureInitialized();
    // 初始化kv存储
    await Storage().init();
    Loading();
    // 初始化
    Get.put<WPHttpService>(WPHttpService());
    Get.put<ConfigService>(ConfigService());
    Get.put<UserService>(UserService()); // 用户
    Get.put<CartService>(CartService());

    // await ConfigService.to.init();
  }
}
