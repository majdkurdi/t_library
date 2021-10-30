import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:t_library_package/models/book.dart';
import 'package:t_library_package/models/comment.dart';
import 'package:t_library_package/notifiers/books_notifier.dart';
import 'package:t_library_package/notifiers/cart_notifier.dart';
import '../widgets/book_details.dart';
import '../widgets/my_icon_button.dart';
import '../widgets/screens_background.dart';

class BookDetailsScreen extends StatefulWidget {
  final Book book;

  BookDetailsScreen(this.book);

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  List<Comment> comments = [];

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((_) async {
      comments =
          (await context.read(booksProvider).getComments(widget.book.id)) ?? [];
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: ScreensBackground(
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FadeInImage(
              placeholder: AssetImage('assets/t.librart-logo.png'),
              image: NetworkImage(widget.book.image),
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
                  Text(widget.book.title,
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
                                                  icon: Icon(Icons.star_border,
                                                      size: 40),
                                                  onTap: () {
                                                    context
                                                        .read(booksProvider)
                                                        .rateBook(
                                                            bookId:
                                                                widget.book.id,
                                                            rate: i + 1);
                                                    Navigator.of(context).pop();
                                                  })
                                          ],
                                        ),
                                      ],
                                    ),
                                  ))).then((_) =>
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Thanks for your Opinion!'),
                                duration: Duration(seconds: 1),
                              )));
                        },
                        child: Icon(Icons.rate_review),
                        backgroundColor: Colors.white.withOpacity(0.4),
                      ),
                      SizedBox(width: 10),
                      FloatingActionButton(
                        heroTag: '2',
                        onPressed: () async {
                          await context
                              .read(cartProvider)
                              .addToCart(widget.book);
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('book added to cart!',
                                style: TextStyle(color: Colors.white)),
                          ));
                        },
                        child: Icon(Icons.add_shopping_cart),
                        backgroundColor: Colors.white.withOpacity(0.4),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: BookDetails(
                book: widget.book,
                comments: comments,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
