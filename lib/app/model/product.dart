// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_application_1/app/model/ImageList.dart';
import 'package:flutter_application_1/app/model/image.dart';
import 'package:flutter_application_1/config/app.dart';
import 'package:flutter_application_1/utils/price.dart';

class Product {
  final int id;
  final ProductAttributes attributes;
  Product({
    required this.id,
    required this.attributes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'attributes': attributes.toMap(),
    };
  }

  String getImage() {
    return "https://" + HOST + (this.attributes.image.data?.attributes.url ?? "");
  }

  String getPrice() {
    if (this.attributes.promotional_price != null) {
      return formatPrice(this.attributes.promotional_price ?? 0);
    }
    else {
      return formatPrice(this.attributes.price ?? 0);
    }
  }

  String getOff() {
    if (this.attributes.promotional_price != null) {
      double off = ((this.attributes.price ?? 0) - (this.attributes.promotional_price ?? 0)) / (this.attributes.price ?? 1) * 100;
      return off.round().toString() + "% off";
    }
    else {
      return "0% off";
    }
  }

  List<Image>? getImages() {
    List<Image>? l = [];
    if (this.attributes.media != null) {
      // l = this.attributes.media?.data;
      for(var i = 0; i < (this.attributes.media?.data ?? []).length; i++) {
        // l.add(item);
        Image? c = this.attributes.media?.data[i] != null ? this.attributes.media?.data[i] as Image : null;
        print(c);
      }
    }
    else if (this.attributes.image != null) {
      l.add(this.attributes.image);
    }
    return l;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      attributes: ProductAttributes.fromMap(map['attributes'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ProductAttributes {
  final String name;
  final String slug;
  final String? description;
  final String? content;
  final double? price;
  final double? promotional_price;
  final Image image;
  final ImageList? media;
  final String createdAt;
  final String updatedAt;

  ProductAttributes({
    required this.name,
    required this.slug,
    this.description,
    this.content,
    this.price,
    this.promotional_price,
    required this.image,
    this.media,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'slug': slug,
      'description': description,
      'content': content,
      'price': price,
      'promotional_price': promotional_price,
      'image': image.toMap(),
      'media': media?.toMap(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory ProductAttributes.fromMap(Map<String, dynamic> map) {
    return ProductAttributes(
      name: map['name'] as String,
      slug: map['slug'] as String,
      description: map['description'] != null ? map['description'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      price: map['price'] != null ? map['price'] as double : null,
      promotional_price: map['promotional_price'] != null ? map['promotional_price'] as double : null,
      image: Image.fromMap(map['image'] as Map<String,dynamic>),
      media: map['media'] != null ? ImageList.fromMap(map['media'] as Map<String,dynamic>) : null,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductAttributes.fromJson(String source) => ProductAttributes.fromMap(json.decode(source) as Map<String, dynamic>);
}