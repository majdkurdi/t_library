import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:t_library_package/models/cart_item.dart';
import 'package:t_library_package/notifiers/cart_notifier.dart';

class CartItemCard extends StatelessWidget {
  final int index;
  final CartItem item;
  final Function function;
  CartItemCard(this.index, this.item, this.function);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: GlobalKey(),
      onDismissed: (_) {
        context.read(cartProvider).removeFromCart(item.id);
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
