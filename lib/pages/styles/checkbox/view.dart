import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woo_2025_cat/common/index.dart';

import 'index.dart';

class CheckboxPage extends GetView<CheckboxController> {
  const CheckboxPage({super.key});

  // 主视图
  Widget _buildView() {
    return CheckboxWidget(
      checked: controller.checked,
      title: "Typography",
      description:
          "There are three display styles in the default type scale: Large, medium, and small. As the largest text on the screen, display styles are reserved for short, important text or numerals. They work best on large screens.",
      onChanged: controller.onChanged,
    ).paddingAll(AppSpace.page);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckboxController>(
      init: CheckboxController(),
      id: "checkbox",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("checkbox")),
          body: SafeArea(child: _buildView()),
        );
      },
    );
  }
}
