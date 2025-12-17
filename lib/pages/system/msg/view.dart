import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class MsgPage extends GetView<MsgController> {
  const MsgPage({super.key});

  // 主视图
  Widget _buildView() {
    return const Center(child: Text("MsgPage"));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MsgController>(
      init: MsgController(),
      id: "msg",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("msg")),
          body: SafeArea(child: _buildView()),
        );
      },
    );
  }
}
