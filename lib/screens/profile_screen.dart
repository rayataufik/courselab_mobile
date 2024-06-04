import 'package:courselab_mobile/screens/login_screen.dart';
import 'package:courselab_mobile/services/api_service.dart';
import 'package:courselab_mobile/services/local_storage.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  Future<void> _logout() async {
    await ApiService.logout();
    await LocalStorage().box.remove("token");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: ElevatedButton(
        onPressed: () {
          _logout();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        },
        child: Text("Logout"),
      ),
    ));
  }
}
