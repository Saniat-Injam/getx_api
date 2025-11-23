import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api/feature/home/models/product_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductModel product;
  ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0.0),
      body: Container(
        child: Column(
          children: [
            Image.network(product.image!, width: Get.width, height: 100),
          ],
        ),
      ),
    );
  }
}
