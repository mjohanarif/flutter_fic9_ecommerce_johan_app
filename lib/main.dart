import 'package:flutter_fic9_ecommerce_johan_app/data/data_sources/auth_local_data_source.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/auth/bloc/login/login_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/cart/bloc/cart/cart_bloc.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/dashboard/dashboard_page.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/home/bloc/products/products_bloc.dart';

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
          create: (context) => ProductsBloc()
            ..add(
              const ProductsEvent.getAll(),
            ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
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
