import 'package:flutter/material.dart';

class ClassPlace extends StatelessWidget {
  const ClassPlace({super.key});

  @override
  Widget build(BuildContext context) {
    final classList = [
      {
        'title': 'XML và ứng dụng - Nhóm 1',
        'code': '2025-2026.1.TIN4583.001',
        'students': 58,
        'image': 'images/class1.jpg',
      },
      {
        'title': 'Lập trình ứng dụng cho các t...',
        'code': '2025-2026.1.TIN4403.006',
        'students': 55,
        'image': 'images/class1.jpg',
      },
      {
        'title': 'Lập trình ứng dụng cho các t...',
        'code': '2025-2026.1.TIN4403.005',
        'students': 52,
        'image': 'images/class1.jpg',
      },
      {
        'title': 'Lập trình ứng dụng cho các t...',
        'code': '2025-2026.1.TIN4403.004',
        'students': 50,
        'image': 'images/class1.jpg',
      },
      {
        'title': 'Lập trình ứng dụng cho các t...',
        'code': '2025-2026.1.TIN4403.003',
        'students': 52,
        'image': 'images/class1.jpg',
      },
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardCount = classList.length;
        final cardHeight = (constraints.maxHeight - 16.0 * (cardCount + 1)) / cardCount;
        return Container(
          color: Colors.white,
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: cardCount,
            itemBuilder: (context, index) {
              final item = classList[index];
              return SizedBox(
                height: cardHeight > 0 ? cardHeight : 100,
                child: classCard(
                  title: item['title'] as String,
                  code: item['code'] as String,
                  students: item['students'] as int,
                  image: item['image'] as String,
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget classCard({
    required String title,
    required String code,
    required int students,
    required String image,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
          onError: (exception, stackTrace) {},
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          // Không gạch chân
                          decoration: TextDecoration.none,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(Icons.more_horiz, color: Colors.white70),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  code,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    decoration: TextDecoration.none,
                  ),
                ),
                const Spacer(),
                Text(
                  '$students học viên',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  }
