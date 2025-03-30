class ProductResponseModel {
  List<Product>? products;
  int? total;
  int? skip;
  int? limit;

  ProductResponseModel({
    this.products,
    this.total,
    this.skip,
    this.limit,
  });

  /// * parse json to the ProductResponseModel object
  ProductResponseModel.fromJson(Map<String, dynamic> json) {
    products = (json['products'] as List).map((v) => Product.fromJson(v)).toList();
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  /// * convert to json for API usage
  Map<String, dynamic> toJson() => {
        'products': products?.map((v) => v.toJson()).toList(),
        'total': total,
        'skip': skip,
        'limit': limit,
      };
}

class Product {
  int? id;
  String? title;
  String? description;
  num? price;
  num? discountPercentage;
  num? rating;
  int? stock;
  String? brand;
  String? category;
  String? thumbnail;
  List<String>? images;

  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.brand,
    this.category,
    this.thumbnail,
    this.images,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    discountPercentage = json['discountPercentage'];
    rating = json['rating'];
    stock = json['stock'];
    brand = json['brand'];
    category = json['category'];
    thumbnail = json['thumbnail'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'discountPercentage': discountPercentage,
        'rating': rating,
        'stock': stock,
        'brand': brand,
        'category': category,
        'thumbnail': thumbnail,
        'images': images,
      };
}
