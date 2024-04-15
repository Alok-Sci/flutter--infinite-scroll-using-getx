// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_with_getx/views/product_view.dart';

main() => runApp(InfiniteScrollWithGetx());

class InfiniteScrollWithGetx extends StatelessWidget {
  const InfiniteScrollWithGetx({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: InfiniteScrollView(),
    );
  }
}
