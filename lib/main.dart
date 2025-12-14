import 'package:flutter/material.dart';
import 'menu_screen.dart'; // Import màn hình Menu

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menu Bài Tập',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MenuScreen(), // Chạy màn hình Menu đầu tiên
    );
  }
}