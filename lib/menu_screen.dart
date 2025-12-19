import 'package:flutter/material.dart';
// Giả định các file này đã tồn tại và đúng tên class
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
import 'doimau.dart';
// Giả định CounterApp là class từ một file nào đó (ví dụ myhomepage.dart hoặc change_color_app.dart nếu bị trùng)
// Tôi sẽ giả định nó là một class riêng biệt tên CounterApp

// Widget helper để wrap màn hình với AppBar có nút quay về
class ScreenWrapper extends StatelessWidget {
  // Lỗi 1: Thêm lại trường child và title vào constructor
  final Widget child;
  final String title;

  const ScreenWrapper({
    super.key,
    required this.child,
    required this.title,
  });

  @override // Lỗi 1: Bổ sung phương thức build() bị thiếu
  Widget build(BuildContext context) {
    // Nếu màn hình đã có Scaffold, chỉ cần đảm bảo có nút back
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        // Nút back không cần thiết phải thêm thủ công nếu dùng Navigator.push
        // Nhưng nếu muốn giữ thì vẫn ổn. Tôi sẽ giữ theo logic cũ của bạn.
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
      'title': 'Bài 7: Ứng dụng Đổi màu nền',
      'description': 'Thay đổi màu nền màn hình một cách ngẫu nhiên.',
      // Lỗi 2: Bỏ 'const' vì ChangeColorApp là StatefulWidget (không phải hằng số)
      'screen': ChangeColorApp(), 
    },
    {
      'id': 8,
      'title': 'Bài 8: Ứng dụng đếm số',
      'description': 'Ứng dụng đếm số và đổi màu',
      // Lỗi 2: Bỏ 'const' vì CounterApp là StatefulWidget (tương tự)
      'screen': CounterApp(), 
    },
    {
      'id': 9,
      'title': 'Bài 9: Đếm ngược thời gian',
      'description': 'Ứng dụng đếm ngược timer',
      // Lỗi 2: Bỏ 'const' vì CountdownTimerApp là StatefulWidget (tương tự)
      'screen': CountdownTimerApp(), 
    },
    {
      'id': 10,
      'title': 'Bài 10: Trang chủ',
      'description': 'Màn hình trang chủ',
      'screen': const MyHomePage(),
    },
    {
      'id': 11,
      'title': 'Bài 11: Danh sách tin tức',
      'description': 'Hiển thị danh sách tin tức',
      'screen': const NewsListScreen(),
    },
    {
      'id': 12,
      'title': 'Bài 12: Danh sách sản phẩm điện tử',
      'description': 'Hiển thị danh sách sản phẩm từ API FakeStore',
      'screen': const ProductListScreen(),
    },
  ];

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFF7F8FA),

    // APPBAR CÓ NÚT ☰
    appBar: AppBar(
      title: const Text('Menu Bài Tập'),
      centerTitle: true,
    ),

    // 👉 MENU TRƯỢT Ở ĐÂY
    drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Danh sách bài tập',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),

          // 👇 ĐƯA DANH SÁCH BÀI TẬP VÀO DRAWER
          ...exercises.map((exercise) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  '${exercise['id']}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(exercise['title']),
              subtitle: Text(
                exercise['description'],
                style: const TextStyle(fontSize: 12),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () {
                Navigator.pop(context); // đóng drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ScreenWrapper(
                      title: exercise['title'],
                      child: exercise['screen'],
                    ),
                  ),
                );
              },
            );
          }).toList(), // ⚠️ BẮT BUỘC CÓ
        ],
      ),
    ),

    // BODY CHỈ ĐỂ HƯỚNG DẪN
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.menu_open, size: 50, color: Colors.blue),
          SizedBox(height: 12),
          Text(
            'Nhấn ☰ góc trên trái để mở menu',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    ),
  );
}

}
