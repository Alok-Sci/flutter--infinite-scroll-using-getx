// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_with_getx/controllers/product_controller.dart';

class InfiniteScrollView extends StatelessWidget {
  final productController = Get.put(ProductController());

  ScrollController scrollController = ScrollController();

  InfiniteScrollView() {
    productController.fetchProducts();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        productController.fetchProducts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'Infinite Scroll with GetX',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.teal.shade900),
        body: Obx(
          () => ListView.builder(
            itemCount: productController.productList.length,
            itemBuilder: (context, index) {
              final product = productController.productList[index];
              return Card(
                child: ListTile(
                  // leading: CircleAvatar(
                  //     backgroundImage: NetworkImage('${product.images}')),
                  title: Text('${product.title}'),
                  subtitle: Text('${product.description}'),
                  trailing: Icon(Icons.chevron_right_rounded),
                ),
              );
            },
          ),
        ));
  }
}
