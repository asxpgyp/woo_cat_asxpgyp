import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';

import '../../../../common/index.dart';

/// 价格行组件
class BuildPriceLine extends StatelessWidget {
  const BuildPriceLine({
    super.key,
    this.titleString,
    this.priceString,
    this.leftWidget,
    this.rightWidget,
  });

  /// 标题 字符串
  final String? titleString;

  /// 价格 字符串
  final String? priceString;

  /// 左侧组件
  final Widget? leftWidget;

  /// 右侧组件
  final Widget? rightWidget;

  // 主视图
  Widget _buildView() {
    return <Widget>[
      // 左侧
      leftWidget?.expanded() ?? TextWidget.label(titleString ?? "").expanded(),

      // 右侧
      rightWidget ?? TextWidget.label(priceString ?? ""),
    ].toRow().paddingBottom(AppSpace.listRow);
  }

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }
}
