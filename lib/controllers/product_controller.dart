// ignore_for_file: avoid_print

import 'dart:convert' as convert;

import 'package:get/get.dart';
import 'package:infinite_scroll_with_getx/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  ProductData? productData;
  final List<Products> productList = <Products>[].obs;

  Future<void> fetchProducts() async {
    Uri url = Uri.parse('https://dummyjson.com/products?limit=10&skip=10');
    final response = await http.get(url);
    final jsonData = convert.jsonDecode(response.body) as Map<String, dynamic>;

    print(jsonData.runtimeType);

    productData = ProductData.fromJson(jsonData);
    print(productData);

    productList = [...productList, ..productData.products);
  }
}
