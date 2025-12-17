import 'package:get/get.dart';
import 'package:woo_2025_cat/pages/index.dart';
import 'names.dart';
import 'observers.dart';

class RoutePages {
  //历史记录
  static List<String> history = [];

  // 观察者
  static RouteObservers observer = RouteObservers();

  // 列表
  static List<GetPage> list = [
    // GetPage(
    //   name: RouteNames.cartApplyPromoCode,
    //   page: () => const ApplyPromoCodePage(),
    // ),
    GetPage(name: RouteNames.cartBuyDone, page: () => const BuyDonePage()),
    // GetPage(name: RouteNames.cartBuyNow, page: () => const BuyNowPage()),
    GetPage(name: RouteNames.cartCartIndex, page: () => const CartIndexPage()),
    GetPage(name: RouteNames.goodsCategory, page: () => const CategoryPage()),
    GetPage(name: RouteNames.goodsHome, page: () => const HomePage()),
    GetPage(
      name: RouteNames.goodsProductDetails,
      page: () => ProductDetailsPage(),
    ),
    GetPage(
      name: RouteNames.goodsProductList,
      page: () => const ProductListPage(),
    ),
    GetPage(name: RouteNames.myLanguage, page: () => const LanguagePage()),
    GetPage(name: RouteNames.myMyAddress, page: () => const MyAddressPage()),
    GetPage(name: RouteNames.myMyIndex, page: () => const MyIndexPage()),
    GetPage(
      name: RouteNames.myOrderDetails,
      page: () => const OrderDetailsPage(),
    ),
    GetPage(name: RouteNames.myOrderList, page: () => const OrderListPage()),
    GetPage(
      name: RouteNames.myProfileEdit,
      page: () => const ProfileEditPage(),
    ),
    GetPage(name: RouteNames.myTheme, page: () => const ThemePage()),
    GetPage(
      name: RouteNames.searchSearchFilter,
      page: () => const SearchFilterPage(),
    ),
    GetPage(
      name: RouteNames.searchSearchIndex,
      page: () => const SearchIndexPage(),
    ),
    GetPage(name: RouteNames.systemLogin, page: () => const LoginPage()),
    GetPage(
      name: RouteNames.systemMain,
      page: () => const MainPage(),
      binding: MainBinding(),
    ),
    GetPage(name: RouteNames.systemRegister, page: () => const RegisterPage()),
    GetPage(
      name: RouteNames.systemRegisterPin,
      page: () => const RegisterPinPage(),
    ),
    GetPage(name: RouteNames.systemSplash, page: () => const SplashPage()),
    GetPage(
      name: RouteNames.systemUserAgreement,
      page: () => const UserAgreementPage(),
    ),
    GetPage(name: RouteNames.systemWelcome, page: () => const WelcomePage()),
    GetPage(
      name: RouteNames.stylesStylesIndex,
      page: () => const StylesIndexPage(),
    ),
    GetPage(name: RouteNames.stylesText, page: () => const TextPage()),
    GetPage(name: RouteNames.stylesImage, page: () => const ImagePage()),
    GetPage(name: RouteNames.stylesIcon, page: () => const IconPage()),
    GetPage(name: RouteNames.stylesButtons, page: () => const ButtonsPage()),
    GetPage(name: RouteNames.stylesInputs, page: () => const InputsPage()),
    GetPage(name: RouteNames.stylesTextForm, page: () => const TextFormPage()),
    GetPage(name: RouteNames.stylesListTile, page: () => const ListTilePage()),
    GetPage(name: RouteNames.stylesCheckbox, page: () => const CheckboxPage()),
  ];
}
