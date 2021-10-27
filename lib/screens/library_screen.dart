import 'package:flutter/material.dart';
import '../screens/library_books_screen.dart';
import '../widgets/screens_background.dart';

class LibraryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreensBackground(
        child: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                child: Center(
                  child: Image.asset('assets/images/t.library-logo.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('MY LIBRARY',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
              ),
              Column(
                children: [
                  LibraryTap(Icons.shopping_cart_outlined, 'Purchesed'),
                  LibraryTap(Icons.shopping_bag_outlined, 'Rented'),
                  LibraryTap(Icons.favorite_border, 'Favorites'),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class LibraryTap extends StatelessWidget {
  final String title;
  final IconData icon;
  LibraryTap(this.icon, this.title);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => LibraryBooksScreen(title: title)));
            },
            child: ListTile(
              leading:
                  Icon(icon, size: 30, color: Colors.white.withOpacity(0.6)),
              title: Text(title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                  )),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
        ),
      ),
    );
  }
}
