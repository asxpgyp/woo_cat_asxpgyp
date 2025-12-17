import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';

import '../../../../common/index.dart';

/// 小计项
class BuildTotalItem extends StatelessWidget {
  const BuildTotalItem({
    super.key,
    this.title,
    this.price,
    this.currencySymbol,
  });

  /// 标题
  final String? title;

  /// 价格
  final String? price;

  /// 货币符号
  final String? currencySymbol;

  // 主视图
  Widget _buildView() {
    return <Widget>[
      // title
      TextWidget.label(title ?? "").expanded(),

      // price
      TextWidget.muted("$currencySymbol $price"),
    ].toRow();
  }

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }
}
