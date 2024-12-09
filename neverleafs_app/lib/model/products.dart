import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'products.freezed.dart';
part 'products.g.dart';

@freezed
class Products with _$Products {
  const factory Products({
    required String id,
    String? title,
    String? description,
    double? price,
    String? imageUrl,
  }) = _Products;

  factory Products.fromJson(Map<String, Object?> json) =>
      _$ProductsFromJson(json);
}

extension ProductParser on Products {
  static List<Products> parseProducts(Map<String, dynamic> data) {
    final productEdges = data['data']?['products']?['edges'] as List<dynamic>?;

    if (productEdges == null) {
      return [];
    }

    return productEdges
        .map((edge) {
          final node = edge['node'] as Map<String, dynamic>?;

          if (node == null) {
            return null;
          }

          return Products(
            id: node['id'] ?? '',
            title: node['title'] ?? 'Unknown Title',
            description: node['description'] ?? 'No description available',
            price: double.tryParse(node['priceRange']?['minVariantPrice']
                        ?['amount'] ??
                    '0.0') ??
                0.0,
            imageUrl: node['featuredImage']?['url'] ?? '',
          );
        })
        .whereType<Products>()
        .toList();
  }
}
