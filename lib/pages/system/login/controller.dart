import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/index.dart';

class LoginController extends GetxController {
  LoginController();

  /// 用户名
  TextEditingController userNameController = TextEditingController(
    text: "ducafecat5",
  );

  /// 密码
  TextEditingController passwordController = TextEditingController(
    text: "123456",
  );

  /// 表单 key
  GlobalKey formKey = GlobalKey<FormState>();

  /// Sign In 登入
  Future<void> onSignIn() async {
    if ((formKey.currentState as FormState).validate()) {
      Loading.show();

      // aes 加密密码
      var password = EncryptUtil().aesEncode(passwordController.text);

      // api 请求
      UserTokenModel res = await UserApi.login(
        UserLoginReq(username: userNameController.text, password: password),
      );

      // 本地保存 token
      await UserService.to.setToken(res.token!);
      // 获取用户资料
      // UserProfileModel result = await UserApi.profile();
      // await UserService.to.setProfile(result);
      // UserService.to.profile=result;
      // UserService.to.isLogin=true;
      await UserService.to.getProfile();
      Loading.success();
      Get.back(result: true);
      Loading.dismiss();
    }
  }

  /// Sign Up 注册
  void onSignUp() {
    Get.offNamed(RouteNames.systemRegister);
  }

  _initData() {
    update(["login"]);
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

  /// 释放
  @override
  void onClose() {
    super.onClose();
    userNameController.dispose();
    passwordController.dispose();
  }
}
