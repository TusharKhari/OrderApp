import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class AddProductController extends ChangeNotifier {
  bool isLoading = false;
  List<TextEditingController> sizeList = [];
  List<TextEditingController> priceList = [];
  void addSizeAndPrice() {
    TextEditingController sizeController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    sizeList.add(sizeController);
    priceList.add(priceController);
    notifyListeners();
  }

  List<TextEditingController> extraPriceList = [];
  List<TextEditingController> extraNameList = [];
  void addExtraNameAndPrice() {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    extraNameList.add(nameController);
    extraPriceList.add(priceController);
    notifyListeners();
  }

  List<XFile> imageList = [];
  List<Uint8List> byteImageList = [];

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    imageList = await picker.pickMultiImage();
    for (var im in imageList) {
      var byte = await im.readAsBytes();
      byteImageList.add(byte);
    }
    notifyListeners();
  }

  void deleteImage({required int index}) {
    imageList.removeAt(index);
    byteImageList.removeAt(index);
    notifyListeners();
  }

  Map gatherData(
      {required String name,
      required String category,
      required String description}) {
    List priceL = [];
    List extraL = [];
    for (int i = 0; i < priceList.length; i++) {
      TextEditingController price = priceList[i];
      TextEditingController size = sizeList[i];
      var priceData = {"name": size.text, "price": price.text};
      priceL.add(priceData);
    }
    for (int i = 0; i < extraNameList.length; i++) {
      TextEditingController price = extraPriceList[i];
      TextEditingController name = extraNameList[i];
      var extraData = {"name": name.text, "price": price.text};
      extraL.add(extraData);
    }
    var data = {
      "name": name,
      "category": category,
      "description": description,
      "price": priceL,
      "extras": extraL,
    };
    return data;
  }

  Future<void> addProduct(
      {required String name,
      required String category,
      required String description}) async {
    List<String> imagesL = [];
    try {
      isLoading = true;
      notifyListeners();
      final storageRef = FirebaseStorage.instance.ref();

      for (var img in byteImageList) {
        final imagesRef = storageRef.child("products/${name} ${img.length}");
        var uploadTask = imagesRef.putData(img);
        uploadTask.snapshotEvents.listen((TaskSnapshot event) async {
          if (event.state == TaskState.success) {
            String url = await imagesRef.getDownloadURL();
            imagesL.add(url);
            if (imagesL.length == imageList.length) {
              Map data = gatherData(
                  name: name, category: category, description: description);
              var pho = {"photos": imagesL};
              data.addEntries(pho.entries);
              addProductToFireDb(data: data);
            }
          }
        });
      }
    } catch (e) {
       isLoading = false;
      notifyListeners();
      log("message $e");
    }
  }

  Future<void> addProductToFireDb({required Map data}) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference products = firestore.collection('products');
      log("messageeee");
      await products
          .add(data)
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
      log("message");
      print("final data $data");
       isLoading = false;
      notifyListeners();
    } catch (e) {
       isLoading = false;
      notifyListeners();
      print("_addProductToFireDbb $e");
    }
  }
}
