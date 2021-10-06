import 'package:flutter/material.dart';
import '../services/books_service.dart';

import '../widgets/auth_text_form_field.dart';
import '../widgets/book_card.dart';
import '../widgets/books_view.dart';
import '../widgets/screens_background.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreensBackground(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: AuthTextFormField(
            suffix: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              BooksView(
                title: 'Most Rated',
                children: [BookCard(), BookCard(), BookCard(), BookCard()],
              ),
              TextButton(
                  onPressed: () async {
                    await BooksService.getBooks();
                  },
                  child: Text('kdxkvv')),
            ],
          ),
        )
      ],
    ));
  }
}
