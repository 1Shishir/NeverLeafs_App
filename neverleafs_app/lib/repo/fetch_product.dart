import 'package:dio/dio.dart';
import 'package:neverleafs_app/model/products.dart';
import 'package:neverleafs_app/query/fetch_product_query.dart';

Future<List<Products>> fetchProducts() async {
  const String storefrontUrl =
      'https://testmyappp.myshopify.com/api/2024-01/graphql.json';
  const String storefrontAccessToken = '441a6ef707ddbbab6b759389ef62722f';

  final Dio dio = Dio();

  try {
    final Response response = await dio.post(
      storefrontUrl,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'X-Shopify-Storefront-Access-Token': storefrontAccessToken,
        },
      ),
      data: {
        'query': fetchProductsQuery,
      },
    );

    if (response.statusCode == 200) {
      return ProductParser.parseProducts(response.data);
    }
    return [];
  } catch (e) {
    return [];
  }
}
