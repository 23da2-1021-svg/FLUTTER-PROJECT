import 'product_model.dart';

class CartItemModel {
  final ProductModel product;
  final String selectedSize;
  int quantity;

  CartItemModel({
    required this.product,
    required this.selectedSize,
    this.quantity = 1,
  });

  double get totalPrice => product.price * quantity;
}
