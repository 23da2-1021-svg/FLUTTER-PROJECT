import 'cart_item_model.dart';

class OrderModel {
  final String id;
  final List<CartItemModel> items;
  final double total;
  final String status;
  final DateTime createdAt;
  final String deliveryAddress;

  const OrderModel({
    required this.id,
    required this.items,
    required this.total,
    required this.status,
    required this.createdAt,
    required this.deliveryAddress,
  });
}
