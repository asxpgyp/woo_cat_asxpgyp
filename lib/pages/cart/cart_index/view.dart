import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woo_2025_cat/common/index.dart';

import 'index.dart';

class CartIndexPage extends GetView<CartIndexController> {
  const CartIndexPage({super.key});

  // 订单列表
  Widget _buildOrders() {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        LineItem item = CartService.to.lineItems[index];
        // 购物车项
        return CartItem(
          lineItem: item, // 是否选中
          isSelected: controller.isSelected(item.productId!),
          // 修改数量回调
          onChangeQuantity: (quantity) =>
              controller.onChangeQuantity(item, quantity),
          // 选中回调
          onSelect: (isSelected) =>
              controller.onSelect(item.productId!, isSelected!),
        ).paddingAll(AppSpace.card).card();
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: AppSpace.listRow);
      },
      itemCount: CartService.to.lineItems.length,
    );
  }

  // 优惠券, 568935ab
  Widget _buildCoupons() {
    return <Widget>[
      // 输入框
      InputWidget(
        placeholder: "Voucher Code",
        // 输入优惠券代码
        onChanged: (value) => controller.couponCode = value,
      ).expanded(),

      // 应用按钮
      ButtonWidget.ghost(
        LocaleKeys.gCartBtnApplyCode.tr,
        onTap: controller.onApplyCoupon, // 应用事件
      ),
    ].toRow();
  }

  // 统计
  Widget _buildTotal(BuildContext context) {
    return <Widget>[
          // 运费、代金券
          <Widget>[
                // 运费
                TextWidget.label(
                  "  ${LocaleKeys.gCartTextShippingCost.tr}: \$  ${CartService.to.shipping}",
                ),
                // 代金券
                TextWidget.label(
                  "  ${LocaleKeys.gCartTextVocher.tr}: \$  ${CartService.to.discount}",
                ),
              ]
              .toColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              )
              .expanded(),

          // 费用小计
          TextWidget.label(
            " ${LocaleKeys.gCartTextTotal.tr}: \$  ${CartService.to.totalItemsPrice - CartService.to.discount + CartService.to.shipping}",
          ).paddingRight(AppSpace.iconTextMedium),

          // 确认下单 checkout
          ButtonWidget.primary(
            LocaleKeys.gCartBtnCheckout.tr,
            onTap: () {},
            // borderRadius: 3.sp,
          ),
        ]
        .toRow()
        .paddingAll(AppSpace.card)
        .decorated(
          color: context.colors.scheme.secondary.withOpacity(0.1),
          border: Border.all(color: context.colors.scheme.secondary, width: 1),
        );
  }

  // 主视图
  Widget _buildView(BuildContext context) {
    return <Widget>[
      // 顶部操作栏
      ActionBar(
        onAll: controller.onSelectAll,
        onRemove: controller.onOrderCancel,
        isAll: controller.isSelectedAll,
      ).paddingAll(AppSpace.page),
      // 订单列表
      _buildOrders().paddingHorizontal(AppSpace.page).expanded(),

      // 优惠券
      _buildCoupons(),

      // // 费用小计
      _buildTotal(context),
    ].toColumn();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartIndexController>(
      init: Get.find<CartIndexController>(),
      id: "cart_index",
      builder: (_) {
        return Scaffold(
          appBar: MainAppBarWidget(titleString: LocaleKeys.gCartTitle.tr),
          body: SafeArea(child: _buildView(context)),
        );
      },
    );
  }
}
