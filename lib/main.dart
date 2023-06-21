import 'package:ecommerce_app/Screens/DashBoard/bloc/dashboard_bloc.dart';
import 'package:ecommerce_app/Screens/DashBoard/dash_board.dart';
import 'package:ecommerce_app/model/cart_model/cart.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/repo/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter<Product>(
      ProductAdapter()); // Register the ProductAdapter
  Hive.registerAdapter<Cart>(CartAdapter()); // Register the ProductAdapter

  await Hive.openBox<Product>('products');
  await Hive.openBox<Cart>('cart');
  // Open Hive box for products

  await ProductRepository.addPreAddedProducts();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.transparent,
          textTheme: GoogleFonts.mulishTextTheme(),
          // colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF676767)),
          useMaterial3: false,
        ),
        home: BlocProvider(
          create: (context) => DashboardBloc(),
          child: DashBoardPage(),
        ));
  }
}
