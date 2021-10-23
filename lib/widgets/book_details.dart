import 'package:flutter/material.dart';
import '../models/book.dart';
import 'book_info_listtile.dart';

class BookDetails extends StatelessWidget {
  const BookDetails({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(children: [
          BookInfoListTile(
            icon: Icons.attribution,
            info: 'Author: ${book.author}',
          ),
          BookInfoListTile(
            icon: Icons.date_range,
            info: 'Date: ${book.publishDate.year}',
          ),
          BookInfoListTile(
            info: 'Language: ${book.language}',
            icon: Icons.language,
          ),
          BookInfoListTile(
            info: 'Rate: ${book.rate}',
            icon: Icons.star_border,
          ),
          BookInfoListTile(
            info: 'Publisher: ${book.publisher}',
            icon: Icons.maps_home_work,
          ),
          BookInfoListTile(
            info: 'Sell Price: ${book.price}\$',
            icon: Icons.local_offer,
          ),
          BookInfoListTile(
            info: 'Rent Price: ${book.rentPrice}\$',
            icon: Icons.local_offer,
          ),
          ExpansionTile(
              leading: Icon(Icons.comment, color: Colors.white),
              title: Text('Comments', style: TextStyle(color: Colors.white)))
        ]),
      ),
    );
  }
}
