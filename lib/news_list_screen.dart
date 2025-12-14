import 'package:flutter/material.dart';
import '../model/product.dart';
import '../api.dart';
import 'article_detail_screen.dart'; // Import màn hình chi tiết

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  // Khởi tạo Future để lấy danh sách bài viết
  late Future<List<Article>> _articlesFuture;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    // Gọi API khi màn hình được tạo
    _articlesFuture = _apiService.fetchArticles('us'); // Ví dụ lấy tin tức Mỹ
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tin Tức Hàng Đầu'),
        backgroundColor: Colors.blueGrey,
      ),
      body: FutureBuilder<List<Article>>(
        future: _articlesFuture,
        builder: (context, snapshot) {
          // 1. TRẠNG THÁI CHỜ (LOADING)
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } 
          // 2. TRẠNG THÁI LỖI
          else if (snapshot.hasError) {
            return Center(child: Text('Đã xảy ra lỗi: ${snapshot.error}'));
          } 
          // 3. TRẠNG THÁI DỮ LIỆU CÓ SẴN
          else if (snapshot.hasData) {
            final List<Article> articles = snapshot.data!;
            if (articles.isEmpty) {
              return const Center(child: Text('Không tìm thấy bài viết nào.'));
            }
            
            // Hiển thị danh sách bài viết
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return _buildArticleItem(context, article);
              },
            );
          } 
          // 4. TRẠNG THÁI KHÁC (Chưa có dữ liệu)
          else {
            return const Center(child: Text('Không có dữ liệu.'));
          }
        },
      ),
    );
  }

  // Widget riêng để xây dựng mỗi mục tin tức
  Widget _buildArticleItem(BuildContext context, Article article) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        onTap: () {
          // CHỨC NĂNG CHÍNH: Nhấn vào bài viết -> chuyển sang màn hình chi tiết
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleDetailScreen(article: article),
            ),
          );
        },
        // Hiển thị Thumbnail
        leading: article.urlToImage.isNotEmpty 
          ? Image.network(
              article.urlToImage,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 80),
            )
          : const Icon(Icons.image_not_supported, size: 80),
        
        title: Text(
          article.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        // Hiển thị Mô tả ngắn
        subtitle: Text(
          article.description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}