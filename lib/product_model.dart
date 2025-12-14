class Product {
  int? id;
  String? title;
  num? price; 
  String? description;
  String? category;
  String? image;
  Rating? rating; // Đã bỏ comment để dùng được

  Product({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      category: json['category'],
      image: json['image'],
      // Lấy thông tin đánh giá sao
      rating: json['rating'] != null ? Rating.fromJson(json['rating']) : null,
    );
  }
}

class Rating {
  num? rate;  // Điểm số (ví dụ 4.5)
  int? count; // Số lượt đánh giá (ví dụ 100)

  Rating({this.rate, this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate'],
      count: json['count'],
    );
  }
}

