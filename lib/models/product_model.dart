class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String imageUrl;
  final List<String> sizes;
  final bool isNew;
  final bool isFeatured;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.sizes,
    this.isNew = false,
    this.isFeatured = false,
  });
}
