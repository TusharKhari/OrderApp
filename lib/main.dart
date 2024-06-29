import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:order_app/app.dart';
import 'package:order_app/firebase_options.dart';
 import 'package:provider/provider.dart';

import 'controller/add_product_controller.dart';
import 'controller/orders_controller.dart';
import 'screens/orders_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFb();
  runApp(const MyApp());
}

Future<void> initFb() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

