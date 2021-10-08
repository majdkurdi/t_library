import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../models/book.dart';
import '../notifiers/books_notifier.dart';
import '../widgets/auth_text_form_field.dart';
// import '../widgets/book_card.dart';
import '../widgets/books_view.dart';
import '../widgets/screens_background.dart';

final booksProvider =
    ChangeNotifierProvider<BooksNotifier>((ref) => BooksNotifier());

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = true;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((_) async {
      await context.read(booksProvider).getBooks();
      setState(() => loading = false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreensBackground(
        child: loading
            ? Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
              )
            : Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 30),
                      child: AuthTextFormField(
                        hintText: 'Search',
                        suffix: Icon(
                          Icons.search,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    Consumer(builder: (ctx, watch, _) {
                      final booksNotifier = watch(booksProvider);
                      final books = booksNotifier.books;
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              BooksView(
                                title: 'Most Rated',
                                books: books,
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ));
  }
}
