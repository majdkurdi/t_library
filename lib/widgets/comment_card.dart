import 'package:flutter/material.dart';
import '../models/comment.dart';
import '../models/replay.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;
  CommentCard(this.comment);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.comment, color: Colors.white),
                ),
                Text(comment.body, style: TextStyle(color: Colors.white)),
              ],
            ),
            ListView.builder(
              itemBuilder: (ctx, i) => ReplayWidget(comment.replies[i]),
              itemCount: comment.replies.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            )
          ],
        ),
      ),
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
