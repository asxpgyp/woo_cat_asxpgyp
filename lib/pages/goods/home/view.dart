import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../common/index.dart';
import 'index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MainPageState();
}

class _MainPageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _HomeViewGetX();
  }
}

class _HomeViewGetX extends GetView<HomeController> {
  const _HomeViewGetX();

  // 导航栏
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      // 背景透明
      // backgroundColor: Colors.transparent,
      // 取消阴影
      // elevation: 0,
      // 标题栏左侧间距
      titleSpacing: AppSpace.listItem,
      // 搜索栏
      title:
          <Widget>[
                // 搜索
                IconWidget.icon(
                  Icons.search_outlined,
                  text: LocaleKeys.gHomeNewProduct.tr,
                  size: 24,
                  color: context.colors.scheme.outline,
                  onTap: (controller.onAppBarTap),
                ).expanded(),

                // 分割线
                SizedBox(
                  width: 1,
                  height: 18,
                  child: Container(color: context.colors.scheme.outline),
                ).paddingHorizontal(5),

                // 拍照
                IconWidget.icon(
                  Icons.camera_alt_outlined,
                  size: 24,
                  color: context.colors.scheme.outline,
                ),
              ]
              .toRow()
              .padding(left: 20, right: 10)
              .decorated(
                borderRadius: BorderRadius.circular(AppRadius.input),
                border: Border.all(
                  color: context.colors.scheme.outline,
                  width: 1,
                ),
              )
              .tight(height: 40.h, width: double.infinity)
              .paddingLeft(10),
      // 右侧的按钮区
      actions: [
        // 图标
        const IconWidget.svg(
              AssetsSvgs.pNotificationsSvg,
              size: 20,
              isDot: true, // 未读消息 小圆点
            )
            .unconstrained() // 去掉约束, appBar 会有个约束下来
            .padding(left: AppSpace.listItem, right: AppSpace.page),
      ],
    );
  }

  // 轮播广告
  Widget _buildBanner() {
    return GetBuilder<HomeController>(
          id: "home_banner",
          builder: (_) {
            return CarouselWidget(
              items: controller.bannerItems,
              currentIndex: controller.bannerCurrentIndex,
              onPageChanged: controller.onChangeBanner,
              height: 190.w,
            );
          },
        )
        .clipRRect(all: AppRadius.image)
        .sliverToBoxAdapter()
        .sliverPaddingHorizontal(AppSpace.page);
  }

  // 分类导航
  Widget _buildCategories() {
    return <Widget>[
          for (var i = 0; i < controller.categoryItems.length; i++)
            CategoryListItemWidget(
              category: controller.categoryItems[i],
              onTap: (categoryId) => controller.onCategoryTap(categoryId),
            ).paddingRight(AppSpace.listItem),
        ]
        .toListView(scrollDirection: Axis.horizontal)
        .height(90.w)
        .paddingVertical(AppSpace.listRow)
        .sliverToBoxAdapter()
        .sliverPaddingHorizontal(AppSpace.page);
  }

  // 推荐商品
  Widget _buildFlashSell() {
    return <Widget>[
          for (var i = 0; i < controller.flashShellProductList.length; i++)
            ProductItemWidget(
                  controller.flashShellProductList[i],
                  imgHeight: 117.w,
                  imgWidth: 120.w,
                )
                .constrained(width: 120.w, height: 170.w)
                .paddingRight(AppSpace.listItem),
        ]
        .toListView(scrollDirection: Axis.horizontal)
        .height(170.w)
        .paddingBottom(AppSpace.listRow)
        .sliverToBoxAdapter()
        .sliverPaddingHorizontal(AppSpace.page);
  }

  // 新商品
  Widget _buildNewSell() {
    return GetBuilder<HomeController>(
      id: "home_news_sell",
      builder: (_) {
        return SliverGrid(
              delegate: SliverChildBuilderDelegate((
                BuildContext context,
                int position,
              ) {
                var product = controller.newProductProductList[position];
                return ProductItemWidget(product, imgHeight: 170.w);
              }, childCount: controller.newProductProductList.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: AppSpace.listRow,
                crossAxisSpacing: AppSpace.listItem,
                childAspectRatio: 0.8,
              ),
            )
            .sliverPadding(bottom: AppSpace.page)
            .sliverPaddingHorizontal(AppSpace.page);
      },
    );
  }

  // 主视图
  Widget _buildView() {
    return controller.flashShellProductList.isEmpty ||
            controller.newProductProductList.isEmpty
        ? const PlaceholdWidget() // 占位图
        : CustomScrollView(
            slivers: [
              // 轮播广告
              _buildBanner(),

              // 分类导航
              _buildCategories(),
              // 推荐商品
              // 栏位标题
              controller.flashShellProductList.isNotEmpty
                  ? BuildListTitle(
                      title: LocaleKeys.gHomeFlashSell.tr,
                      subTitle: "03. 30. 30",
                      onTap: () => controller.onAllTap(true),
                    ).sliverToBoxAdapter().sliverPaddingHorizontal(
                      AppSpace.page,
                    )
                  : const SliverToBoxAdapter(),
              // list
              _buildFlashSell(),

              // 最新商品
              // 栏位标题
              controller.newProductProductList.isNotEmpty
                  ? BuildListTitle(
                      title: LocaleKeys.gHomeNewProduct.tr,
                      onTap: () => controller.onAllTap(false),
                    ).sliverToBoxAdapter().sliverPaddingHorizontal(
                      AppSpace.page,
                    )
                  : const SliverToBoxAdapter(),

              // list
              _buildNewSell(),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: Get.find<HomeController>(),
      id: "home",
      builder: (_) {
        // return Scaffold(
        //   body: Column(children: [_buildAppBar(context), _buildView()]),
        // );
        return Scaffold(
          appBar: _buildAppBar(context),
          body: SmartRefresher(
            controller: controller.refreshController,
            // 刷新控制器
            enablePullUp: true,
            // 启用上拉加载
            onRefresh: controller.onRefresh,
            // 下拉刷新回调
            onLoading: controller.onLoading,
            // 上拉加载回调
            // footer: const SmartRefresherFooterWidget(),
            // header: const SmartRefresherFooterWidget(),
            // 底部加载更多
            child: _buildView(),
          ),
        );
      },
    );
  }
}
