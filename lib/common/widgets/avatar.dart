import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import '../index.dart';

/// 头像类型
enum AvatarWidgetType { img, svg, text }

/// 头像组件
class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key,
    required this.type,
    this.path,
    this.size,
    this.onTap,
    this.borderWidth,
    this.elevation,
    this.backgroundColor,
    this.padding,
    this.firstChar,
  });

  /// 类型
  final AvatarWidgetType type;

  /// 头像地址
  final String? path;

  /// 头像尺寸
  final double? size;

  /// padding 边框间距
  final EdgeInsetsGeometry? padding;

  /// 点击事件
  final GestureTapCallback? onTap;

  /// 边框
  final double? borderWidth;

  /// 阴影
  final double? elevation;

  /// 背景色
  final Color? backgroundColor;

  /// 首字符
  final String? firstChar;

  const AvatarWidget.img(
    this.path, {
    super.key,
    this.size,
    this.onTap,
    this.borderWidth,
    this.elevation,
    this.backgroundColor,
    this.padding,
    this.firstChar,
  }) : type = AvatarWidgetType.img;

  const AvatarWidget.svg(
    this.path, {
    super.key,
    this.size,
    this.onTap,
    this.borderWidth,
    this.elevation,
    this.backgroundColor,
    this.padding,
    this.firstChar,
  }) : type = AvatarWidgetType.svg;

  const AvatarWidget.text(
    this.firstChar, {
    super.key,
    this.path,
    this.size,
    this.onTap,
    this.borderWidth,
    this.elevation,
    this.backgroundColor,
    this.padding,
  }) : type = AvatarWidgetType.text;

  Widget _buildView(BuildContext context) {
    Widget child = const SizedBox.shrink();
    bool isHttp = path != null && path!.startsWith('http');
    double imgSize = size ?? AppSize.avatar;

    switch (type) {
      case AvatarWidgetType.img:
        child = isHttp == true
            ? ImageWidget.img(
                path!,
                width: imgSize,
                height: imgSize,
                radius: imgSize / 2,
              )
            : IconWidget.img(path!, size: imgSize);
        break;
      case AvatarWidgetType.svg:
        child = isHttp == true
            ? ImageWidget.svg(
                path!,
                width: imgSize,
                height: imgSize,
                radius: imgSize / 2,
              )
            : IconWidget.svg(path!, size: imgSize);
        break;
      case AvatarWidgetType.text:
        child = TextWidget.body(
          firstChar?.substring(0, 1).toUpperCase() ?? '?',
        ).center().tightSize(imgSize);
        break;
    }

    // padding
    // child = child.padding(
    //   horizontal: padding?.horizontal ?? AppPadding.avatar.horizontal,
    //   vertical: padding?.vertical ?? AppPadding.avatar.vertical,
    // );

    // 涟漪, 点击事件
    // if (onTap != null) {
    //   child = child.ripple();
    // }

    // 圆角、边框
    child = child.decorated(
      color: backgroundColor ?? context.colors.scheme.surfaceContainer,
      borderRadius: BorderRadius.circular(size ?? AppSize.avatar),
      border: Border.all(
        color: context.colors.primary,
        width: borderWidth ?? AppBorder.avatar,
      ),
    );

    // 裁切圆形, 点击事件，把涟漪一起切成圆形
    // if (onTap != null) {
    //   child = child.clipOval();
    // }

    // 阴影
    child = child.elevation(
      elevation ?? AppElevation.avatar,
      borderRadius: BorderRadius.circular(size ?? AppSize.avatar),
      shadowColor: context.colors.shadow,
    );

    // 点击事件
    if (onTap != null) {
      child = child.onTap(onTap);
    }

    return child;
  }

  @override
  Widget build(BuildContext context) {
    return _buildView(context);
  }
}
