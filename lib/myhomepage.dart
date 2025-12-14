import 'package:flutter/material.dart'; 
// Nhập thư viện Material để dùng các widget của Flutter.

class MyHomePage extends StatelessWidget { 
  // Định nghĩa một class giao diện, kế thừa StatelessWidget (không thay đổi trạng thái).

  const MyHomePage({super.key}); 
  // Constructor, nhận key nếu cần.

  @override
  Widget build(BuildContext context) { 
    // Hàm build, trả về giao diện khi widget được dựng.
    return Scaffold(
      body: myBody(), 
      // Scaffold là khung giao diện cơ bản, body là phần nội dung chính.
    );
  }


  Widget myBody() {
    return Column(
      children: [
        buildImageSection(),
        buildTitleSection(),
        buildButtonSection(),
        buildDescriptionSection(),
      ],
    );
  }

  // 1. Ảnh lớn phía trên
  Widget buildImageSection() {
    return Image.asset(
      "images/anh1.jpg",
      width: double.infinity,
      height: 240,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        // Nếu không load được thì hiển thị placeholder
        return Container(
          width: double.infinity,
          height: 240,
          color: Colors.grey[300],
          child: const Icon(
            Icons.image_not_supported,
            size: 80,
            color: Colors.grey,
          ),
        );
      },
    );
  }

  // 2. Tiêu đề, địa điểm, sao và điểm
  Widget buildTitleSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Oeschinen Lake Campground",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 8),
                Text(
                  "Kandersteg, Switzerland",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          Icon(Icons.star, color: Colors.red),
          Text("41"),
        ],
      ),
    );
  }

  // 3. Hàng nút chức năng
  Widget buildButtonSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButton(Icons.call, "CALL"),
          buildButton(Icons.near_me, "ROUTE"),
          buildButton(Icons.share, "SHARE"),
        ],
      ),
    );
  }

  // 4. Đoạn mô tả
  Widget buildDescriptionSection() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Text(
        "Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.",
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.justify,
      ),
    );
  }

  // Hàm tạo nút chức năng
  Widget buildButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        SizedBox(height: 8),
        Text(label, style: TextStyle(color: Colors.blue)),
      ],
    );
  }
}
