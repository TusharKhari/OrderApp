import 'package:flutter/material.dart';
import 'package:order_app/controller/add_product_controller.dart';
import 'package:order_app/controller/orders_controller.dart';
import 'package:order_app/screens/add_product_screen.dart';
import 'package:order_app/screens/orders_screen.dart';
import 'package:order_app/utils/global_variables.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
        builder: (context, child) => ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 767, name: MOBILE),
            const Breakpoint(start: 768, end: 1050, name: TABLET),
            const Breakpoint(start: 768, end: 1400, name: 'MINI_DESKTOP'),
            const Breakpoint(start: 1051, end: 1920, name: DESKTOP),
          ],
        ),
        title: 'Order Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MainScreen(),
        // home: AddProductScreen(),
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
    //
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    OrdersScreen(),
    AddProductScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: primaryColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list_alt,
            ),
            label: 'All Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Add More Products',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: backColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
