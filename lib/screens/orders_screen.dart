import 'package:flutter/material.dart';
import 'package:order_app/screens/add_product_screen.dart';
import 'package:provider/provider.dart';

import '../controller/orders_controller.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  void getData() {
    context.read<OrdersController>().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All orders"),actions: [
           IconButton(onPressed: () {
             Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddProductScreen(),));
           }, icon: const Icon(Icons.add_to_photos_sharp)), 
          const SizedBox(
            width: 70,
          ), 
        ],

      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Consumer<OrdersController>(
            builder: (context, providerValue, child) {
              return ListView.builder(
                itemCount: providerValue.ordersList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var item = providerValue.ordersList[index];
                  return Card(
                      color: item.status == 1
                          ? Colors.orange
                          : item.status == 2
                              ? Colors.yellow
                              : Colors.green,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // ImageNetwork(
                              //   image: item.photos?.first ?? "",
                              //   height: 99,
                              //   width: 99,
                              // ),
                              Container(
                                color: Colors.black,
                                height: 90,
                                width: 90,
                                child: Center(
                                  child: Text(
                                    "${item.tableNo}",
                                    style: const TextStyle(
                                        fontSize: 32, color: Colors.white),
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Text(item.name ?? ""),
                                  Text(item.description ?? ""),
                                ],
                              ),
                              Visibility(
                                visible: item.status != 3,
                                child: TextButton(
                                  onPressed: () {
                                    if (item.status != 3) {
                                      providerValue.updateStatus(
                                          index: index,
                                          status: (item.status ?? 0) + 1);
                                    }
                                  },
                                  child: Text(
                                      "Change Status to ${item.status == 1 ? "Preparing" : item.status == 2 ? "prepared" : ""}"),
                                ),
                              ),
                              Text(
                                  "Status :  ${item.status == 1 ? "ready To prepare" : item.status == 2 ? "preparing" : "Served"}"),
                            ],
                          ),
                          const Text("price"),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: item.price?.length ?? 0,
                            itemBuilder: (context, priceIdx) {
                              var price = item.price?[priceIdx];
                              return Visibility(
                                visible: price?.isAdded ?? false,
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: price?.isAdded ?? false,
                                      onChanged: (value) {
                                        // providerValue.selectPrice(
                                        //     index: index, priceIdex: priceIdx);
                                      },
                                    ),
                                    Column(
                                      children: [
                                        Text("${price?.name}"),
                                        Text("${price?.price}"),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const Text("extras"),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: item.extras?.length ?? 0,
                            itemBuilder: (context, extraIdx) {
                              var extra = item.extras?[extraIdx];
                              return Visibility(
                                visible: extra?.isAdded ?? false,
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: extra?.isAdded ?? false,
                                      onChanged: (value) {},
                                    ),
                                    Column(
                                      children: [
                                        Text("${extra?.name}"),
                                        Text("${extra?.price}"),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          Text("QTY : ${item.quantity}"),
                        ],
                      ));
                },
              );
            },
          )
        ],
      )),
    );
  }
}
