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
           Navigator.pop(context); // Quay về login
        }
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hồ Sơ Chi Tiết")),
      backgroundColor: Colors.grey[100], // Màu nền nhẹ cho dễ nhìn Card
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

                      // --- PHẦN 2: THÔNG TIN CƠ BẢN ---
                      _buildSectionCard("Thông tin cơ bản", [
                        _infoRow(Icons.person, "Username", userData!['username']),
                        _infoRow(Icons.cake, "Tuổi / Giới tính", "${userData!['age']} / ${userData!['gender']}"),
                        _infoRow(Icons.calendar_today, "Ngày sinh", userData!['birthDate']),
                        _infoRow(Icons.water_drop, "Nhóm máu", userData!['bloodGroup']),
                        _infoRow(Icons.height, "Chiều cao / Cân nặng", "${userData!['height']} cm / ${userData!['weight']} kg"),
                      ]),

                      // --- PHẦN 3: LIÊN HỆ ---
                      _buildSectionCard("Liên hệ & Địa chỉ", [
                        _infoRow(Icons.email, "Email", userData!['email']),
                        _infoRow(Icons.phone, "Số điện thoại", userData!['phone']),
                        // Địa chỉ là một Object lồng nhau, cần truy cập sâu hơn
                        _infoRow(Icons.location_on, "Địa chỉ", "${userData!['address']['address']}"),
                        _infoRow(Icons.location_city, "Thành phố", "${userData!['address']['city']}, ${userData!['address']['state']}"),
                      ]),

                      // --- PHẦN 4: CÔNG VIỆC ---
                      _buildSectionCard("Công việc", [
                        _infoRow(Icons.work, "Công ty", userData!['company']['name']),
                        _infoRow(Icons.badge, "Chức vụ", userData!['company']['title']),
                        _infoRow(Icons.domain, "Phòng ban", userData!['company']['department']),
                      ]),

                      // --- PHẦN 5: TÀI CHÍNH / KHÁC ---
                      _buildSectionCard("Tài khoản & Ngân hàng", [
                        _infoRow(Icons.credit_card, "Số thẻ", userData!['bank']['cardNumber']),
                        _infoRow(Icons.calendar_view_day, "Hết hạn", userData!['bank']['cardExpire']),
                        _infoRow(Icons.monetization_on, "Loại tiền", userData!['bank']['currency']),
                        _infoRow(Icons.fingerprint, "User ID", "${userData!['id']}"),
                      ]),
                      
                      const SizedBox(height: 20),
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
        ),
        const SizedBox(height: 10),
        Text(
          "${userData!['firstName']} ${userData!['lastName']}",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          userData!['maidenName'] ?? "", // Tên thời con gái (nếu có)
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
            ...children, // Spread operator để đưa danh sách widget con vào
          ],
        ),
      ),
    );
  }

  // Widget con: Tạo một dòng thông tin (Icon - Label - Value)
  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  value,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}