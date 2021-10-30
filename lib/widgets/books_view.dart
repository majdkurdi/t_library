import 'package:flutter/material.dart';
import 'package:t_library_package/models/book.dart';
import '../screens/more_books_screen.dart';
import 'book_card.dart';

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$title:',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) =>
                            MoreBooksScreen(title: title, books: books)));
                  },
                  child:
                      Text('see more', style: TextStyle(color: Colors.white)),
                )
              ],
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
