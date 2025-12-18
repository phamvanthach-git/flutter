import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  final String token;
  const ProfileScreen({super.key, required this.token});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  Future<void> getProfileData() async {
    final url = Uri.parse('https://dummyjson.com/auth/me');
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ${widget.token}'},
      );

      if (response.statusCode == 200) {
        setState(() {
          userData = jsonDecode(response.body);
          _isLoading = false;
        });
      } else {
        // Xử lý khi token hết hạn hoặc lỗi
        if (mounted) {
           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Lỗi tải dữ liệu!")));
           // Giữ nguyên logic quay về màn hình trước
           Navigator.pop(context); 
        }
      }
    } catch (e) {
      // Xử lý lỗi kết nối
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Thông tin User Chi tiết")),
      backgroundColor: Colors.grey[100], 
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : userData == null
              ? const Center(child: Text("Không có dữ liệu"))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // --- PHẦN 1: HEADER (AVATAR & TÊN) ---
                      _buildHeader(),
                      const SizedBox(height: 20),

                      // --- PHẦN 2: THÔNG TIN CƠ BẢN (Theo yêu cầu code 1) ---
                      _buildSectionCard("Thông tin cá nhân", [
                        _infoRow(Icons.vpn_key, "ID", "${userData!['id']}"),
                        _infoRow(Icons.person, "First Name", userData!['firstName']),
                        _infoRow(Icons.person_outline, "Last Name", userData!['lastName']),
                        // Dữ liệu 'maidenName' an toàn hơn
                        _infoRow(Icons.face, "Maiden Name", userData!['maidenName'] ?? 'N/A'),
                        _infoRow(Icons.cake, "Tuổi", "${userData!['age']}"),
                        _infoRow(Icons.transgender, "Giới tính", userData!['gender']),
                        _infoRow(Icons.calendar_today, "Ngày sinh", userData!['birthDate']),
                      ]),

                      // --- PHẦN 3: LIÊN HỆ (Theo yêu cầu code 1) ---
                      _buildSectionCard("Liên hệ", [
                        _infoRow(Icons.email, "Email", userData!['email']),
                        _infoRow(Icons.phone, "Phone", userData!['phone']),
                      ]),
                      
                      const SizedBox(height: 20),
                      // Nút Đăng Xuất
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.logout),
                          label: const Text("Đăng Xuất"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
    );
  }

  // Widget con: Hiển thị Header (Avatar to)
  Widget _buildHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(userData!['image']),
          backgroundColor: Colors.white,
          onBackgroundImageError: (_, __) {}, // Xử lý lỗi ảnh 
          child: (userData!['image'] == null) ? const Icon(Icons.person, size: 60) : null,
        ),
        const SizedBox(height: 10),
        Text(
          "${userData!['firstName']} ${userData!['lastName']}",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        // Giữ lại 'Maiden Name' ở đây nếu có
        Text(
          userData!['maidenName'] ?? "", 
          style: const TextStyle(fontSize: 16, color: Colors.grey, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  // Widget con: Tạo một cái Card bao quanh nhóm thông tin
  Widget _buildSectionCard(String title, List<Widget> children) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold, 
                color: Colors.blueAccent
              ),
            ),
            const Divider(),
            ...children, 
          ],
        ),
      ),
    );
  }

  // Widget con: Tạo một dòng thông tin (Icon - Label - Value)
  Widget _infoRow(IconData icon, String label, String value) {
    // Đảm bảo không hiển thị "null" nếu giá trị là null/chuỗi rỗng
    final displayValue = value.isNotEmpty ? value : "Không có";
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.blueGrey),
          const SizedBox(width: 12),
          SizedBox(
            width: 120, // Đặt chiều rộng cố định cho Label (giống code 1)
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
          ),
          Expanded(
            child: Text(
              displayValue,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}