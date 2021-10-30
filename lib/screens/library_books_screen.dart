import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:t_library_package/models/book.dart';
import 'package:t_library_package/notifiers/books_notifier.dart';
import '../widgets/book_card.dart';
import '../widgets/screens_background.dart';

class LibraryBooksScreen extends StatefulWidget {
  final String title;

  LibraryBooksScreen({required this.title});

  @override
  State<LibraryBooksScreen> createState() => _LibraryBooksScreenState();
}

class _LibraryBooksScreenState extends State<LibraryBooksScreen> {
  List<Book> books = [];

  bool loading = true;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((_) async {
      if (widget.title == 'Purchesed') {
        await context.read(booksProvider).getOrderedBooks();
        books = context.read(booksProvider).orderedBooks;
      } else {
        await context.read(booksProvider).getFavorites();
        books = context.read(booksProvider).favorites;
      }
      setState(() => loading = false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ScreensBackground(
          child: loading
              ? Center(
                  child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        GridView.builder(
                            itemCount: books.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
