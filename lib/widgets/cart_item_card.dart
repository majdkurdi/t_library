import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_item.dart';
import '../notifiers/cart_notifier.dart';

class CartItemCard extends StatelessWidget {
  final int index;
  final CartItem item;
  final Function function;
  CartItemCard(this.index, this.item, this.function);
  final cartPrivider =
      ChangeNotifierProvider<CartNotifier>((ref) => CartNotifier());
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: GlobalKey(),
      onDismissed: (_) {
        context.read(cartPrivider).removeFromCart(item.id);
        function();
      },
      direction: DismissDirection.endToStart,
      child: Card(
        child: ListTile(
          leading: Text('$index',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          title: Text(item.title),
          trailing: Text('${item.price}\$   X${item.quantity}'),
        ),
      ),
    );
  }
}
