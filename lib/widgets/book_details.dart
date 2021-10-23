import 'package:flutter/material.dart';
import './comment_card.dart';
import '../models/book.dart';
import '../models/comment.dart';
import 'book_info_listtile.dart';

class BookDetails extends StatelessWidget {
  const BookDetails({Key? key, required this.book, required this.comments})
      : super(key: key);

  final Book book;
  final List<Comment> comments;

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
            collapsedIconColor: Colors.white,
            iconColor: Colors.white,
            leading: Icon(Icons.comment, color: Colors.white),
            title: Text('Comments', style: TextStyle(color: Colors.white)),
            children: comments.isEmpty
                ? [
                    Text('there is no comments',
                        style: TextStyle(color: Colors.white))
                  ]
                : [
                    ListView.builder(
                      itemBuilder: (ctx, i) => CommentCard(comments[i]),
                      itemCount: comments.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    )
                  ],
          )
        ]),
      ),
    );
  }
}
