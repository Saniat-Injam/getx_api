import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api/feature/home/models/product_model.dart';

import '../controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      //body: const Center(child: Text('Welcome to the Home Screen!')),
      body: GetBuilder<HomeController>(
        builder: (_) {
          return ListView.builder(
            itemCount: homeController.products.length,
            itemBuilder: (context, index) {
              ProductModel product = homeController.products[index];
              return Card(
                child: ListTile(
                  leading: Image.network(product.image!),
                  title: Text(product.title!, overflow: TextOverflow.ellipsis),
                  subtitle: Text(product.description!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
