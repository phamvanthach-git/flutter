import 'package:dio/dio.dart';
import 'product_model.dart';

class ProductApi {
  final Dio _dio = Dio();

  // Lấy danh sách sản phẩm thuộc nhóm ĐIỆN TỬ
  Future<List<Product>> getElectronicsProducts() async {
    const String url = 'https://fakestoreapi.com/products/category/electronics';

    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Lỗi kết nối API: ${response.statusCode}');
      }
    } catch (e) {
      print('Có lỗi xảy ra: $e');
      return []; 
    }
  }
}

