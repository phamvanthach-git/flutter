import 'package:flutter/material.dart';
// Thay thế dòng import sai bằng dòng này:
import 'package:url_launcher/url_launcher.dart'; // Thư viện để mở URL
import 'model/product.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;
  
  const ArticleDetailScreen({super.key, required this.article});

  // Hàm mở URL trong trình duyệt
  void _launchUrl() async {
    final Uri uri = Uri.parse(article.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // Xử lý trường hợp không thể mở URL (ví dụ: in ra log)
      debugPrint('Could not launch ${article.url}');
      // Có thể hiển thị SnackBar thông báo cho người dùng
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title.length > 20 
          ? '${article.title.substring(0, 20)}...' 
          : article.title),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hiển thị Image
            article.urlToImage.isNotEmpty 
              ? Image.network(
                  article.urlToImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 150),
                )
              : const SizedBox.shrink(),
            
            const SizedBox(height: 16),
            
            // Tiêu đề
            Text(
              article.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const Divider(height: 32),

            // Nội dung chi tiết
            Text(
              article.content,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            
            const SizedBox(height: 24),
            
            // CHỨC NĂNG CHÍNH: Mở link bài viết gốc
            Center(
              child: ElevatedButton.icon(
                onPressed: article.url.isNotEmpty ? _launchUrl : null,
                icon: const Icon(Icons.open_in_browser),
                label: const Text('Đọc bài viết gốc trên Trình duyệt'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}