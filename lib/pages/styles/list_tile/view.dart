import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woo_2025_cat/common/index.dart';

import 'index.dart';

class ListTilePage extends GetView<ListTileController> {
  const ListTilePage({super.key});
  // 头像
  Widget _buildAvatar(String svgPath) {
    return IconWidget.svg(svgPath, size: 28);
  }

  // 按钮
  Widget _buildAiButton(BuildContext context, IconData iconData) {
    return ButtonWidget.icon(
      IconWidget.icon(
        iconData,
        color: context.colors.primary,
      ).backgroundColor(context.colors.scheme.surfaceContainer).tightSize(28),
      onTap: () {},
    );
  }

  // 主视图
  Widget _buildView(BuildContext context) {
    return <Widget>[
      // 主标题、副标题、左侧图标、右侧图标
      const TextWidget.label('主标题、副标题、左侧图标、右侧图标'),
      const ListTileWidget(
        title: TextWidget.label("title"),
        subtitle: TextWidget.muted("subtitle"),
        leading: IconWidget.icon(Icons.login),
        trailing: <Widget>[IconWidget.icon(Icons.arrow_forward_ios)],
      ),

      // 主标题、左侧图标、右侧图标
      const TextWidget.label('主标题、左侧图标、右侧图标'),
      ListTileWidget(
        title: TextWidget.label("title"),
        leading: IconWidget.icon(Icons.login),
        trailing: <Widget>[IconWidget.icon(Icons.arrow_forward_ios)],
        onTap: () {},
      ),

      // svg 图标、背景色
      const TextWidget.label('svg 图标、背景色'),
      ListTileWidget(
        title: const TextWidget.label("编程助手"),
        subtitle: const TextWidget.muted("输入你的编程语言和需求"),
        leading: _buildAvatar(AssetsSvgs.cBagSvg),
        trailing: <Widget>[_buildAiButton(context, Icons.play_arrow)],
        backgroundColor: context.colors.scheme.surfaceContainer,
      ),

      // svg 图标、背景色
      const TextWidget.label('svg 图标、背景色'),
      ListTileWidget(
        title: const TextWidget.label("写作助手"),
        subtitle: const TextWidget.muted("输入你的文章标题和内容范围"),
        leading: _buildAvatar(AssetsSvgs.cBikeSvg),
        trailing: <Widget>[_buildAiButton(context, Icons.stop)],
        backgroundColor: context.colors.scheme.tertiaryContainer,
      ),

      // end
    ].toColumnSpace().paddingAll(AppSpace.page).scrollable();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListTileController>(
      init: ListTileController(),
      id: "list_tile",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("list_tile 列表项")),
          body: SafeArea(child: _buildView(context)),
        );
      },
    );
  }
}
