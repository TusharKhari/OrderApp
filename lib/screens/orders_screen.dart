import 'package:flutter/material.dart';
import 'package:order_app/utils/global_variables.dart';
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
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "All orders",
          style: heading3,
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                 context.read<OrdersController>().moveToHistory();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.deepPurple, 
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: const Text("Move to History", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w500),),),
            ),
          ),
          Consumer<OrdersController>(
            builder: (context, providerValue, child) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: providerValue.ordersList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var item = providerValue.ordersList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(color: boxColor, width: 1)),
                        color: item.status == 1
                            ? const Color.fromARGB(255, 162, 100, 6)
                            : item.status == 2
                                ? const Color.fromARGB(255, 180, 163, 10)
                                : const Color.fromARGB(255, 36, 136, 39),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: borderColor.withOpacity(0.5),
                                      border: Border.all(color: borderColor),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    "TABLE ${item.tableNo}",
                                    style: heading2,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 25,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            border:
                                                Border.all(color: boxColor)),
                                        child: Text(
                                          "1",
                                          style: des2,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${item.name} x ${item.quantity}",
                                        style: heading2,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Price: ${item.totalPrice}",
                                    style: heading2,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Size: ",
                                style: des3,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: item.price?.length ?? 0,
                                itemBuilder: (context, priceIdx) {
                                  var price = item.price?[priceIdx];
                                  return Visibility(
                                    visible: price?.isAdded ?? false,
                                    child: Row(
                                      children: [
                                        Text(
                                          "${price?.name} (${price?.price})",
                                          style: des2,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Extras: ",
                                style: des3,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: item.extras?.length ?? 0,
                                itemBuilder: (context, extraIdx) {
                                  var extra = item.extras?[extraIdx];
                                  return Visibility(
                                    visible: extra?.isAdded ?? false,
                                    child: Text(
                                      "${extra?.name} (${extra?.price})",
                                      style: des2,
                                    ),
                                  );
                                },
                              ),
                              Visibility(
                                visible: item.status != 3,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all(backColor),
                                        shape: WidgetStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)))),
                                    onPressed: () {
                                      if (item.status != 3) {
                                        providerValue.updateStatus(
                                            index: index,
                                            status: (item.status ?? 0) + 1);
                                      }
                                    },
                                    child: Text(
                                      "Change Status to ${item.status == 1 ? "Preparing" : item.status == 2 ? "prepared" : ""}",
                                      style: des2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  );
                },
              );
            },
          )
        ],
      )),
    );
  }
}
