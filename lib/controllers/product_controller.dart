// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:infinite_scroll_with_getx/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductListController extends GetxController {
  Rx<ProductResponseModel?> productData = Rx<ProductResponseModel?>(null);

  /// * getter for getting product list if productData is null then assing empty list
  List<Product> productList = <Product>[];

  /// * reactive observable boolean false.
  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;

  /// * getters
  bool get hasError => errorMessage.value != "";
  bool get isLoadingMore => productList.isNotEmpty && isLoading.value;
  bool get isProductListEmpty => productList.isEmpty && !isLoading.value;

  /// * pagination variables
  int limit = 10;
  int get skip => productList.length;
  int get total => productData.value?.total ?? -1;

  @override
  void onInit() {
    /// * fetch product on memory allocation for controller
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    /// * early return if already loaded all the products  OR is already loading products
    if (total == productList.length || isLoading.value) return;

    /// * toggle the loading state
    isLoading.toggle();

    /// * handle Exeption
    try {
      /// * prepare the url
      Uri url =
          Uri.parse('https://dummyjson.com/products?limit=$limit&skip=$skip');

      /// * make a get request to prepared url
      final response = await http.get(url);

      /// * parse response body to the json
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      /// * parse json response to the ProductResponseModel object
      productData.value = ProductResponseModel.fromJson(jsonData);

      /// * add products to the existing list
      productList.addAll(productData.value!.products!);
    }

    /// * catch any exceptions
    catch (error, stackTrace) {
      /// * store the error message in the errorMessage state variable
      errorMessage.value = error.toString();
      log("Error: $error\n$stackTrace");
    }

    /// * at the end disable the loading
    finally {
      isLoading.toggle();
    }
  }
}
