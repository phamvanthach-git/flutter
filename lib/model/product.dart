class Article {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String content;

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      // NewsAPI có thể trả về null, nên cần kiểm tra và cung cấp giá trị mặc định
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? 'https://via.placeholder.com/150',
      content: json['content'] ?? 'Full content not available.',
    );
  }
}