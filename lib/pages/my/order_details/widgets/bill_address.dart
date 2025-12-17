import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import '../../../../common/index.dart';

/// 订单地址项
class BuildBillAddress extends StatelessWidget {
  const BuildBillAddress({
    super.key,
    this.title,
    this.address,
    this.city,
    this.state,
    this.country,
    this.phone,
  });

  final String? title, address, city, state, country, phone;

  Widget _buildView() {
    return <Widget>[
      // title
      TextWidget.label(title ?? "").paddingBottom(AppSpace.listItem),

      // address
      IconWidget.icon(
        Icons.storefront,
        text: address,
      ).paddingBottom(AppSpace.listItem),

      // address, city, state, country
      IconWidget.icon(
        Icons.location_on_outlined,
        text: "$city, $state, $country",
        isExpanded: true,
      ).paddingBottom(AppSpace.listItem),

      // phone
      IconWidget.icon(Icons.phone_in_talk, text: phone),
    ].toColumn(crossAxisAlignment: CrossAxisAlignment.start);
  }

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }
}
