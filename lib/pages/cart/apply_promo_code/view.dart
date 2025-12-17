import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/index.dart';
import 'index.dart';

class ApplyPromoCodePage extends GetView<ApplyPromoCodeController> {
  const ApplyPromoCodePage({super.key, required this.onApplyCouponCode});

  // 应用优惠券
  final Function(String) onApplyCouponCode;

  // 底部按钮
  Widget _buildButtons(BuildContext context) {
    return <Widget>[
      // cancel
      ButtonWidget.ghost(
        LocaleKeys.commonBottomCancel.tr,
        onTap: () => Get.back(),
      ),

      // apply
      ButtonWidget.ghost(
        LocaleKeys.commonBottomApply.tr,
        textColor: context.colors.scheme.secondary,
        // 确认优惠券输入
        onTap: () {
          // 回调函数
          onApplyCouponCode(controller.couponController.text);
          Get.back();
        },
        // textColor: AppColors.highlight,
        // textWeight: FontWeight.w500,
      ),
    ].toRow(mainAxisAlignment: MainAxisAlignment.end);
  }

  // 主视图
  Widget _buildView(BuildContext context) {
    return <Widget>[
          // 标题
          TextWidget.body(
            LocaleKeys.promoCode.tr,
            weight: FontWeight.w600,
          ).paddingBottom(AppSpace.listRow),

          // 说明
          TextWidget.label(
            LocaleKeys.promoDesc.tr,
            maxLines: 3,
            softWrap: true,
          ).paddingBottom(AppSpace.listRow),

          // 输入优惠券
          InputWidget(
            controller: controller.couponController,
            placeholder: "Enter your coupon code",
          ).paddingBottom(AppSpace.listRow),

          // 按钮
          _buildButtons(context),
        ]
        .toColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
        )
        .paddingAll(40)
        .backgroundColor(context.colors.scheme.surface);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApplyPromoCodeController>(
      init: ApplyPromoCodeController(),
      id: "apply_promo_code",
      builder: (_) {
        return _buildView(context);
      },
    );
  }
}
