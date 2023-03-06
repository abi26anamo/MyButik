import 'package:flutter/material.dart';
import 'package:flutternodeapp/common/widgets/loader.dart';
import 'package:flutternodeapp/constants/global_variables.dart';
import 'package:flutternodeapp/features/productdetails/product_detail_screen.dart';
import 'package:flutternodeapp/home/services/home_services.dart';
import 'package:flutternodeapp/models/product.dart';

class CatagoriesDeal extends StatefulWidget {
  static const routeName = '/category';
  final String category;
  const CatagoriesDeal({super.key, required this.category});

  @override
  State<CatagoriesDeal> createState() => _CatagoriesDealState();
}

class _CatagoriesDealState extends State<CatagoriesDeal> {
  HomeServices homeServices = HomeServices();
  List<Product>? products;
  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  void fetchAllProducts() async {
    products = await homeServices.fetchAllProducts(
      context: context,
      category: widget.category,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: products == null
          ? const Loader()
          : Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Keep shopping for ${widget.category}",
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ), // child: Badge(
                //   elevation: 0,
                //   badgeColor: Colors.white,
                //   badgeContent: Text(cartLen.toString()),
                //   child: const Icon(Icons.shopping_cart_outlined),
                // ),
                ),
                Container(
                  height: 170,
                  child: GridView.builder(
                      itemCount: products!.length,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 15),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1.4,
                        mainAxisSpacing: 1,
                      ),
                      itemBuilder: (context, index) {
                        final product = products![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, ProductDetailScreen.routeName,
                                arguments: product);
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                height: 130,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black12,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.network(
                                      product.images[0],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(
                                  left: 0,
                                  right: 5,
                                  top: 15,
                                ),
                                child: Text(
                                  product.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
    );
  }
}
