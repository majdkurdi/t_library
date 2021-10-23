import 'replay.dart';

class Comment {
  final int id;
  final String body;
  final List<Replay> replies;

  Comment({required this.id, required this.body, required this.replies});
}
