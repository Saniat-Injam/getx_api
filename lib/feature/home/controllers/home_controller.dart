import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api/feature/home/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:getx_api/core/services/network_caller.dart';

class HomeController extends GetxController {
  // NetworkCaller networkCaller = NetworkCaller();
  late NetworkCaller networkCaller;
  // NetworkCaller? networkCaller;

  List<ProductModel> products = [];
  List<String> categories = [];
  List<ProductModel> productsByCategories = [];

  bool isLoading = false;
  bool isLoadingCategory = false;
  bool isLoadingProductsByCategory = false;

  @override
  void onInit() {
    super.onInit();
    networkCaller = NetworkCaller();
    getCategories();
    getProducts();
  }

  void getProducts() async {
    const String url = 'https://fakestoreapi.com/products';
    try {
      isLoading = true;
      update();
      http.Response response = await networkCaller.getRequest(url);

      if (response.statusCode == 200) {
        debugPrint('Data fetched successfully: ${response.body}');
        var data = jsonDecode(response.body);
        for (int i = 0; i < data.length; i++) {
          products.add(ProductModel.fromJson(data[i]));
        }
        isLoading = false;
        update();
      } else {
        debugPrint('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }
  }

  void getCategories() async {
    const String endPoint = 'https://fakestoreapi.com/products/categories';

    try {
      isLoadingCategory = true;
      update();
      http.Response response = await networkCaller.getRequest(endPoint);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        for (int i = 0; i < data.length; i++) {
          categories.add(data[i]);
        }
        isLoadingCategory = false;
        update();
      } else {
        print("Something Wrong");
        isLoadingCategory = false;
        update();
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  void getProductsBycategory(String category) async {
    String endPoint = "https://fakestoreapi.com/products/$category";

    try {
      isLoadingProductsByCategory = true;

      update();
      http.Response response = await networkCaller.getRequest(endPoint);

      var data = jsonDecode(response.body);

      for (int i = 0; i < data.length; i++) {
        productsByCategories.add(ProductModel.fromJson(data[i]));
      }
      isLoadingProductsByCategory = false;

      update();
    } catch (e) {
      print(e);
      isLoadingProductsByCategory = false;

      update();
    }
  }
}
