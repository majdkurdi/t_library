import 'package:flutter/cupertino.dart';
import '../models/book.dart';
import '../models/cart_item.dart';

class CartNotifier extends ChangeNotifier {
  List<CartItem> cart = [];

  CartNotifier._internal();
  static CartNotifier? _instance;
  factory CartNotifier() {
    if (_instance == null) {
      _instance = CartNotifier._internal();
    }
    return _instance!;
  }

  Future addToCart(Book book) async {
    if (cart.any((element) => element.id == book.id)) {
      cart.firstWhere((element) => element.id == book.id).quantity++;
    } else {
      cart.add(CartItem.fromBook(book));
    }
    print(cart[0].title);
    notifyListeners();
  }

  Future removeFromCart(int bookId) async {
    if (cart.firstWhere((e) => e.id == bookId).quantity > 1) {
      cart.firstWhere((e) => e.id == bookId).quantity--;
    } else {
      cart.removeWhere((e) => e.id == bookId);
    }
    notifyListeners();
  }

  double get total {
    var tot = 0.0;
    cart.forEach((e) {
      tot += e.price * e.quantity;
    });
    return tot;
  }
}
