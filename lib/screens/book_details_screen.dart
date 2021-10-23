import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/book.dart';
import '../notifiers/books_notifier.dart';
import '../widgets/book_details.dart';
import '../widgets/my_icon_button.dart';
import '../widgets/screens_background.dart';

class BookDetailsScreen extends StatelessWidget {
  final booksProvider =
      ChangeNotifierProvider<BooksNotifier>((ref) => BooksNotifier());

  final Book book;
  BookDetailsScreen(this.book);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreensBackground(
        child: SafeArea(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FadeInImage(
                placeholder: AssetImage('assets/t.librart-logo.png'),
                image: NetworkImage(book.image),
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                // fit: BoxFit.cover,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(book.title,
                        style: TextStyle(color: Colors.white, fontSize: 30)),
                    Row(
                      children: [
                        FloatingActionButton(
                          heroTag: '1',
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (ctx) => Dialog(
                                    backgroundColor: Colors.white,
                                    elevation: 1,
                                    child: Container(
                                      width: 300,
                                      height: 150,
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text('Rate this book:',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              for (int i = 0; i < 5; i++)
                                                MyIconButton(
                                                    icon: Icon(
                                                        Icons.star_border,
                                                        size: 40),
                                                    onTap: () {
                                                      context
                                                          .read(booksProvider)
                                                          .rateBook(
                                                              bookId: book.id,
                                                              rate: i + 1);
                                                      Navigator.of(context)
                                                          .pop();
                                                    })
                                            ],
                                          ),
                                        ],
                                      ),
                                    )));
                          },
                          child: Icon(Icons.rate_review),
                          backgroundColor: Colors.white.withOpacity(0.4),
                        ),
                        SizedBox(width: 10),
                        FloatingActionButton(
                          heroTag: '2',
                          onPressed: () {},
                          child: Icon(Icons.add_shopping_cart),
                          backgroundColor: Colors.white.withOpacity(0.4),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: BookDetails(book: book),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
