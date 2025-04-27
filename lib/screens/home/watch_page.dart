import 'dart:io';
import 'package:flutter/material.dart';
import 'package:projeto_bolo/database/database_helper.dart';
import 'package:projeto_bolo/produto.dart'; // Classe Produto
import 'package:projeto_bolo/confeitaria.dart';
import 'package:projeto_bolo/screens/home/add_produto.dart'; // Classe Confeitaria

class WatchPage extends StatefulWidget {
  final Confeitaria confeitaria; // Confeitaria passada como parâmetro

  const WatchPage({required this.confeitaria, super.key});

  @override
  State<WatchPage> createState() => _Watchpage();
}

class _Watchpage extends State<WatchPage> {
  late Future<List<Produto>> _produtos;

  @override
  void initState() {
    super.initState();
    _produtos = _carregarProdutos();
  }

  // Função para carregar os produtos do banco
  Future<List<Produto>> _carregarProdutos() async {
    return await DatabaseHelper.instance.listarProdutosDaConfeitaria(widget.confeitaria.id!);
  }

  // Função para excluir um produto
  void _excluirProduto(int produtoId) async {
    await DatabaseHelper.instance.deletarProduto(produtoId);
    setState(() {
      _produtos = _carregarProdutos();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Produto excluído com sucesso!')),
    );
  }

  // Função para editar um produto
  void _editarProduto(Produto produto) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdicionarProdutoPage(confeitaria: widget.confeitaria, 
      produto: produto,)),
    ); // Redirecionar para a tela de edição (você precisará implementar a tela de edição)
    // Navigator.push(...);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualizar Produtos'),
        backgroundColor: Colors.brown,
      ),
      body: Column(
        children: [
          // Informações da Confeitaria
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nome do Estabelecimento: ${widget.confeitaria.nome}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text('Telefone: ${widget.confeitaria.telefone}'),
                const SizedBox(height: 5),
                Text('Endereço: ${widget.confeitaria.rua}'),
                const SizedBox(height: 5,),
                Text('Numero: ${widget.confeitaria.numero}')
              ],
            ),
          ),
          const Divider(), // Linha separadora entre informações da confeitaria e lista de produtos

          // Lista de produtos
          Expanded(
            child: FutureBuilder<List<Produto>>(
              future: _produtos,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Nenhum produto encontrado.'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final produto = snapshot.data![index];

                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nome do Produto: ${produto.nome}',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            // Exibição da imagem
                            produto.imagem != null
                                ? Image.file(File(produto.imagem!), width: 150, height: 150, fit: BoxFit.cover)
                                : const Icon(Icons.image, size: 150, color: Colors.grey),
                            const SizedBox(height: 10),
                            Text('Valor: R\$ ${produto.valor.toStringAsFixed(2)}'),
                            const SizedBox(height: 10),
                            Text('Descrição: ${produto.descricao}'),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => _editarProduto(produto),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => _excluirProduto(produto.id!),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
