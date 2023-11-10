import 'package:flutter/material.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/components/menu_tile.dart';
import 'package:flutter_fic9_ecommerce_johan_app/common/constants/images.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
            leading: ClipRRect(
              child: Image.network(
                'https://www.greenscene.co.id/wp-content/uploads/2022/03/Luffy-9.jpg',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
            ),
            title: const Text('Johan'),
            subtitle: const Text('@JohanArif'),
          ),
          MenuTile(
            title: 'Email',
            value: 'Johan0@gmail.com',
            iconPath: Images.iconMessage,
            onTap: () {},
          ),
          MenuTile(
            title: 'No Handphone',
            value: '085808',
            iconPath: Images.iconPhone,
            onTap: () {},
          ),
          MenuTile(
            title: 'Ubah password',
            value: '*******',
            iconPath: Images.iconPassword,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
