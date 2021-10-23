import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifiers/auth_notifier.dart';
import '../notifiers/books_notifier.dart';
import '../screens/acount_screen.dart';
import '../screens/cart_screen.dart';
import '../widgets/auth_text_form_field.dart';
import '../widgets/books_view.dart';
import '../widgets/my_icon_button.dart';
import '../widgets/screens_background.dart';

final booksProvider =
    ChangeNotifierProvider<BooksNotifier>((ref) => BooksNotifier());
final authProvider = Provider<AuthNotifier>((ref) => AuthNotifier());

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
    final username = context.read(authProvider).user?.name;
    return ScreensBackground(
        child: loading
            ? Container(
                height: MediaQuery.of(context).size.height,
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
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => AccountScreen()));
                            },
                            child: CircleAvatar(
                              child: Text(
                                username![0].toUpperCase(),
                                style: TextStyle(color: Colors.black),
                              ),
                              backgroundColor: Colors.white.withOpacity(0.5),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: AuthTextFormField(
                              hintText: 'Search',
                              suffix: Icon(
                                Icons.search,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MyIconButton(
                                icon: Icon(Icons.shopping_cart,
                                    color: Colors.white.withOpacity(0.5)),
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(CartScreen.routeName);
                                }),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 15),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [
                          CircleAvatar(
                            child: Text('All'),
                            backgroundColor: Theme.of(context).accentColor,
                          ),
                          SizedBox(width: 10),
                          CircleAvatar(
                            child: Text('His'),
                            backgroundColor: Theme.of(context).accentColor,
                          ),
                          SizedBox(width: 10),
                          CircleAvatar(
                            child: Text('Poli'),
                            backgroundColor: Theme.of(context).accentColor,
                          ),
                          SizedBox(width: 10),
                          CircleAvatar(
                            child: Text('Art'),
                            backgroundColor: Theme.of(context).accentColor,
                          ),
                          SizedBox(width: 10),
                          CircleAvatar(
                            child: Text('sci'),
                            backgroundColor: Theme.of(context).accentColor,
                          ),
                          SizedBox(width: 10),
                          CircleAvatar(
                            child: Text('sci'),
                            backgroundColor: Theme.of(context).accentColor,
                          ),
                          SizedBox(width: 10),
                          CircleAvatar(
                            child: Text('sci'),
                            backgroundColor: Theme.of(context).accentColor,
                          )
                        ]),
                      ),
                    ),
                    Consumer(builder: (ctx, watch, _) {
                      final booksNotifier = watch(booksProvider);
                      final books = booksNotifier.books;
                      return Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                BooksView(
                                  title: 'Most Rated',
                                  books: books,
                                ),
                                BooksView(
                                  title: 'Recommended For You',
                                  books: books,
                                ),
                                BooksView(books: books, title: 'All')
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 65)
                  ],
                ),
              ));
  }
}
