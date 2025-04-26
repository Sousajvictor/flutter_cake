import 'package:flutter/material.dart';
import 'package:projeto_bolo/confeitaria.dart';
import '../../widgets/list_item.dart';

class HomeBody extends StatelessWidget {
  final List<Confeitaria> lista;
  const HomeBody(this.lista, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListItem(lista[index]),
                childCount: lista.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
