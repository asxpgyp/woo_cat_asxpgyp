import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/components/colors_list.dart';
import '../../../../common/index.dart';
import '../index.dart';

/// 商品规格
class TabProductView extends GetView<ProductDetailsController> {
  final String uniqueTag;

  const TabProductView({super.key, required this.uniqueTag});

  @override
  String? get tag => uniqueTag;

  // 标题
  _buildTitle(String title) {
    return TextWidget.body(
      title,
      weight: FontWeight.w500,
    ).paddingBottom(AppSpace.listRow);
  }

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      // 颜色
      _buildTitle("Color"),
      GetBuilder<ProductDetailsController>(
        id: "product_colors",
        tag: uniqueTag,
        builder: (_) {
          return ColorsListWidget(
            itemList: controller.colors,
            keys: controller.colorKeys,
            size: 33.w,
            onTap: controller.onColorTap,
          ).paddingBottom(AppSpace.listRow * 2);
        },
      ),
      // 尺寸
      _buildTitle("Size"),
      GetBuilder<ProductDetailsController>(
        id: "product_sizes",
        tag: uniqueTag,
        builder: (_) {
          return TagsListWidget(
            itemList: controller.sizes,
            keys: controller.sizeKeys,
            onTap: controller.onSizeTap,
          ).paddingBottom(AppSpace.listRow * 2);
        },
      ),
      // 运费说明
      _buildTitle("Shipping Charge"),
      <Widget>[
        // 运费
        TextWidget.label(
          "\$${controller.product?.regularPrice ?? "0.0"}",
          size: 18,
          weight: FontWeight.bold,
        ).paddingRight(AppSpace.listItem),
        // 说明
        const TextWidget.label("by paperfly shipment"),
      ].toRow(),
    ].toListView(scrollDirection: Axis.vertical).paddingVertical(AppSpace.page);
  }
}
