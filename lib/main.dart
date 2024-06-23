import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
        //
        MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AddProductController(),
         ),
        ChangeNotifierProvider(
          create: (context) => OrdersController(),
         ), 
      ],
      child: MaterialApp(
        title: 'Order Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: OrdersScreen(),
        // home: AddProductScreen(),
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
    //
  }
}
 