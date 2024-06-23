// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:order_app/controller/add_product_controller.dart';
import 'package:provider/provider.dart';

import '../widgets/app_text_field.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  // TextEditingController Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("add product"), 
      ),
      floatingActionButton: IconButton(
          onPressed: () {
            context.read<AddProductController>().addProduct(
                name: nameController.text,
                category: categoryController.text,
                description: descriptionController.text);
          },
          icon: Icon(
            Icons.add,
            size: 40,
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            AppTextField(
              hintText: "Name",
              controller: nameController,
            ),
            AppTextField(
              hintText: "Category",
              controller: categoryController,
            ),
            AppTextField(
                controller: descriptionController, hintText: "Description"),
            Consumer<AddProductController>(
              builder: (context, value, child) {
                return value.isLoading
                    ? CircularProgressIndicator()
                    : Column(
                        children: [
                          ListView.builder(
                             physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: value.priceList.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Flexible(
                                      child: AppTextField(
                                          controller: value.sizeList[index],
                                          hintText: "size"),
                                    ),
                                    Flexible(
                                      child: AppTextField(
                                        controller: value.priceList[index],
                                        hintText: "cost",
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }),
                          TextButton(
                            onPressed: () {
                              value.addSizeAndPrice();
                            },
                            child: Text("add Size and cost"),
                          ),
                          // extras
                          ListView.builder( physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: value.extraNameList.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Flexible(
                                      child: AppTextField(
                                          controller:
                                              value.extraNameList[index],
                                          hintText: "name"),
                                    ),
                                    Flexible(
                                      child: AppTextField(
                                        controller: value.extraPriceList[index],
                                        hintText: "cost",
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }),
                          TextButton(
                            onPressed: () {
                              value.addExtraNameAndPrice();
                            },
                            child: Text("add extras"),
                          ),
                          Visibility(
                            visible: value.byteImageList.isNotEmpty,
                            child: SizedBox(
                              height: 120,
                              child: ListView.builder( physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: value.byteImageList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: GestureDetector(
                                        onLongPress: () {
                                          value.deleteImage(index: index);
                                        },
                                        child: Image.memory(
                                          value.byteImageList[index],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              await value.pickImage();
                            },
                            child: Text("Pick photos"),
                          ),
                        ],
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
