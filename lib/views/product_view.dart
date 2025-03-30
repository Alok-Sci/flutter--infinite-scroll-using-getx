// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_with_getx/controllers/product_controller.dart';
import 'package:infinite_scroll_with_getx/models/product_model.dart';

/// 1. on scroll bottom, fetch more products.
/// 2. when productList is not empty and isLoading true, display circular indicator in the last item in listview

/// * GetView is a great way of quickly access your Controller without having to call Get.find() yourself
class ProductListView extends GetView<ProductListController> {
  /// * scroll controller [to handle scroll state, and to listen to]
  final ScrollController scrollController = ScrollController();

  ProductListView() {
    /// * add listenere to scrollController, whenever scroll to the bottom - fetch more products.
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        controller.fetchProducts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Infinite Scroll with GetX',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal.shade900,
      ),

      /// * using Obx, listen to the changes in reactive/observable variables
      body: Obx(
        /// * if initial load then display CircularProgressIndicator
        () => controller.isLoading.value && !controller.isLoadingMore
            ? const Center(
                child: CircularProgressIndicator(),
              )

            /// * if product list is empty then display "No products found", else display product list
            : controller.isProductListEmpty
                ? const Center(
                    child: Text("No products found"),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    controller: scrollController,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 10),

                    /// * if products are loading then create space for loading widget
                    itemCount: controller.productList.length +
                        (controller.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      /// * if the last widget and loading more products, display the loader at the end of the list
                      if (index == (controller.productList.length) &&
                          controller.isLoadingMore) {
                        return _buildLoadingMore();
                      }

                      /// * single product
                      final product = controller.productList[index];
                      return _buildProductListTile(product);
                    },
                  ),
      ),
    );
  }

  /// * build product list tile 
  Widget _buildProductListTile(Product product) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          '${product.thumbnail}',
          height: 100,
          width: 100,
        ),
      ),
      title: Text('${product.title}'),
      subtitle: Text(
        '${product.description}',
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
      ),
    );
  }

  /// * build loading more tile 
  Widget _buildLoadingMore() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(),
          ),
          SizedBox(width: 20),
          Text('Loading more products...'),
        ],
      ),
    );
  }
}
