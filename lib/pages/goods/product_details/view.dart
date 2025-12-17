import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../common/components/index.dart';
import '../../../common/i18n/index.dart';
import '../../../common/index.dart';
import 'index.dart';

class ProductDetailsPage extends StatefulWidget {
  ProductDetailsPage({super.key});

  // 5 定义 tag 值，唯一即可
  final String tag = '${Get.arguments['id'] ?? ''}${UniqueKey()}';

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // 6 实例传入 tag
    return _ProductDetailsViewGetX(widget.tag);
  }
}

class _ProductDetailsViewGetX extends GetView<ProductDetailsController> {
  // 1 定义唯一 tag 变量
  final String uniqueTag;

  // 2 接收传入 tag 值
  const _ProductDetailsViewGetX(this.uniqueTag);

  @override
  String? get tag => uniqueTag;

  // 滚动图
  Widget _buildBanner(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
      id: "product_banner",
      tag: tag,
      builder: (_) {
        return CarouselWidget(
          // 打开大图预览
          onTap: controller.onGalleryTap,
          // 图片列表
          items: controller.bannerItems,
          // 当前索引
          currentIndex: controller.bannerCurrentIndex,
          // 切换回调
          onPageChanged: controller.onChangeBanner,
          // 高度
          height: 190.w,
          // 指示器圆点
          indicatorCircle: false,
          // 指示器位置
          indicatorAlignment: MainAxisAlignment.start,
          // 指示器颜色
          indicatorColor: context.colors.scheme.secondary,
        );
      },
    ).backgroundColor(context.colors.scheme.surface);
  }

  // 商品标题
  Widget _buildTitle(BuildContext context) {
    return <Widget>[
          // 金额、打分、喜欢
          <Widget>[
            // 金额
            TextWidget.h3("\$ ${controller.product?.price ?? 0}").expanded(),
            // 打分
            IconWidget.icon(
              Icons.star,
              text: "4.5",
              size: 20,
              color: context.colors.scheme.primary,
            ).paddingRight(AppSpace.iconTextMedium),
            // 喜欢
            IconWidget.icon(
              Icons.favorite,
              text: "100+",
              size: 20,
              color: context.colors.scheme.primary,
            ),
          ].toRow(),

          // 次标题
          TextWidget.label(
            controller.product?.shortDescription?.clearHtml ?? "-",
          ),
        ]
        .toColumn(
          // 左对齐
          crossAxisAlignment: CrossAxisAlignment.start,
          // 垂直间距
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        )
        .paddingAll(AppSpace.page);
  }

  // Tab 栏位按钮
  Widget _buildTabBarItem(BuildContext context, String textString, int index) {
    // 当前动画值
    final double offset =
        controller.tabController.animation?.value ??
        controller.tabIndex.toDouble();
    if (textString == "规格") {
      print("offset$textString---$offset");
    }
    // 计算当前项的激活比例 0~1
    final double t = 1 - (offset - index).abs().clamp(0, 1);
    if (textString == "规格") {
      print("t$textString---$t");
    }
    // 插值颜色
    final Color color = Color.lerp(
      context.colors.scheme.onPrimaryContainer, // 未选中
      context.colors.scheme.onSecondary, // 选中
      t,
    )!;
    return ButtonWidget.outline(
      textString,
      scale: WidgetScale.small,
      onTap: () => controller.onTapBarTap(index),
      borderRadius: 17,
      borderColor: Colors.transparent,
      textColor: color,
      // backgroundColor: controller.tabIndex == index
      //     ? context.colors.scheme.primary
      //     : context.colors.scheme.onPrimary,
    ).tight(
      width: 100.w,
      // height: 35.h,
    );
  }

  // Tab 栏位
  Widget _buildTabBar(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
      tag: tag,
      id: "product_tab",
      builder: (_) {
        return AnimatedBuilder(
          animation: controller.tabController.animation!,
          builder: (context, _) {
            return TabBar(
              controller: controller.tabController,
              indicator: BoxDecoration(
                color: context.colors.scheme.primary, // 选中背景色
                borderRadius: BorderRadius.circular(17),
              ),
              indicatorWeight: 0,
              tabs: [
                _buildTabBarItem(context, LocaleKeys.gDetailTabProduct.tr, 0),
                _buildTabBarItem(context, LocaleKeys.gDetailTabDetails.tr, 1),
                _buildTabBarItem(context, LocaleKeys.gDetailTabReviews.tr, 2),
              ],
            ).tight(height: 30).paddingHorizontal(30.w);
          },
        );
      },
    );
  }

  // TabView 视图
  Widget _buildTabView() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 0.w, 20.w, 0.w),
      child: TabBarView(
        controller: controller.tabController,
        // physics: const NeverScrollableScrollPhysics(), // 禁止滑动
        children: [
          // 规格
          TabProductView(uniqueTag: uniqueTag),
          // 详情
          TabDetailView(uniqueTag: uniqueTag),
          // 评论
          TabReviewsView(uniqueTag: uniqueTag),
        ],
      ),
    );
  }

  // 主视图
  Widget _buildView(BuildContext context) {
    return controller.product == null
        ? const PlaceholdWidget() // 占位图
        : CustomScrollView(
            slivers: [
              // 滚动图
              _buildBanner(context).sliverToBoxAdapter(),

              // 商品标题
              _buildTitle(context).sliverToBoxAdapter(),

              // Tab 栏位
              _buildTabBar(context).sliverToBoxAdapter(),

              // TabView 视图
              SliverFillRemaining(hasScrollBody: true, child: _buildTabView()),
            ],
          );
  }

  // 底部按钮
  Widget _buildButtons(BuildContext context) {
    return <Widget>[
          // 加入购物车
          ButtonWidget.outline(
            LocaleKeys.gDetailBtnAddCart.tr,
            onTap: controller.onAddCartTap, // 加入购物车事件,
          ).expanded(),

          // 间距
          SizedBox(width: AppSpace.iconTextLarge),

          // 立刻购买
          ButtonWidget.primary(
            LocaleKeys.gDetailBtnBuy.tr,
            onTap: controller.onCheckoutTap, // 立刻购买事件
          ).expanded(),
        ]
        .toRow(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        )
        .paddingHorizontal(AppSpace.page);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
      init: ProductDetailsController(),
      id: "product_details",
      tag: tag,
      builder: (_) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          // 导航
          appBar: MainAppBarWidget(titleString: LocaleKeys.gDetailTitle.tr),
          // 内容
          body: SafeArea(
            child: <Widget>[
              SmartRefresher(
                onRefresh: controller.onMainRefresh, // 下拉刷新回调
                controller: controller.mainRefreshController,
                child: _buildView(context),
              ).paddingAll(AppSpace.page).expanded(),
              _buildButtons(context),
            ].toColumn(),
          ),
        );
      },
    );
  }
}
