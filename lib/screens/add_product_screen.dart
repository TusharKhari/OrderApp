// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:order_app/controller/add_product_controller.dart';
import 'package:order_app/utils/global_variables.dart';
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
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "Add Product",
          style: heading2,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Consumer<AddProductController>(
                builder: (context, value, child) {
                  return value.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                          color: primaryColor,
                        ))
                      : Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Visibility(
                              visible: value.byteImageList.isEmpty,
                              child: InkWell(
                                onTap: () async {
                                  await value.pickImage();
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: boxColor.withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: boxColor, width: 1)),
                                    height: 160,
                                    width: 160,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          "Upload Image",
                                          style: des3,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                            Visibility(
                              visible: value.byteImageList.isNotEmpty,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: boxColor)),
                                height: 160,
                                width: 160,
                                child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: value.byteImageList.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onLongPress: () {
                                          value.deleteImage(index: index);
                                        },
                                        child: Image.memory(
                                          value.byteImageList[index],
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    }),
                              ),
                            ),
                            SizedBox(
                              height: 12,
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
                                controller: descriptionController,
                                hintText: "Description"),
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
                                            hintText: "Size"),
                                      ),
                                      Flexible(
                                        child: AppTextField(
                                          controller: value.priceList[index],
                                          hintText: "Cost",
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                            TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(primaryColor),
                                  shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)))),
                              onPressed: () {
                                value.addSizeAndPrice();
                              },
                              child: Text(
                                "Add Size and cost",
                                style: des2,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: value.extraNameList.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Flexible(
                                        child: AppTextField(
                                          controller:
                                              value.extraNameList[index],
                                          hintText: "Name",
                                        ),
                                      ),
                                      Flexible(
                                        child: AppTextField(
                                          controller:
                                              value.extraPriceList[index],
                                          hintText: "Cost",
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                            TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(primaryColor),
                                  shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)))),
                              onPressed: () {
                                value.addExtraNameAndPrice();
                              },
                              child: Text(
                                "Add Extras",
                                style: des2,
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                          ],
                        );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: primaryColor,
              ),
              padding: EdgeInsets.all(10),
              child: TextButton(
                  onPressed: () {
                    context.read<AddProductController>().addProduct(
                        name: nameController.text,
                        category: categoryController.text,
                        description: descriptionController.text);
                  },
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(primaryColor),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)))),
                  child: Text(
                    "ADD PRODUCT",
                    style: heading2,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
