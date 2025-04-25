import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final int index;

  const ListItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text('Item ${index + 1}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: const Icon(Icons.visibility), onPressed: () {}),
            IconButton(icon: const Icon(Icons.add), onPressed: () {}),
            IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
