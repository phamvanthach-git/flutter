import 'dart:convert'; // Vẫn cần cho việc xử lý data nếu muốn, nhưng Dio tự parse được
import 'package:dio/dio.dart'; // Import thư viện Dio
import 'model/product.dart';

class ApiService {
  // API Key của bạn
  final String apiKey = '799e4f4b994f414c88f2690546447a20'; 
  
  // Base URL của NewsAPI
  final String baseUrl = 'https://newsapi.org/v2/top-headlines';

  // Khởi tạo Dio instance
  final Dio _dio = Dio();

  // Phương thức gọi API để lấy danh sách bài viết
  Future<List<Article>> fetchArticles(String country) async {
    try {
      // 1. Định nghĩa tham số truy vấn (query parameters)
      final Map<String, dynamic> queryParameters = {
        'country': country,
        'apiKey': apiKey,
        // Bạn có thể thêm các tham số khác như 'category', 'pageSize', etc.
      };

      // 2. Gửi yêu cầu GET
      final Response response = await _dio.get(
        baseUrl,
        queryParameters: queryParameters,
      );

      // 3. Kiểm tra mã trạng thái (Dio sẽ tự động ném lỗi nếu status code >= 400)
      if (response.statusCode == 200) {
        final data = response.data; // Dio tự động xử lý JSON thành Map/List

        // 4. Phân tích cú pháp dữ liệu
        if (data['articles'] is List) {
          return (data['articles'] as List)
              .map((item) => Article.fromJson(item))
              .toList();
        }
        return [];
      }
      
      // Nếu không phải 200, Dio có thể ném ra DioException, nhưng ta vẫn giữ logic này
      throw Exception('Server returned status code: ${response.statusCode}');

    } on DioException catch (e) {
      // Xử lý các lỗi từ Dio (ví dụ: lỗi mạng, timeout, lỗi 404/500)
      if (e.response != null) {
        // Lỗi từ server (ví dụ: lỗi 401, 403 do API Key)
        throw Exception('API Error: ${e.response?.statusCode} - ${e.response?.statusMessage}');
      } else {
        // Lỗi không có phản hồi (ví dụ: lỗi kết nối mạng)
        throw Exception('Network Error: ${e.message}');
      }
    } catch (e) {
      // Xử lý các lỗi khác
      throw Exception('An unknown error occurred: $e');
    }
  }
}