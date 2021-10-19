import 'package:flutter/material.dart';
import '../models/book.dart';
import '../widgets/book_info_listtile.dart';
import '../widgets/screens_background.dart';

class BookDetailsScreen extends StatelessWidget {
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
                    FloatingActionButton(
                      onPressed: () {},
                      child: Icon(Icons.add_shopping_cart),
                      backgroundColor: Colors.white.withOpacity(0.4),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Card(
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
                    ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
