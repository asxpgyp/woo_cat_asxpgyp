import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/index.dart';

/// 订单列表项
class BuildOrderListItem extends StatelessWidget {
  const BuildOrderListItem({super.key, required this.item});

  final OrderModel item;

  // 标签
  Widget _buildTag(BuildContext context, String tag) {
    return TextWidget.muted(tag, color: context.colors.scheme.onPrimary)
        .paddingAll(5)
        .decorated(
          borderRadius: BorderRadius.circular(3),
          color: context.colors.scheme.primary,
        );
  }

  // 主视图
  Widget _buildView(BuildContext context) {
    return <Widget>[
          // id tag
          <Widget>[
            // 编号
            TextWidget.label("# ${item.id}").expanded(),

            // 标签tag
            _buildTag(context, item.status ?? "-"),
          ].toRow().paddingBottom(AppSpace.listRow),

          // orderKey date
          <Widget>[
            // 订单号
            TextWidget.label("${item.orderKey}").expanded(),

            // 日期
            TextWidget.muted("${item.dateCreated}".dateFormatOfyyyyMMdd),
          ].toRow(),
        ]
        .toColumn()
        .paddingAll(AppSpace.card)
        .card(color: context.colors.scheme.surface);
  }

  @override
  Widget build(BuildContext context) {
    return _buildView(context);
  }
}
