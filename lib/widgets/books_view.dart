import 'package:flutter/material.dart';
import './book_card.dart';

class BooksView extends StatelessWidget {
  final List<BookCard> children;
  final String title;
  BooksView({required this.children, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      // height: size.height / 3,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
          ),
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
              child: Text(
                '$title:',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
