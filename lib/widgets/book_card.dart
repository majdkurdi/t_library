import 'package:flutter/material.dart';
import './my_icon_button.dart';
import '../models/book.dart';
import '../screens/book_details_screen.dart';

class BookCard extends StatelessWidget {
  final Book book;
  BookCard(this.book);
  @override
  Widget build(BuildContext context) {
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
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    child: FadeInImage(
                      fit: BoxFit.fill,
                      placeholder:
                          AssetImage('assets/images/t.library-logo.png'),
                      image: NetworkImage(book.image),
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
                      onTap: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('add to cart')));
                      },
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    MyIconButton(
                        icon: Icon(
                          Icons.favorite,
                          size: 22,
                          color: Theme.of(context).accentColor,
                        ),
                        onTap: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();

                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('favorite')));
                        })
                  ],
                ),
              )
            ])),
      ),
    );
  }
}
