import 'package:flutter/material.dart';
import 'package:projeto_bolo/confeitaria.dart';

class ListItem extends StatelessWidget {
  final Confeitaria confeitaria;

  const ListItem(this.confeitaria, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(confeitaria.nome),
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
