import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'product_api.dart';
import 'product_model.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductApi api = ProductApi();
  late Future<List<Product>> _futureProducts;

  @override
  void initState() {
    super.initState();
    _futureProducts = api.getElectronicsProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách sản phẩm điện tử"),
        backgroundColor: const Color.fromARGB(255, 92, 92, 92), // Màu xám
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200], // Nền xám nhạt
      body: FutureBuilder<List<Product>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.orange));
          } else if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return buildShopeeGrid(snapshot.data!);
          } else {
            return const Center(child: Text("Không có sản phẩm"));
          }
        },
      ),
    );
  }

  Widget buildShopeeGrid(List<Product> list) {
    return GridView.builder(
      padding: const EdgeInsets.all(5),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7, // Tỷ lệ cao/rộng để đủ chỗ chứa thông tin
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
      ),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return itemShopee(list[index]);
      },
    );
  }

  Widget itemShopee(Product p) {
    final formatCurrency = NumberFormat.currency(locale: "en_US", symbol: "\$");

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Ảnh sản phẩm
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  p.image ?? '', 
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_not_supported, size: 50);
                  },
                ),
              ),
            ),
          ),
          // 2. Thông tin
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.title ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 4),
                // Giá tiền + Rating nằm cùng 1 hàng hoặc tách ra tùy độ dài
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formatCurrency.format(p.price ?? 0),
                      style: const TextStyle(
                          color: Color(0xFFfe5722),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    // Hiển thị Rating (Sao + Số lượng)
                    Row(
                      children: [
                        const Icon(Icons.star, size: 12, color: Colors.amber),
                        const SizedBox(width: 2),
                        Text(
                          "${p.rating?.rate ?? 0}",
                          style: const TextStyle(fontSize: 11),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "Đã bán ${p.rating?.count ?? 0}",
                          style: const TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

