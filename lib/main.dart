import 'package:flutter_fic9_ecommerce_johan_app/data/data_sources/auth_local_data_source.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/auth/bloc/login/login_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/cart/bloc/cart/cart_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/cart/bloc/get_cost/get_cost_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/cart/bloc/order/order_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/dashboard/dashboard_page.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/home/bloc/products/products_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/home/bloc/search_product/search_product_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/order/bloc/buyer_order/buyer_order_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/order/bloc/cek_resi/cek_resi_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/payment/bloc/order_detail/order_detail_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/shipping_address/bloc/add_address/add_address_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/shipping_address/bloc/city/city_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/shipping_address/bloc/get_address/get_address_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/shipping_address/bloc/province/province_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/shipping_address/bloc/subdistrict/subdistrict_bloc.dart';

import 'presentation/auth/bloc/register/register_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
        BlocProvider(
          create: (context) => OrderBloc(),
        ),
        BlocProvider(
          create: (context) => OrderDetailBloc(),
        ),
        BlocProvider(
          create: (context) => ProvinceBloc(),
        ),
        BlocProvider(
          create: (context) => CityBloc(),
        ),
        BlocProvider(
          create: (context) => SubdistrictBloc(),
        ),
        BlocProvider(
          create: (context) => AddAddressBloc(),
        ),
        BlocProvider(
          create: (context) => GetAddressBloc(),
        ),
        BlocProvider(
          create: (context) => GetCostBloc(),
        ),
        BlocProvider(
          create: (context) => BuyerOrderBloc(),
        ),
        BlocProvider(
          create: (context) => CekResiBloc(),
        ),
        BlocProvider(
          create: (context) => SearchProductBloc(),
        ),
        BlocProvider(
          create: (context) => ProductsBloc()
            ..add(
              const ProductsEvent.getAll(),
            ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: FutureBuilder(
          future: AuthLocalDataSource().isLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.data != null && snapshot.data!) {
              return const DashboardPage();
            } else {
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}
