import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../index.dart';

/// 配置服务
class ConfigService extends GetxService {
  // 这是一个单例写法
  static ConfigService get to => Get.find();

  // 包信息
  PackageInfo? _platform;

  // 版本号
  String get version => _platform?.version ?? '-';

  // 多语言
  Locale locale = PlatformDispatcher.instance.locale;

  // 默认主题
  AdaptiveThemeMode themeMode = AdaptiveThemeMode.light;

  // 是否首次打开
  bool get isAlreadyOpen => Storage().getBool(Constants.storageAlreadyOpen);

  // 初始化
  @override
  Future<void> onInit() async {
    super.onInit();
    await getPlatform();
    await initTheme();
    initLocale();
  }

  // 初始化
  // Future<ConfigService> init() async {
  //   await getPlatform();
  //   initLocale();
  //   return this;
  // }

  // 获取包信息
  Future<void> getPlatform() async {
    _platform = await PackageInfo.fromPlatform();
  }

  // 初始 theme
  Future<void> initTheme() async {
    final savedThemeMode = await AdaptiveTheme.getThemeMode();
    themeMode = savedThemeMode ?? AdaptiveThemeMode.light;
  }

  // 初始语言
  void initLocale() {
    var langCode = Storage().getString(Constants.storageLanguageCode);
    if (langCode.isEmpty) return;
    var index = Translation.supportedLocales.indexWhere((element) {
      return element.languageCode == langCode;
    });
    if (index < 0) return;
    locale = Translation.supportedLocales[index];
  }

  // 更改语言
  void setLanguage(Locale value) {
    locale = value;
    Get.updateLocale(value);
    Storage().setString(Constants.storageLanguageCode, value.languageCode);
  }

  // 切换 theme
  Future<void> setThemeMode(String themeKey) async {
    switch (themeKey) {
      case "light":
        AdaptiveTheme.of(Get.context!).setLight();
        break;
      case "dark":
        AdaptiveTheme.of(Get.context!).setDark();
        break;
      case "system":
        AdaptiveTheme.of(Get.context!).setSystem();
        break;
    }
    // 设置系统样式
    AppTheme.setSystemStyle();
  }

  // 切换主题
  void switchThemeMode() {
    // 品乓方式切换
    themeMode = themeMode == AdaptiveThemeMode.light
        ? AdaptiveThemeMode.dark
        : AdaptiveThemeMode.light;

    setThemeMode(themeMode.name);
  }

  // 标记已打开app
  void setAlreadyOpen() {
    Storage().setBool(Constants.storageAlreadyOpen, true);
  }
}
