import 'dart:math';
import 'package:flutter/material.dart';

class ChangeColorApp extends StatefulWidget {
  const ChangeColorApp({super.key});

  @override
  State<ChangeColorApp> createState() => _ChangeColorAppState();
}

class _ChangeColorAppState extends State<ChangeColorApp> {
  Color bgColor = Colors.purple;
  String bgColorString = "Tím";

  final List<Color> listColor = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.pink
  ];

  final List<String> listColorString = [
    "Đỏ",
    "Xanh lá",
    "Xanh dương",
    "Tím",
    "Hồng",
  ];

  void _changeColor() {
    var rand = Random();
    var i = rand.nextInt(listColor.length);
    setState(() {
      bgColor = listColor[i];
      bgColorString = listColorString[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text(
          "Change Color App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.yellow,
        centerTitle: true, // Căn giữa tiêu đề
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Căn giữa theo chiều dọc
          children: [
            Text(
              bgColorString,
              style: const TextStyle(
                fontSize: 40, // Chữ to dễ nhìn
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _changeColor,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              child: const Text("Change Color"),
            ),
          ],
        ),
      ),
    );
  }
}