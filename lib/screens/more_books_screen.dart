import 'package:flutter/material.dart';
import 'package:t_library_package/models/book.dart';
import '../widgets/book_card.dart';
import '../widgets/screens_background.dart';

class MoreBooksScreen extends StatelessWidget {
  final String title;
  final List<Book> books;

  MoreBooksScreen({required this.title, required this.books});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ScreensBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  GridView.builder(
                      itemCount: books.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, childAspectRatio: 3 / 5),
                      itemBuilder: (ctx, i) => BookCard(books[i])),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
