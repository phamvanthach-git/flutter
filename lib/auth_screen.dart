import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'profile_screen.dart'; // Import file Profile vừa tạo

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Biến để chuyển đổi giữa Đăng Nhập và Đăng Ký
  bool _isLoginMode = true; 
  bool _isLoading = false;

  // Controller cho các ô nhập liệu
  final TextEditingController _usernameController = TextEditingController(text: "emilys");
  final TextEditingController _passwordController = TextEditingController(text: "emilyspass");
  // Controller thêm cho phần Đăng ký
  final TextEditingController _emailController = TextEditingController(); 

  // --- HÀM ĐĂNG NHẬP ---
  Future<void> login() async {
    setState(() => _isLoading = true);
    final url = Uri.parse('https://dummyjson.com/auth/login');
    
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': _usernameController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final String token = data['accessToken'];

        if (mounted) {
          // Chuyển sang trang Profile
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen(token: token)),
          );
        }
      } else {
        _showMsg("Đăng nhập thất bại. Vui lòng kiểm tra lại!");
      }
    } catch (e) {
      _showMsg("Lỗi kết nối: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // --- HÀM ĐĂNG KÝ (Giả lập) ---
  Future<void> register() async {
    setState(() => _isLoading = true);
    final url = Uri.parse('https://dummyjson.com/users/add');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'firstName': _usernameController.text, // Tạm dùng ô username làm tên
          'password': _passwordController.text,
          'email': _emailController.text,
          'age': 25 // DummyJSON yêu cầu trường này
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _showMsg("Đăng ký thành công! Hãy đăng nhập ngay.");
        // Đăng ký xong thì chuyển về chế độ đăng nhập
        setState(() {
          _isLoginMode = true;
          _usernameController.text = ""; // Xóa trắng để nhập lại
          _passwordController.text = "";
        });
      } else {
        _showMsg("Đăng ký thất bại: ${response.body}");
      }
    } catch (e) {
      _showMsg("Lỗi: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLoginMode ? "Đăng Nhập" : "Đăng Ký Tài Khoản"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Ảnh logo hoặc icon cho đẹp
            Icon(
              _isLoginMode ? Icons.lock_open : Icons.person_add, 
              size: 80, color: Colors.blue
            ),
            const SizedBox(height: 20),

            // Ô nhập Username
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: "Username (Tên đăng nhập)",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 15),

            // Ô nhập Email (Chỉ hiện khi Đăng ký)
            if (!_isLoginMode) ...[
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 15),
            ],

            // Ô nhập Password
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Mật khẩu",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 25),

            // Nút bấm chính
            SizedBox(
              width: double.infinity,
              height: 50,
              child: _isLoading 
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _isLoginMode ? login : register,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: Text(
                      _isLoginMode ? "ĐĂNG NHẬP" : "ĐĂNG KÝ",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
            ),
            
            const SizedBox(height: 15),

            // Nút chuyển đổi chế độ
            TextButton(
              onPressed: () {
                setState(() {
                  _isLoginMode = !_isLoginMode; // Đảo ngược trạng thái
                });
              },
              child: Text(
                _isLoginMode 
                  ? "Chưa có tài khoản? Đăng ký ngay" 
                  : "Đã có tài khoản? Đăng nhập",
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}