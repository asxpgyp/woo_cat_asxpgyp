import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/index.dart';
import 'index.dart';

class OrderDetailsPage extends GetView<OrderDetailsController> {
  const OrderDetailsPage({super.key});

  // 标题
  Widget _buildTitle() {
    return <Widget>[
      // Order ID
      TextWidget.label(
        "${LocaleKeys.orderDetailsOrderID.tr} : ${controller.order.id}",
      ).expanded(),

      // 15 Jan 2019
      TextWidget.label("${controller.order.dateCreated?.dateFormatOfyyyyMMdd}"),
    ].toRow().padding(
      top: AppSpace.page,
      bottom: AppSpace.listRow,
      left: AppSpace.page,
      right: AppSpace.page,
    );
  }

  // 横向状态
  Widget _buildHorizontalStatus() {
    return <Widget>[
      const StepHorizontalItemWidget(
        statusName: "Pending",
        status: StepStatus.success,
      ),
      const StepHorizontalItemWidget(
        statusName: "Confirmed",
        status: StepStatus.success,
      ),
      const StepHorizontalItemWidget(
        statusName: "Processing",
        status: StepStatus.running,
      ),
      const StepHorizontalItemWidget(
        statusName: "Picked",
        status: StepStatus.none,
      ),
      const StepHorizontalItemWidget(
        statusName: "Shipped",
        status: StepStatus.none,
      ),
      const StepHorizontalItemWidget(
        statusName: "Delivered",
        status: StepStatus.none,
      ),
    ].toRow().padding(
      bottom: AppSpace.listRow,
      left: AppSpace.page,
      right: AppSpace.page,
    );
  }

  // 纵向状态
  Widget _buildVerticalStatus() {
    return <Widget>[
      const StepVerticalItemWidget(
        statusName: "Delivered",
        statusDateTime: "20 Jan, 2019",
        statusDes:
            "Lorem Ipsum is simply dumy text of printing and typesetting industry.",
        status: StepStatus.none,
      ),
      const StepVerticalItemWidget(
        statusName: "Shipped",
        statusDateTime: "20 Jan, 2019",
        statusDes:
            "Lorem Ipsum is simply dumy text of printing and typesetting industry.",
        status: StepStatus.none,
      ),
      const StepVerticalItemWidget(
        statusName: "Picked",
        statusDateTime: "20 Jan, 2019",
        statusDes:
            "Lorem Ipsum is simply dumy text of printing and typesetting industry.",
        status: StepStatus.running,
      ),
      const StepVerticalItemWidget(
        statusName: "Processing",
        statusDateTime: "20 Jan, 2019",
        statusDes:
            "Lorem Ipsum is simply dumy text of printing and typesetting industry.",
        status: StepStatus.success,
      ),
      const StepVerticalItemWidget(
        statusName: "Confirm",
        statusDateTime: "20 Jan, 2019",
        statusDes:
            "Lorem Ipsum is simply dumy text of printing and typesetting industry.",
        status: StepStatus.success,
      ),
      const StepVerticalItemWidget(
        statusName: "Pending",
        statusDateTime: "20 Jan, 2019",
        statusDes:
            "Lorem Ipsum is simply dumy text of printing and typesetting industry.",
        status: StepStatus.success,
      ),
    ].toColumn().padding(
      bottom: AppSpace.listRow,
      left: AppSpace.page,
      right: AppSpace.page,
    );
  }

  // 寄件地、目的地
  Widget _buildBillAddress(BuildContext context) {
    return <Widget>[
          // Bill From, 商家发货地址写死
          BuildBillAddress(
            title: LocaleKeys.orderDetailsBillFrom.tr,
            address: "Adidas Shoes",
            city: "Kingston",
            state: "New York",
            country: "United States",
            phone: "+44-213 543 230",
          ).expanded(),

          // 间距
          SizedBox(width: AppSpace.iconTextMedium),

          // Bill To
          BuildBillAddress(
            title: LocaleKeys.orderDetailsBillTo.tr,
            address: controller.order.shipping?.address1,
            city: controller.order.shipping?.city,
            state: controller.order.shipping?.state,
            country: controller.order.shipping?.country,
            phone: controller.order.billing?.phone,
          ).expanded(),
        ]
        .toRow()
        .paddingAll(AppSpace.card)
        .card(
          color: context.colors.scheme.surface,
          margin: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        )
        .paddingBottom(AppSpace.listRow);
  }

  // 商品列表
  Widget _buildProductsList(BuildContext context) {
    return BuildProductList(
          lineItems: controller.order.lineItems ?? [],
          currencySymbol: controller.order.currencySymbol,
        )
        .paddingAll(AppSpace.card)
        .card(
          color: context.colors.scheme.surface,
          margin: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        )
        .paddingBottom(AppSpace.listRow);
  }

  // 小计
  Widget _buildTotal() {
    return <Widget>[
      // 左侧
      <Widget>[
            // Payment Method
            TextWidget.label(
              LocaleKeys.orderDetailsPaymentMethod.tr,
              weight: FontWeight.bold,
            ),

            // VISA Card Payment
            const TextWidget.label("VISA Card Payment"),

            // Balance 余额
            BuildTotalItem(
              title: LocaleKeys.orderDetailsBalance.tr,
              currencySymbol: controller.order.currencySymbol,
              price: "0",
            ),
          ]
          .toColumn(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
          )
          .expanded(),

      // 间距
      SizedBox(width: AppSpace.iconTextMedium),

      // 右侧
      <Widget>[
        // Total
        BuildTotalItem(
          title: LocaleKeys.orderDetailsTotal.tr,
          currencySymbol: controller.order.currencySymbol,
          price: controller.order.total,
        ),

        // Shipping
        BuildTotalItem(
          title: LocaleKeys.orderDetailsShipping.tr,
          currencySymbol: controller.order.currencySymbol,
          price: controller.order.shippingTotal,
        ),

        // Discount
        BuildTotalItem(
          title: LocaleKeys.orderDetailsDiscount.tr,
          currencySymbol: controller.order.currencySymbol,
          price: controller.order.discountTotal,
        ),
      ].toColumn(mainAxisAlignment: MainAxisAlignment.spaceAround).expanded(),
    ].toRow().height(100).paddingAll(AppSpace.card).card();
  }

  // 主视图
  Widget _buildView(BuildContext context) {
    return <Widget>[
      // 标题
      _buildTitle(),

      // 横向状态
      _buildHorizontalStatus(),

      // 纵向状态
      _buildVerticalStatus(),

      // 寄件地、目的地
      _buildBillAddress(context),

      // 商品列表
      _buildProductsList(context),

      // 小计
      _buildTotal(),

      // 底部间距
      const SizedBox(height: 20),

      // end
    ].toListView();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailsController>(
      init: OrderDetailsController(),
      id: "order_details",
      builder: (_) {
        return Scaffold(
          appBar: MainAppBarWidget(
            titleString: LocaleKeys.orderDetailsTitle.tr,
          ),
          body: SafeArea(child: _buildView(context)),
        );
      },
    );
  }
}
