import 'package:flutter/material.dart';
import 'package:projeto_bolo/confeitaria.dart';
import 'package:projeto_bolo/database/database_helper.dart';
import 'package:projeto_bolo/screens/home/cadastro_confeitaria_page.dart'; // Tela de cadastro de confeitaria
import 'package:projeto_bolo/screens/home/add_produto.dart'; // Tela de adicionar produto (corrigido)
import 'package:projeto_bolo/screens/home/watch_page.dart'; // Tela de visualização de produtos (corrigido)

class ListItem extends StatelessWidget {
  final Confeitaria confeitaria;
  final VoidCallback onAtualizarLista; // Função para recarregar a lista depois

  const ListItem(this.confeitaria, {required this.onAtualizarLista, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Bordas arredondadas
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20), // Padding para um espaçamento melhor
        title: Text(
          confeitaria.nome,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1. Botão de visualização
            IconButton(
              icon: const Icon(Icons.visibility),
              onPressed: () {
                // Navegar para a tela de visualização de produtos
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WatchPage(confeitaria: confeitaria), // Passa a confeitaria para a tela de visualização
                  ),
                );
              },
            ),
            // 2. Botão de editar
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                final resultado = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CadastroConfeitariaPage(confeitariaExistente: confeitaria),
                  ),
                );

                if (resultado == true) {
                  onAtualizarLista(); // Atualiza a lista depois de editar
                }
              },
            ),
            // 3. Botão de adicionar produto
            IconButton(
              icon: const Icon(Icons.add_box),
              onPressed: () {
                // Navegar para a tela de adicionar produto
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdicionarProdutoPage(confeitaria: confeitaria,), // Corrigido para passar a confeitaria
                  ),
                );
              },
            ),
            // 4. Botão de excluir
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirmar exclusão'),
                    content: const Text('Deseja realmente excluir esta confeitaria?'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
                      TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Excluir')),
                    ],
                  ),
                );

                if (confirm == true) {
                  await DatabaseHelper.instance.deletarConfeitaria(confeitaria.id!);
                  onAtualizarLista(); // Atualiza a lista depois de deletar
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
