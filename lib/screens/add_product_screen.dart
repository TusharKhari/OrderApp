// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_network/image_network.dart';
import 'package:order_app/controller/add_product_controller.dart';
import 'package:order_app/screens/image.dart';
import 'package:provider/provider.dart';

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
            // CachedNetworkImage(
            //   imageUrl:
            //       "https://firebasestorage.googleapis.com/v0/b/order-app-45dab.appspot.com/o/products%2Ffarm%20house%20468944?alt=media&token=93d7adfa-7295-48e9-9a9d-3a4f25bfcc64",
            // ),
          ImageNetwork(
            image: "https://firebasestorage.googleapis.com/v0/b/order-app-45dab.appspot.com/o/products%2Ffarm%20house%20468944?alt=media&token=93d7adfa-7295-48e9-9a9d-3a4f25bfcc64",
          height: 190,
          width: 200,
          ), 
            // SizedBox(
            //   height: 190,
            //   width: 200,
            //   child: MyImage(
            //     url:
            //         "https://firebasestorage.googleapis.com/v0/b/order-app-45dab.appspot.com/o/products%2Ffarm%20house%20468944?alt=media&token=93d7adfa-7295-48e9-9a9d-3a4f25bfcc64",
            //   ),
            // ),
            TextField(
              decoration: InputDecoration(hintText: "Name"),
              controller: nameController,
            ),
            TextField(
              decoration: InputDecoration(hintText: "Category"),
              controller: categoryController,
            ),
            TextField(
              decoration: InputDecoration(hintText: "Description"),
              controller: descriptionController,
            ),
            Consumer<AddProductController>(
              builder: (context, value, child) {
                return value.isLoading
                    ? CircularProgressIndicator()
                    : Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: value.priceList.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Flexible(
                                      child: TextField(
                                        decoration:
                                            InputDecoration(hintText: "size"),
                                        controller: value.sizeList[index],
                                      ),
                                    ),
                                    Flexible(
                                      child: TextField(
                                        decoration:
                                            InputDecoration(hintText: "cost"),
                                        controller: value.priceList[index],
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
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: value.extraNameList.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Flexible(
                                      child: TextField(
                                        decoration:
                                            InputDecoration(hintText: "name"),
                                        controller: value.extraNameList[index],
                                      ),
                                    ),
                                    Flexible(
                                      child: TextField(
                                        decoration:
                                            InputDecoration(hintText: "cost"),
                                        controller: value.extraPriceList[index],
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
                              child: ListView.builder(
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
