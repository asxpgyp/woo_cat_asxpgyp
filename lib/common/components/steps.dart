import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';

import '../index.dart';

/// 状态枚举
enum StepStatus { none, running, success }

/// 横向状态
class StepHorizontalItemWidget extends StatelessWidget {
  /// 状态名称
  final String statusName;

  /// 状态
  final StepStatus status;

  const StepHorizontalItemWidget({
    super.key,
    required this.statusName,
    this.status = StepStatus.none,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return <Widget>[
          // 指示标
          <Widget>[
                // 横线 - 灰色打底
                Container(
                  color: context.colors.scheme.secondary.withOpacity(0.5),
                  height: 3,
                ),
                // 横线
                if (status == StepStatus.success)
                  Container(color: context.colors.scheme.primary, height: 3),
                if (status == StepStatus.running)
                  Container(
                    color: context.colors.scheme.primary,
                    height: 3,
                    width: constraints.minWidth / 2,
                  ).alignLeft(),
                // 圆点
                Container(
                  height: 7,
                  width: 7,
                  decoration: BoxDecoration(
                    color: status == StepStatus.none
                        ? context.colors.scheme.secondary.withOpacity(0.5)
                        : context.colors.scheme.primary,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(7 / 2),
                    ),
                  ),
                ),
              ]
              .toStack(alignment: Alignment.center)
              .paddingBottom(AppSpace.iconTextSmail),

          // 文字
          TextWidget.muted(statusName, scale: WidgetScale.small),
        ].toColumn();
      },
    ).expanded();
  }
}

/// 纵向状态
class StepVerticalItemWidget extends StatelessWidget {
  /// 状态名称
  final String statusName;

  /// 状态描述
  final String? statusDes;

  /// 状态时间
  final String? statusDateTime;

  /// 状态
  final StepStatus status;

  const StepVerticalItemWidget({
    super.key,
    required this.statusName,
    this.statusDes,
    this.statusDateTime,
    this.status = StepStatus.none,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return <Widget>[
          // 日期
          TextWidget.label(statusDateTime ?? "-"),

          // 指示标
          <Widget>[
            // 打底灰色
            Container(
              width: 3,
              height: constraints.minHeight,
              color: context.colors.scheme.secondary.withOpacity(0.5),
            ),
            // 横线
            if (status == StepStatus.success)
              Container(
                width: 3,
                height: constraints.minHeight,
                color: context.colors.scheme.primary,
              ),
            if (status == StepStatus.running)
              Container(
                width: 3,
                height: constraints.minHeight / 2,
                color: context.colors.scheme.primary,
              ).positioned(top: constraints.minHeight / 2),
            // 圆点
            Container(
              height: 7,
              width: 7,
              decoration: BoxDecoration(
                color: status == StepStatus.none
                    ? context.colors.scheme.secondary.withOpacity(0.5)
                    : context.colors.scheme.primary,
                borderRadius: const BorderRadius.all(Radius.circular(7 / 2)),
              ),
            ),
          ].toStack(alignment: Alignment.center).width(30),

          // 标题,说明
          <Widget>[
                TextWidget.label(statusName),
                TextWidget.muted(statusDes ?? "-", softWrap: true, maxLines: 3),
              ]
              .toColumn(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
              )
              .expanded(),
        ].toRow();
      },
    ).constrained(minHeight: 70);
  }
}
