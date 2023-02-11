import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final String image;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      //id: map['id'] as int,
      id: map['id']?.toInt() ?? 0,
      //name: map['name'] as String,
      name: map['name'] ?? '',
      //description: map['description'] as String,
      description: map['description'] ?? '',
      //price: map['price'] as double,
      price: map['price']?.toDouble() ?? 0.0,
      //image: map['image'] as String,
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
  //factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));
}

  // {
  //       "id": 1,
  //       "name": "X-Salada",
  //       "description": "Lanche acompanha pão, hambúguer, mussarela, alface, tomate e maionese",
  //       "price": 15.0,
  //       "image": "https://assets.unileversolutions.com/recipes-v2/106684.jpg?imwidth=800"
  // },
