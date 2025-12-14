import 'dart:math';
import 'package:flutter/material.dart';

class CounterApp extends StatefulWidget {
  CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ứng dụng Đếm Số"),
        backgroundColor: Colors.blue,
      ),
      body: myBody(),
    );
  }

  int counterValue = 0;
  Color bgColor = Colors.white;
  Color numberColor = Colors.red;
  
  List<Map<String, Color>> listColors = [
    {'bg': Colors.red[100]!, 'number': Colors.red[700]!},
    {'bg': Colors.green[100]!, 'number': Colors.green[700]!},
    {'bg': Colors.blue[100]!, 'number': Colors.blue[700]!},
    {'bg': Colors.purple[100]!, 'number': Colors.purple[700]!},
    {'bg': Colors.orange[100]!, 'number': Colors.orange[700]!},
    {'bg': Colors.pink[100]!, 'number': Colors.pink[700]!},
    {'bg': Colors.yellow[100]!, 'number': Colors.yellow[900]!},
    {'bg': Colors.teal[100]!, 'number': Colors.teal[700]!},
    {'bg': Colors.indigo[100]!, 'number': Colors.indigo[700]!},
  ];

  void _changeColorRandom() {
    var rand = Random();
    var index = rand.nextInt(listColors.length);
    setState(() {
      bgColor = listColors[index]['bg']!;
      numberColor = listColors[index]['number']!;
    });
  }

  void _decreaseCounter() {
    if (counterValue > 0) {
      setState(() {
        counterValue--;
      });
      _changeColorRandom();
    }
  }

  void _resetCounter() {
    setState(() {
      counterValue = 0;
      bgColor = Colors.white;
      numberColor = Colors.red;
    });
  }

  void _increaseCounter() {
    setState(() {
      counterValue++;
    });
    _changeColorRandom();
  }

  Widget myBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: bgColor),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Ứng dụng Đếm Số",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 40),
            Text(
              "Giá trị hiện tại:",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "$counterValue",
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: numberColor,
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _decreaseCounter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text(
                    "Giảm",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetCounter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text(
                    "Đặt lại",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _increaseCounter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text(
                    "Tăng",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}