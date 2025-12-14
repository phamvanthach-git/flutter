import 'package:flutter/material.dart';
import 'classplace.dart';
import 'auth_screen.dart';
import 'change_color_app.dart';
import 'countdown_timer_app.dart';
import 'myhomepage.dart';
import 'news_list_screen.dart';
import 'bai1.dart';
import 'bai2.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'product_list_screen.dart';

// Widget helper để wrap màn hình với AppBar có nút quay về
class ScreenWrapper extends StatelessWidget {
  final Widget child;
  final String title;

  const ScreenWrapper({
    super.key,
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    // Nếu màn hình đã có Scaffold, chỉ cần đảm bảo có nút back
    // Flutter tự động thêm nút back khi dùng Navigator.push
    // Nhưng để chắc chắn, chúng ta wrap tất cả trong Scaffold có AppBar
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: child,
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  // Danh sách các bài tập
  List<Map<String, dynamic>> get exercises => [
    {
      'id': 1,
      'title': 'Bài 1: Màn hình Đăng Nhập',
      'description': 'Layout màn hình đăng nhập với Email và Mật khẩu',
      'screen': const LoginScreen(),
    },
    {
      'id': 2,
      'title': 'Bài 2: Màn hình Đăng Ký',
      'description': 'Layout màn hình đăng ký với 4 trường thông tin',
      'screen': const RegisterScreen(),
    },
    {
      'id': 3,
      'title': 'Bài 3: Danh sách chỗ nghỉ (Grid)',
      'description': 'Màn hình danh sách chỗ nghỉ dạng grid với header',
      'screen': const Bai1(),
    },
    {
      'id': 4,
      'title': 'Bài 4: Danh sách khách sạn (List)',
      'description': 'Màn hình danh sách khách sạn dạng list với đánh giá',
      'screen': const Bai2(),
    },
    {
      'id': 5,
      'title': 'Bài 5: Danh sách khóa học',
      'description': 'Layout danh sách khóa học với Column và Row',
      'screen': const ClassPlace(),
    },
    {
      'id': 6,
      'title': 'Bài 6: Đăng nhập/Đăng ký',
      'description': 'Màn hình đăng nhập và đăng ký với API',
      'screen': const AuthScreen(),
    },
    {
      'id': 7,
      'title': 'Bài 7: Ứng dụng đếm số',
      'description': 'Ứng dụng đếm số và đổi màu',
      'screen': CounterApp(),
    },
    {
      'id': 8,
      'title': 'Bài 8: Đếm ngược thời gian',
      'description': 'Ứng dụng đếm ngược timer',
      'screen': CountdownTimerApp(),
    },
    {
      'id': 9,
      'title': 'Bài 9: Trang chủ',
      'description': 'Màn hình trang chủ',
      'screen': const MyHomePage(),
    },
    {
      'id': 10,
      'title': 'Bài 10: Danh sách tin tức',
      'description': 'Hiển thị danh sách tin tức',
      'screen': const NewsListScreen(),
    },
    {
      'id': 11,
      'title': 'Bài 11: Danh sách sản phẩm điện tử',
      'description': 'Hiển thị danh sách sản phẩm từ API FakeStore',
      'screen': const ProductListScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Bài Tập'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12.0),
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  '${exercise['id']}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                exercise['title'] as String,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              subtitle: Text(
                exercise['description'] as String,
                style: const TextStyle(fontSize: 13.0),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
              onTap: () {
                // Chuyển đến màn hình bài tập tương ứng
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenWrapper(
                      title: exercise['title'] as String,
                      child: exercise['screen'] as Widget,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

