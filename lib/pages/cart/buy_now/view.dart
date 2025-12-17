import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/index.dart';
import 'index.dart';

class BuyNowPage extends GetView<BuyNowController> {
  const BuyNowPage({super.key, required this.product});

  // 商品数据
  final ProductModel product;

  // 标题
  Widget _buildTitle(String text) {
    return TextWidget.body(
      text,
      weight: FontWeight.w600,
    ).paddingBottom(AppSpace.listRow);
  }

  // 支付方式
  Widget _buildPayment(BuildContext context) {
    return List<Widget>.generate(
          controller.paymentList.length,
          (index) =>
              ImageWidget.img(
                    controller.paymentList[index],
                    width: 106.w,
                    height: 50.w,
                  )
                  .decorated(
                    color: Colors.white,
                    border: Border.all(
                      color: context.colors.scheme.surfaceContainer,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppRadius.button),
                    ),
                  )
                  .paddingRight(AppSpace.iconTextSmail),
        )
        .toListView(scrollDirection: Axis.horizontal)
        .height(50.w)
        .paddingBottom(AppSpace.listRow);
  }

  // 送货地址
  Widget _buildShipping(BuildContext context) {
    return <Widget>[
          // 文字
          TextWidget.label(controller.shippingAddress).expanded(),

          // 图标
          const IconWidget.icon(Icons.arrow_drop_down, size: 32),
        ]
        .toRow()
        .paddingAll(AppSpace.button)
        .decorated(
          // color: AppColors.surfaceVariant,
          border: Border.all(
            color: context.colors.scheme.surfaceContainer,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(AppRadius.button),
        )
        .onTap(controller.onShippingTap)
        .paddingBottom(AppSpace.listRow);
  }

  // 小计
  Widget _buildPrice(BuildContext context) {
    return <Widget>[
      // Shipping: $2.05
      BuildPriceLine(
        titleString: LocaleKeys.placeOrderPriceShipping.tr,
        priceString: "\$ ${controller.shipping}",
      ),

      // Discount: $3.05
      BuildPriceLine(
        titleString: LocaleKeys.placeOrderPriceDiscount.tr,
        priceString: "\$ ${controller.discount}",
      ),

      // Voucher Code:
      BuildPriceLine(
        titleString: LocaleKeys.placeOrderPriceVoucherCode.tr,
        rightWidget: ButtonWidget.ghost(
          LocaleKeys.placeOrderPriceVoucherCodeEnter.tr,
          textColor: context.colors.scheme.secondary,
          scale: WidgetScale.small,
          onTap: controller.onEnterCouponCode, // 输入优惠券码
        ),
      ),

      // Total: $14.60
      BuildPriceLine(
        leftWidget: TextWidget.label(LocaleKeys.placeOrderTotal.tr),
        rightWidget: TextWidget.label(
          "\$ ${controller.totalPrice - controller.discount}",
        ),
      ),

      //
    ].toColumn();
  }

  // 底部按钮
  Widget _buildButtons() {
    return <Widget>[
      // 取消
      ButtonWidget.outline(
        LocaleKeys.commonBottomCancel.tr,
        onTap: () => Get.back(),
      ).expanded(),

      // 间距
      SizedBox(width: AppSpace.iconTextLarge),

      // 立刻购买 Place Order
      ButtonWidget.primary(
        LocaleKeys.placeOrderBtnPlaceOrder.tr,
        onTap: controller.onCheckout,
      ).expanded(),
    ].toRow(mainAxisAlignment: MainAxisAlignment.spaceAround);
  }

  // 主视图
  Widget _buildView(BuildContext context) {
    return <Widget>[
          // 支付方式
          _buildTitle(LocaleKeys.placeOrderPayment.tr),
          _buildPayment(context),

          // 送货地址
          _buildTitle(LocaleKeys.placeOrderShippingAddress.tr),
          _buildShipping(context),

          // 数量
          _buildTitle(LocaleKeys.placeOrderQuantity.tr),
          QuantityWidget(
            quantity: controller.quantity,
            onChange: controller.onQuantityChange,
          ).paddingBottom(AppSpace.listRow),

          // 小计
          _buildTitle(LocaleKeys.placeOrderPrice.tr),
          _buildPrice(context),

          // 按钮
          _buildButtons(),

          // end
        ]
        .toColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
        )
        .paddingAll(AppSpace.page);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuyNowController>(
      init: BuyNowController(product: product),
      id: "buy_now",
      builder: (_) {
        return _buildView(context);
      },
    );
  }
}
