import 'package:flutter/material.dart';
import 'home_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: const HomeBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Adicionar',
        backgroundColor: const Color(0xFF3F512A),
        child: const Icon(Icons.add),
      ),
    );
  }
}

