import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './comment_card.dart';
import './my_icon_button.dart';
import './simple_text_field.dart';
import '../models/book.dart';
import '../models/comment.dart';
import '../notifiers/books_notifier.dart';
import 'book_info_listtile.dart';

class BookDetails extends StatefulWidget {
  BookDetails({Key? key, required this.book, required this.comments})
      : super(key: key);

  final Book book;
  List<Comment> comments;

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  final commentTextController = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    commentTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(children: [
          BookInfoListTile(
            icon: Icons.attribution,
            info: 'Author: ${widget.book.author}',
          ),
          BookInfoListTile(
            icon: Icons.date_range,
            info: 'Date: ${widget.book.publishDate.year}',
          ),
          BookInfoListTile(
            info: 'Language: ${widget.book.language}',
            icon: Icons.language,
          ),
          BookInfoListTile(
            info: 'Rate: ${widget.book.rate}',
            icon: Icons.star_border,
          ),
          BookInfoListTile(
            info: 'Publisher: ${widget.book.publisher}',
            icon: Icons.maps_home_work,
          ),
          BookInfoListTile(
            info: 'Sell Price: ${widget.book.price}\$',
            icon: Icons.local_offer,
          ),
          BookInfoListTile(
            info: 'Rent Price: ${widget.book.rentPrice}\$',
            icon: Icons.local_offer,
          ),
          ExpansionTile(
              collapsedIconColor: Colors.white,
              iconColor: Colors.white,
              leading: Icon(Icons.comment, color: Colors.white),
              title: Text('Comments', style: TextStyle(color: Colors.white)),
              children: [
                Column(children: [
                  ListTile(
                    leading: Icon(Icons.add, color: Colors.white),
                    title: SimpleTextField(
                        hint: 'type your comment',
                        controller: commentTextController,
                        fun: () {}),
                    trailing: loading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                        : MyIconButton(
                            icon: Icon(Icons.send, color: Colors.white),
                            onTap: () async {
                              final ncomment = commentTextController.text;
                              commentTextController.clear();
                              FocusScope.of(context).unfocus();
                              setState(() => loading = true);
                              final newComment = await context
                                  .read(booksProvider)
                                  .addComment(ncomment, widget.book.id);
                              if (newComment != null) {
                                widget.comments.add(newComment);
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text('Error!'),
                                ));
                              }
                              setState(() => loading = false);
                            }),
                  ),
                  widget.comments.isEmpty
                      ? Text('there is no comments',
                          style: TextStyle(color: Colors.white))
                      : ListView.builder(
                          itemBuilder: (ctx, i) =>
                              CommentCard(widget.comments[i]),
                          itemCount: widget.comments.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                        ),
                ])
              ])
        ]),
      ),
    );
  }
}
