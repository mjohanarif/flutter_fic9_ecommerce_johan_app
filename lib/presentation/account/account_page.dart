import 'package:flutter/material.dart';
import 'package:flutter_fic9_ecommerce_johan_app/data/data_sources/auth_local_data_source.dart';
import 'package:flutter_fic9_ecommerce_johan_app/presentation/auth/login_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await AuthLocalDataSource().removeAuthData();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          },
          child: const Text(
            'Log out',
          ),
        ),
      ),
    );
  }
}
