class CartItem {
  final int id;
  final String title;
  final int quantity;
  final int price;

  CartItem(
      {required this.id,
      required this.price,
      required this.quantity,
      required this.title});
}
