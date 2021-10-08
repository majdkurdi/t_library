import 'package:flutter/material.dart';

class BookInfoListTile extends StatelessWidget {
  const BookInfoListTile({required this.info, required this.icon});

  final String info;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(info, style: TextStyle(color: Colors.white)),
    );
  }
}
