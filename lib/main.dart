// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_with_getx/controllers/product_controller.dart';
import 'package:infinite_scroll_with_getx/views/product_view.dart';

void main() {
  /// * inject dependency [lazily put the ProductListController instance in the widget tree]
  Get.lazyPut(() => ProductListController());

  /// * run the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      /// * hide the debug banner
      debugShowCheckedModeBanner: false,
      home: ProductListView(),
      
      /// * configure the app theme
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal,
        ),
        indicatorColor: Colors.teal,
      ),
    );
  }
}
