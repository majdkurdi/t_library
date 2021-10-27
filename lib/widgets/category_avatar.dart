import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/category.dart';
import '../notifiers/books_notifier.dart';

class CategoryAvatar extends StatelessWidget {
  final Category category;
  final Function fun;
  CategoryAvatar(this.category, this.fun);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        fun();
        await context.read(booksProvider).getTopRatedBooks(category.id);
        fun();
      },
      child: Chip(
        label: Text(category.name),
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }
}
