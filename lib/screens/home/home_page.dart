import 'package:flutter/material.dart';
import 'package:projeto_bolo/confeitaria.dart';
import 'package:projeto_bolo/database/database_helper.dart';
import 'home_body.dart';
import 'cadastro_confeitaria_page.dart';  // Importa a página de cadastro (se necessário)

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
    final dados = await DatabaseHelper.instance.listarConfeitarias();
    setState(() {
      lista = dados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3F512A),
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: HomeBody(
        lista,
        onAtualizarLista: _carregar, // AQUI É O NOVO
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar para a tela de cadastro
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CadastroConfeitariaPage()),
          ).then((value) {
            // Quando voltar da tela de cadastro, recarregar a lista
            if (value == true) {
              _carregar(); // Atualiza a lista
            }
          });
        },
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
