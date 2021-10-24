import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/comment.dart';
import '../models/replay.dart';
import '../notifiers/books_notifier.dart';
import '../widgets/my_icon_button.dart';
import '../widgets/simple_text_field.dart';

final booksProvider =
    ChangeNotifierProvider<BooksNotifier>((ref) => BooksNotifier());

class CommentCard extends StatefulWidget {
  final Comment comment;
  CommentCard(this.comment);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool loading = false;
  final commentTextController = TextEditingController();

  @override
  void dispose() {
    commentTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ExpansionTile(
              collapsedIconColor: Colors.white,
              iconColor: Colors.white,
              leading: Icon(Icons.three_p, color: Colors.white),
              title: Text(widget.comment.body,
                  style: TextStyle(color: Colors.white)),
              children: [
                Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.add, color: Colors.white),
                      title: SimpleTextField(
                          hint: 'type your replay',
                          controller: commentTextController,
                          fun: () {}),
                      trailing: loading
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )
                          : MyIconButton(
                              icon: Icon(Icons.send, color: Colors.white),
                              onTap: () async {
                                final nreplay = commentTextController.text;
                                commentTextController.clear();
                                FocusScope.of(context).unfocus();
                                setState(() => loading = true);
                                final newComment = await context
                                    .read(booksProvider)
                                    .addReplay(nreplay, widget.comment.id);
                                if (newComment != null) {
                                  widget.comment.replies.add(newComment);
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Error!'),
                                  ));
                                }
                                setState(() => loading = false);
                              }),
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      itemBuilder: (ctx, i) =>
                          ReplayWidget(widget.comment.replies[i]),
                      itemCount: widget.comment.replies.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ],
                )
              ])),
    );
  }
}

class ReplayWidget extends StatelessWidget {
  final Replay replay;
  ReplayWidget(this.replay);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Icon(Icons.replay, color: Colors.white),
        ),
        Text(replay.body, style: TextStyle(color: Colors.white))
      ],
    );
  }
}
