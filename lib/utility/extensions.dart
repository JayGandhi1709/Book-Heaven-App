import 'package:book_heaven/core/data_provider.dart';
import 'package:book_heaven/screens/admin/carousel/carousel_services.dart';
import 'package:book_heaven/screens/admin/dashboard/dashboard_provider.dart';
import 'package:book_heaven/screens/auth/provider/user_provider.dart';
import 'package:get/get.dart';

// import '../screen/login_screen/provider/user_provider.dart';
// import '../screen/product_cart_screen/provider/cart_provider.dart';
// import '../screen/profile_screen/provider/profile_provider.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../core/data/data_provider.dart';
// import '../screen/product_by_category_screen/provider/product_by_category_provider.dart';
// import '../screen/product_details_screen/provider/product_detail_provider.dart';
// import '../screen/product_favorite_screen/provider/favorite_provider.dart';

extension Providers on BuildContext {
  UserProvider get userProvider => Get.put(UserProvider());
  DashboardProvider get dashboardProvider => Get.put(DashboardProvider());
  DataProvider get dataProvider => Get.put(DataProvider());
  CarouselServices get carouselServices =>
      Get.put(CarouselServices(dataProvider));
  // DataProvider get dataProvider => Provider.of<DataProvider>(this, listen: false);
  // ProductByCategoryProvider get proByCProvider => Provider.of<ProductByCategoryProvider>(this, listen: false);
  // ProductDetailProvider get proDetailProvider => Provider.of<ProductDetailProvider>(this, listen: false);
  // CartProvider get cartProvider => Provider.of<CartProvider>(this, listen: false);
  // FavoriteProvider get favoriteProvider => Provider.of<FavoriteProvider>(this, listen: false);
  // UserProvider get userProvider => Provider.of<UserProvider>(this, listen: false);
  // ProfileProvider get profileProvider => Provider.of<ProfileProvider>(this, listen: false);
}
