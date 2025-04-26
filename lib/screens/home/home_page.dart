import 'package:flutter/material.dart';
import 'package:projeto_bolo/confeitaria.dart';
import 'package:projeto_bolo/database/database_helper.dart';
import 'home_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Confeitaria> lista = [];

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  void _carregar() async {
    await DatabaseHelper.instance.inserirConfeitaria(
      Confeitaria(
        nome: 'Doces da Maria',
        latitude: -23.5505,
        longitude: -46.6333,
        cep: '01000-000',
        rua: 'Rua das Flores',
        numero: '123',
        bairro: 'Centro',
        cidade: 'São Paulo',
        estado: 'SP',
        telefone: '(11) 1234-5678',
      ),
    );
    final dados = await DatabaseHelper.instance.listarConfeitarias();
    setState(() {
      lista = dados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3F512A),
        title: Text(
          widget.title,
          style: TextStyle(
                      color: Colors.white
                    )
        ),
        centerTitle: true,
      ),
      body: HomeBody(lista),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Adicionar',
        backgroundColor: const Color(0xFF3F512A),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

