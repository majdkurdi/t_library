import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/category.dart';
import '../notifiers/books_notifier.dart';

final booksProvider =
    ChangeNotifierProvider<BooksNotifier>((ref) => BooksNotifier());

class CategoryAvatar extends StatelessWidget {
  final Category category;
  final Function fun;
  CategoryAvatar(this.category, this.fun);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await context.read(booksProvider).getTopRatedBooks(category.id);
        print(context.read(booksProvider).topRatedBooks);
        fun();
      },
      child: CircleAvatar(
        radius: 25,
        child: Text(category.name.characters.take(3).string),
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }
}
