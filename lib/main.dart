import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/views/auth_or_home.dart';
import 'package:shop/views/cart_overview.dart';
import 'package:shop/views/orders_overview.dart';
import 'package:shop/views/product_detail.dart';
import 'package:shop/views/product_form.dart';
import 'package:shop/views/products_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList(),
          update: (ctx, auth, previous) {
            return ProductList(
              auth.token ?? '',
              auth.userId ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (_) => OrderList(),
          update: (ctx, auth, previous) {
            return OrderList(
              auth.token ?? '',
              auth.userId ?? '',
              previous?.items ?? [],
            );
          },
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: 'Lato',
        ),
        //home: ProductsOverview(),
        routes: {
          AppRoutes.AUTH_OR_HOME: (ctx) => AuthOrHome(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetail(),
          AppRoutes.CART: (ctx) => CartOverview(),
          AppRoutes.ORDERS: (ctx) => OrdersOverview(),
          AppRoutes.PRODUCTS: (ctx) => ProductsManager(),
          AppRoutes.PRODUCT_FORM: (ctx) => ProductForm(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
