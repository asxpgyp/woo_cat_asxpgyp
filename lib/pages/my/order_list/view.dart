import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../common/index.dart';
import 'index.dart';

class OrderListPage extends GetView<OrderListController> {
  const OrderListPage({super.key});

  // 主视图
  Widget _buildView() {
    return CustomScrollView(
      slivers: [
        SliverList.separated(
          itemCount: controller.items.length,
          itemBuilder: (BuildContext context, int index) {
            OrderModel item = controller.items[index];
            return BuildOrderListItem(item: item)
                .onTap(() => controller.onOrderItemTap(item))
                .paddingBottom(AppSpace.listRow * 2);
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: AppSpace.listRow * 2);
          },
        ).sliverPadding(all: AppSpace.page),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderListController>(
      init: OrderListController(),
      id: "order_list",
      builder: (_) {
        return Scaffold(
          appBar: MainAppBarWidget(titleString: LocaleKeys.orderListTitle.tr),
          body: SafeArea(
            child: SmartRefresher(
              controller: controller.refreshController,
              // 刷新控制器
              enablePullUp: true,
              // 启用上拉加载
              onRefresh: controller.onRefresh,
              // 下拉刷新回调
              onLoading: controller.onLoading,
              // 上拉加载回调
              footer: const SmartRefresherFooterWidget(),
              // 底部加载更多
              child: _buildView(),
            ),
          ),
        );
      },
    );
  }
}
