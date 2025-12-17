import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/index.dart';
import 'index.dart';

class BuyDonePage extends GetView<BuyDoneController> {
  const BuyDonePage({super.key});

  // 主视图
  Widget _buildView() {
    return <Widget>[
      // 图
      ImageWidget.img(
        AssetsImages.orderConfirmedPng,
        height: 300.w,
      ).paddingBottom(40.w),

      // 文字
      TextWidget.h4(LocaleKeys.orderConfirmationTitle.tr).paddingBottom(10.w),
      TextWidget.label(LocaleKeys.orderConfirmationDesc.tr).paddingBottom(50.w),

      // 返回按钮
      ButtonWidget.primary(
        LocaleKeys.commonBottomBack.tr,
        onTap: () => Get.until(
          (route) =>
              route.settings.name == RouteNames.systemMain, // 条件：路由名称为页面a
        ),
      ).width(100.w),
    ].toColumn(mainAxisAlignment: MainAxisAlignment.center).center();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuyDoneController>(
      init: BuyDoneController(),
      id: "buy_done",
      builder: (_) {
        return Scaffold(body: SafeArea(child: _buildView()));
      },
    );
  }
}
