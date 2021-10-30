import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:t_library_package/notifiers/cart_notifier.dart';
import '../widgets/cart_item_card.dart';
import '../widgets/screens_background.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart-screen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (ctx, watch, _) {
      final cart = watch(cartProvider);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Cart', style: TextStyle(color: Colors.white)),
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            ScreensBackground(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 9),
                  Card(
                    margin: EdgeInsets.all(15),
                    child: ListTile(
                      leading: Icon(Icons.payment),
                      title: Text(
                        'Total Amount:',
                        textAlign: TextAlign.center,
                      ),
                      trailing: Text('${cart.total} \$'),
                    ),
                  ),
                  Text(
                    'Your Items:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  if (cart.cart.isEmpty)
                    Container(
                      height: 100,
                      child: Center(
                        child: Text('Start adding items to the Cart!',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.builder(
                      itemBuilder: (ctx, i) =>
                          CartItemCard(i + 1, cart.cart[i], () {
                        setState(() {});
                      }),
                      itemCount: cart.cart.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              cart.cart.isEmpty ? Colors.grey : Colors.white)),
                      onPressed: () async {
                        if (cart.cart.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('There is no books to order!')));
                        } else {
                          setState(() => loading = true);
                          final ordered = await cart.order();
                          setState(() => loading = false);
                          if (ordered) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Your Order has been submitted!')));
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.shopping_bag,
                                color: cart.cart.isEmpty ? null : Colors.black),
                            SizedBox(width: 10),
                            Text(
                              'Order Now!',
                              style: TextStyle(
                                  color:
                                      cart.cart.isEmpty ? null : Colors.black),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            if (loading)
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black.withOpacity(0.5),
                child: Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                )),
              )
          ],
        ),
      );
    });
  }
}
