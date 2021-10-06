import 'package:flutter/material.dart';
import './my_icon_button.dart';

class BookCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 8.0),
      child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: Column(children: [
            Container(
                height: 100,
                width: 100,
                child: FadeInImage(
                  placeholder: AssetImage('assets/images/t.library-logo.png'),
                  image: AssetImage(
                      'assets/images/t.library-logo.png'), // NetworkImage(''),
                )),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('book name', style: TextStyle(color: Colors.white))
                // child: Row(
                //   children: [
                //     Icon(Icons.star, color: Color(0xFFDF9D19), size: 20),
                //     Icon(Icons.star, color: Color(0xFFDF9D19), size: 20),
                //     Icon(Icons.star, color: Color(0xFFDF9D19), size: 20),
                //     Icon(Icons.star, color: Color(0xFFDF9D19), size: 20),
                //     Icon(Icons.star, color: Color(0xFFDF9D19), size: 20),
                //   ],
                // ),
                ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyIconButton(
                    icon: Icon(Icons.add_shopping_cart,
                        color: Colors.white, size: 22),
                    onTap: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('add to cart')));
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

                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('favorite')));
                      })
                ],
              ),
            )
          ])),
    );
  }
}
