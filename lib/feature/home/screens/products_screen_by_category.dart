import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api/feature/home/controllers/home_controller.dart';
import 'package:getx_api/feature/home/models/product_model.dart';

class ProductsScreenByCategory extends StatelessWidget {
  String category = "";
  ProductsScreenByCategory({super.key, required this.category});

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: GetBuilder<HomeController>(
        builder: (_) {
          return homeController.isLoadingProductsByCategory
              ? CircularProgressIndicator(): GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: homeController.productsByCategories.length,
            itemBuilder: (context, index) {
              ProductModel product = homeController.productsByCategories[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.network(
                        product.image!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 8),
                      Text(
                        product.title!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Price: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                product.price.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.orange, size: 18),
                              Text(
                                product.rating!.rate.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
