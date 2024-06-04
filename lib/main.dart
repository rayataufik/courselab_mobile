import 'package:courselab_mobile/screens/login_screen.dart';
import 'package:courselab_mobile/screens/main_screen.dart';
import 'package:courselab_mobile/services/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LocalStorage().box.read("token") != null
          ? const MainScreen()
          : LoginPage(),
    );
  }
}
