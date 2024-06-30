 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../modles/product_model.dart';

class OrdersController extends ChangeNotifier {
  List<QueryDocumentSnapshot> ordersSnapShots = [];
  List<ProductModel> ordersList = [];
  Future<void> getData() async {
    Stream collectionStream =
        FirebaseFirestore.instance.collection('orders').orderBy("createdAt").snapshots();
    collectionStream.listen(
      (event) {
        var querySnapshots = event as QuerySnapshot<Map<String, dynamic>>;
        ordersSnapShots = querySnapshots.docs;
        ordersList.clear();
         for (var ordr in ordersSnapShots) {
           var json = ordr.data() as Map<String, dynamic>;
           var d = ProductModel.fromJson(json);
           ordersList.add(d);
           notifyListeners();
        }
      },
    );
  }

  Future<void> updateStatus({required int index,required int status, }) async {
    CollectionReference orders =
        FirebaseFirestore.instance.collection('orders');
   await orders.doc(ordersSnapShots[index].id).update({"status": status});
   }
}
