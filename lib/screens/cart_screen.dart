import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../widgets/cart_item_card.dart';
import '../widgets/screens_background.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart-screen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Cart', style: TextStyle(color: Colors.white)),
      ),
      extendBodyBehindAppBar: true,
      body: ScreensBackground(
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
              trailing: Text('total \$'),
            ),
          ),
          Text(
            'Your Items:',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
          if (items.isEmpty)
            Container(
              height: 100,
              child: Center(
                child: Text('Start adding items to the Cart!',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ListView.builder(
            itemBuilder: (ctx, i) => CartItemCard(i + 1, items[i], () {
              setState(() {});
            }),
            itemCount: items.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      items.isEmpty ? Colors.grey : Colors.white)),
              onPressed: () {
                if (items.isNotEmpty) {
                  // Get.to(() => AddOrderScreen());
                } else {
                  // Get.snackbar('Warning', 'There is No items to Order!',
                  //     snackPosition: SnackPosition.BOTTOM);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.shopping_bag,
                        color: items.isNotEmpty ? Colors.white : null),
                    SizedBox(width: 10),
                    Text('Order Now!')
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
