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

  @override
  void onInit() {
    super.onInit();
    networkCaller = NetworkCaller();
    getData();
  }

  void getData() async {
    const String url = 'https://fakestoreapi.com/products';
    try {
      http.Response response = await networkCaller.getRequest(url);

      if (response.statusCode == 200) {
        debugPrint('Data fetched successfully: ${response.body}');
      } else {
        debugPrint('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }
  }
}
