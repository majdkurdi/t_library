import 'package:flutter/material.dart';
import './book_card.dart';
import '../models/book.dart';

class BooksView extends StatelessWidget {
  final List<Book> books;
  final String title;
  BooksView({required this.books, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width - 30,
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
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: Text(
              '$title:',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Container(
            height: 220,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ListView.builder(
                    itemBuilder: (ctx, i) => BookCard(books[i]),
                    itemCount: books.length,
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
