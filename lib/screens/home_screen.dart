import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../models/book.dart';
import '../notifiers/books_notifier.dart';
import '../widgets/auth_text_form_field.dart';
import '../widgets/book_card.dart';
import '../widgets/books_view.dart';
import '../widgets/screens_background.dart';

final booksProvider =
    ChangeNotifierProvider.autoDispose<BooksNotifier>((ref) => BooksNotifier());

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // final booksNotifier = watch(booksProvider);

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
            ],
          ),
        )
      ],
    ));
  }
}
