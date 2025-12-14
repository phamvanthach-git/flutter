import 'dart:async';
import 'package:flutter/material.dart';


class CountdownTimerApp extends StatefulWidget {
  CountdownTimerApp({super.key});

  @override
  State<CountdownTimerApp> createState() => _CountdownTimerAppState();
}

class _CountdownTimerAppState extends State<CountdownTimerApp> {
  TextEditingController _inputController = TextEditingController(text: '100');
  Timer? _timer;
  int _remainingSeconds = 100;
  int _initialSeconds = 100;
  bool _isRunning = false;

  @override
  void dispose() {
    _timer?.cancel();
    _inputController.dispose();
    super.dispose();
  }

  void _startCountdown() {
    // Lấy giá trị từ TextField
    int? inputValue = int.tryParse(_inputController.text);
    
    if (inputValue == null || inputValue <= 0) {
      // Hiển thị thông báo lỗi nếu giá trị không hợp lệ
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vui lòng nhập số hợp lệ (ví dụ: 100)'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _initialSeconds = inputValue;
      _remainingSeconds = inputValue;
      _isRunning = true;
    });

    // Hủy timer cũ nếu có
    _timer?.cancel();

    // Tạo timer mới đếm ngược mỗi giây
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          // Khi hết thời gian
          _isRunning = false;
          timer.cancel();
          _showTimeUpMessage();
        }
      });
    });
  }

  void _stopCountdown() {
    setState(() {
      _timer?.cancel();
      _isRunning = false;
      _remainingSeconds = _initialSeconds;
    });
  }

  void _showTimeUpMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.alarm, color: Colors.white),
            SizedBox(width: 10),
            Text('⏰ Hết thời gian!', style: TextStyle(fontSize: 18)),
          ],
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bộ đếm thời gian'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[50]!, Colors.white],
          ),
        ),
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
                "⏱ Bộ đếm thời gian",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 40),
            
            // Nhập số giây
            Text(
              "Nhập số giây cần đếm:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),
            Container(
              width: 200,
              child: TextField(
                controller: _inputController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                enabled: !_isRunning,
                style: TextStyle(fontSize: 24),
                decoration: InputDecoration(
                  hintText: 'Ví dụ: 100',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: _isRunning ? Colors.grey[200] : Colors.white,
                ),
              ),
            ),

            SizedBox(height: 40),

            // Hiển thị thời gian đếm ngược
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Text(
                _formatTime(_remainingSeconds),
                style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: _isRunning 
                      ? (_remainingSeconds <= 10 ? Colors.red : Colors.blue)
                      : Colors.grey,
                ),
              ),
            ),

            SizedBox(height: 40),

            // Nút điều khiển
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!_isRunning)
                  ElevatedButton.icon(
                    onPressed: _startCountdown,
                    icon: Icon(Icons.play_arrow),
                    label: Text(
                      "Bắt đầu",
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                
                if (_isRunning)
                  ElevatedButton.icon(
                    onPressed: _stopCountdown,
                    icon: Icon(Icons.stop),
                    label: Text(
                      "Dừng",
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(height: 20),

            // Hướng dẫn
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "📌 Hướng dẫn:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text("• Nhập số giây cần đếm (mặc định: 100)"),
                  Text("• Nhấn 'Bắt đầu' để bắt đầu đếm ngược"),
                  Text("• Khi hết thời gian sẽ hiển thị thông báo"),
                  Text("• Nhấn 'Dừng' để reset về giá trị ban đầu"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}