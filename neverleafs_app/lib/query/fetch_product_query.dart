const String fetchProductsQuery = r'''
{
  products(first: 10) {
    edges {
      node {
        id
        title
        description
        featuredImage {
          url
          src
        }
        priceRange {
          minVariantPrice {
            amount
          }
        }
      }
    }
  }
}
''';
