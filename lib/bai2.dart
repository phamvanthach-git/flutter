import 'package:flutter/material.dart';
import 'dart:math';

class Bai2 extends StatelessWidget {
  const Bai2({super.key}); // ✅ constructor const

  final List<Map<String, String>> hotels = const [
    {
      'name': 'aNhill Boutique',
      'location': 'Huế',
      'distance': '0.6',
      'ratingText': 'Xuất sắc',
      'reviews': '95 đánh giá',
      'roomType': '1 suite riêng tư',
      'price': 'US\$109',
      'image': 'assets/images/anhill.jpg',
    },
    {
      'name': 'An Nam Hue Boutique',
      'location': 'Cư Chinh',
      'distance': '0.9',
      'ratingText': 'Tuyệt hảo',
      'reviews': '34 đánh giá',
      'roomType': '1 phòng khách sạn',
      'price': 'US\$20',
      'image': 'assets/images/annam.jpg',
    },
    {
      'name': 'Huế Jade Hill Villa',
      'location': 'Cư Chinh',
      'distance': '1.3',
      'ratingText': 'Rất tốt',
      'reviews': '1 đánh giá',
      'roomType': '1 biệt thự nguyên căn',
      'price': 'US\$285',
      'image': 'assets/images/jadehill.jpg',
    },
    {
      'name': 'Êm Villa',
      'location': 'Huế',
      'distance': '1.7',
      'ratingText': 'Tốt',
      'reviews': '3 đánh giá',
      'roomType': '1 phòng tiêu chuẩn',
      'price': 'US\$75',
      'image': 'assets/images/emvilla.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final rand = Random();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Thanh trên cùng
          Container(
            padding: const EdgeInsets.only(top: 45, left: 12, right: 12, bottom: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 3)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.arrow_back, color: Colors.black87),
                    SizedBox(width: 6),
                    Text('Xung quanh vị trí hiện tại',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    Spacer(),
                    Text('23 thg 10 – 24 thg 10',
                        style: TextStyle(color: Colors.black54, fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    _TopButton(icon: Icons.sort, label: 'Sắp xếp'),
                    _TopButton(icon: Icons.tune, label: 'Lọc'),
                    _TopButton(icon: Icons.map, label: 'Bản đồ'),
                  ],
                ),
              ],
            ),
          ),

          // Danh sách nhà nghỉ
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: hotels.length,
                itemBuilder: (context, index) {
                  final h = hotels[index];
                  final score = (8 + rand.nextInt(3)) + rand.nextDouble();
                  final scoreStr = score.toStringAsFixed(1);
                  return _buildHotelCard(h, scoreStr, index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelCard(Map<String, String> h, String score, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 2))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh bên trái
            Stack(
              alignment: Alignment.topLeft,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    h['image'] ?? '',
                    width: 130,
                    height: index < 3 ? 130 : 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 130,
                        height: index < 3 ? 130 : 100,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported, size: 50),
                      );
                    },
                  ),
                ),
                // Nhãn "Bao bữa sáng"
                Container(
                  margin: const EdgeInsets.all(6),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green[700],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Bao bữa sáng',
                    style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),

            // Thông tin bên phải
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tên + tim
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          h['name'] ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      const Icon(Icons.favorite_border, size: 20, color: Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Sao + điểm + đánh giá
                  Row(
                    children: [
                      Row(
                        children: List.generate(
                          5,
                          (i) => const Icon(Icons.star, color: Colors.amber, size: 14),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.blue[700],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          score,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        h['ratingText'] ?? '',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '· ${h['reviews']}',
                        style: const TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Vị trí
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.grey, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        '${h['location']} · Cách bạn ${h['distance']} km',
                        style: const TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Loại phòng + giá
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              h['roomType'] ?? '',
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            const Text('1 giường', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            h['price'] ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const Text(
                            'Đã bao gồm thuế và phí',
                            style: TextStyle(color: Colors.black54, fontSize: 11),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const _TopButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.black87, size: 18),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

