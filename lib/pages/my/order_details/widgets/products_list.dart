import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/index.dart';

/// 商品列表
class BuildProductList extends StatelessWidget {
  const BuildProductList({
    super.key,
    required this.lineItems,
    this.currencySymbol,
  });

  /// 购物列表
  final List<LineItem> lineItems;

  /// 货币符号
  final String? currencySymbol;

  // 标题
  TableRow _tableHeader() {
    return TableRow(
      children: [
        const SizedBox(width: 50),
        TextWidget.label(LocaleKeys.orderDetailsProduct.tr).center(),
        TextWidget.label(LocaleKeys.orderDetailsRateQty.tr).center(),
        TextWidget.label(LocaleKeys.orderDetailsAmount.tr).center(),
      ],
    );
  }

  // 主视图
  Widget _buildView() {
    List<TableRow> ws = [];

    // 头部
    ws.add(_tableHeader());

    // 商品列表
    for (int i = 0; i < lineItems.length; i++) {
      LineItem item = lineItems[i];
      TableRow tr = TableRow(
        children: [
          // 编号
          TextWidget.muted("${i + 1}").center(),

          // 图 + 名称
          <Widget>[
            ImageWidget.img(
              Convert.aliImageResize(
                item.product?.images?[0].src ?? "",
                width: 140,
              ),
              width: 70.w,
              height: 70.w,
              radius: AppRadius.image,
            ).center(),
            TextWidget.muted(item.product?.name ?? "").center(),
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),

          // 单价x数量
          TextWidget.muted("${item.price} x ${item.quantity}").center(),

          // 金额
          TextWidget.muted("$currencySymbol ${item.total}").center(),
        ],
      );
      ws.add(tr);
    }

    return Table(
      // 列宽
      columnWidths: const {
        0: FixedColumnWidth(50.0),
        2: FixedColumnWidth(100.0),
        3: FixedColumnWidth(80.0),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: ws,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }
}
