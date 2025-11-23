import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api/feature/home/models/product_model.dart';
import 'package:getx_api/feature/home/screens/product_details_screen.dart';
import 'package:getx_api/feature/home/screens/products_screen_by_category.dart';

import '../controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      //body: const Center(child: Text('Welcome to the Home Screen!')),
      // body: GetBuilder<HomeController>(
      //   builder: (_) {
      //     return ListView.builder(
      //       itemCount: homeController.products.length,
      //       itemBuilder: (context, index) {
      //         ProductModel product = homeController.products[index];
      //         return Card(
      //           child: ListTile(
      //             leading: Image.network(product.image!),
      //             title: Text(product.title!, overflow: TextOverflow.ellipsis),
      //             subtitle: Text(product.description!),
      //           ),
      //         );
      //       },
      //     );
      //   },
      // ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
            width: double.infinity,
            child: GetBuilder<HomeController>(
              builder: (_) {
                return homeController.isLoadingCategory
                    ? CircularProgressIndicator()
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: homeController.categories.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: InkWell(
                              onTap: () {
                                homeController.getProductsBycategory(
                                  homeController.categories[index],
                                );
                                Get.to(
                                  ProductsScreenByCategory(
                                    category: homeController.categories[index],
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.deepOrangeAccent,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
                                    ),
                                    child: Text(
                                      homeController.categories[index]
                                          .toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
          SizedBox(height: 10),

          Expanded(
            child: GetBuilder<HomeController>(
              builder: (_) {
                return homeController.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                          itemCount: homeController.products.length,
                          itemBuilder: (context, index) {
                            ProductModel product =
                                homeController.products[index];
                            return InkWell(
                              onTap: () {
                                Get.to(
                                  () => ProductDetailsScreen(product: product),
                                );
                              },
                              child: Card(
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
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                product.price.toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.orange,
                                                size: 18,
                                              ),
                                              Text(
                                                product.rating!.rate.toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
