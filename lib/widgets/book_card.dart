import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './my_icon_button.dart';
import '../models/book.dart';
import '../notifiers/books_notifier.dart';
import '../notifiers/cart_notifier.dart';
import '../screens/book_details_screen.dart';

class BookCard extends StatelessWidget {
  final Book book;
  BookCard(this.book);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (ctx, watch, _) {
      final booksNotifier = watch(booksProvider);
      return Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => BookDetailsScreen(book)));
          },
          child: Container(
              // height: 170,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  border: Border.all(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Column(children: [
                Container(
                    height: 130,
                    width: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder:
                            AssetImage('assets/images/t.library-logo.png'),
                        image: NetworkImage(book.image),
                        placeholderErrorBuilder: (ctx, _, __) =>
                            Image.asset('assets/images/t.library-logo.png'),
                      ),
                    )),
                Expanded(
                  child: Center(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4),
                        child: Text(book.title,
                            style: TextStyle(color: Colors.white))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyIconButton(
                        icon: Icon(Icons.add_shopping_cart,
                            color: Colors.white, size: 22),
                        onTap: () async {
                          final res =
                              await context.read(cartProvider).addToCart(book);
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(res == 'error'
                                  ? 'error!'
                                  : 'book added to cart!')));
                        },
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      MyIconButton(
                          icon: Icon(
                            booksNotifier.favorites.contains(book)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 22,
                            color: Theme.of(context).accentColor,
                          ),
                          onTap: () {
                            booksNotifier.toggleFavorite(book);
                          })
                    ],
                  ),
                )
              ])),
        ),
      );
    });
  }
}
