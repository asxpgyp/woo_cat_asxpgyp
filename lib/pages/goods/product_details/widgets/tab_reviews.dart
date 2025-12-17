import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../common/index.dart';
import '../index.dart';

/// 评论
class TabReviewsView extends GetView<ProductDetailsController> {
  final String uniqueTag;

  const TabReviewsView({super.key, required this.uniqueTag});

  @override
  String? get tag => uniqueTag;

  // 评论图
  Widget _buildReviewImages() {
    return <Widget>[
      // 图
      for (var i = 0; i < controller.reviewImages.length; i++)
        ImageWidget.img(
          controller.reviewImages[i],
          width: 45.w,
          height: 45.w,
        ).onTap(() => controller.onReviewsGalleryTap(i)),
    ].toWrap(spacing: AppSpace.listItem, runSpacing: AppSpace.listRow);
  }

  // 列表项
  _buildListItem(ReviewModel item, int index) {
    return <Widget>[
      // 头像
      AvatarWidget.img(
        // item.reviewerAvatarUrls?["96"],
        // 测试需要改成自定义头像
        "https://ducafecat-pub.oss-cn-qingdao.aliyuncs.com/avatar/00258VC3ly1gty0r05zh2j60ut0u0tce02.jpg",
        size: 55,
        onTap: () {},
      ).paddingRight(AppSpace.listItem),

      // 星、名称、评论、图
      <Widget>[
        // 5 星
        // 星
        StarsListWidget(
          value: item.rating ?? 0,
          size: 20,
          onTap: (value) {
            controller.onStarTap(value, index);
          },
        ),
        // StarsListWidget(value: item.rating ?? 2, size: 12, onTap: (value) {}),
        // 名称、时间
        <Widget>[
          // 名称
          TextWidget.body(
            item.reviewer ?? "",
            weight: FontWeight.w500,
          ).expanded(),
          // 时间
          TextWidget.label(
            DateTime.parse(item.dateCreated ?? "").toString().split(" ")[0],
          ),
        ].toRow(),

        // 评论
        TextWidget.label(item.review?.clearHtml ?? ""),
        // 图
        _buildReviewImages(),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).expanded(),
    ].toRow(crossAxisAlignment: CrossAxisAlignment.start);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
      tag: tag,
      id: "product_reviews",
      builder: (_) {
        return SmartRefresher(
          // 刷新控制器
          controller: controller.reviewsRefreshController,
          // 启用上拉加载
          enablePullUp: true,
          // 下拉刷新回调
          onRefresh: controller.onReviewsRefresh,
          // 上拉加载回调
          onLoading: controller.onReviewsLoading,
          // 底部加载更多
          footer: const SmartRefresherFooterWidget(),
          // 分隔符、间距
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              var item = controller.reviews[index];
              return _buildListItem(item, index);
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: AppSpace.listRow * 2);
            },
            itemCount: controller.reviews.length,
          ),
        ).paddingVertical(AppSpace.page);
      },
    );
  }
}
