import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutternodeapp/common/widgets/custom_button.dart';
import 'package:flutternodeapp/common/widgets/custom_textfield.dart';
import 'package:flutternodeapp/constants/global_variables.dart';
import 'package:flutternodeapp/constants/utils.dart';
import 'package:flutternodeapp/features/admin/services/admin_services.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNamecontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();
  final TextEditingController pricecontroller = TextEditingController();
  final TextEditingController quantitycontroller = TextEditingController();
  final _addProductFormKey = GlobalKey<FormState>();
  final AdminServices adminServices = AdminServices();

  void sellProducts() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
          context: context,
          name: productNamecontroller.text,
          description: descriptioncontroller.text,
          price: double.parse(pricecontroller.text),
          category: category,
          quantity: double.parse(quantitycontroller.text),
          images: images);
    }
  }

  @override
  void dispose() {
    super.dispose();
    productNamecontroller.dispose();
    descriptioncontroller.dispose();
    pricecontroller.dispose();
    quantitycontroller.dispose();
  }

  String category = 'Mobiles';
  List<File> images = [];
  List<String> productCatagories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashions'
  ];
  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
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
            title: const Text(
              'Add products',
              style: TextStyle(color: Colors.black),
            )),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map(
                          (e) {
                            return Builder(
                              builder: (BuildContext context) => Image.file(
                                e,
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                            );
                          },
                        ).toList(),
                        options:
                            CarouselOptions(viewportFraction: 1, height: 200),
                      )
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Select Product images',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                    controller: productNamecontroller,
                    hintText: "Product Name"),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: descriptioncontroller,
                  hintText: "Description",
                  maxLines: 7,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: pricecontroller,
                  hintText: "Price",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: quantitycontroller,
                  hintText: "Quantity",
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    value: category,
                    items: productCatagories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        category = newVal!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  text: 'Sell',
                  onTap: sellProducts,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
