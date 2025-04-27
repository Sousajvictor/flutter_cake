import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:projeto_bolo/confeitaria.dart'; // Importando a classe Confeitaria
import 'package:projeto_bolo/produto.dart'; // Importando a classe Produto
import 'package:projeto_bolo/database/database_helper.dart'; // Importando o DatabaseHelper

class AdicionarProdutoPage extends StatefulWidget {
  final Confeitaria confeitaria; // Parâmetro para receber a confeitaria
  final Produto? produto; // Produto que será editado (opcional)

  const AdicionarProdutoPage({required this.confeitaria, this.produto, super.key}); // Construtor que recebe a confeitaria e o produto (opcional)

  @override
  State<AdicionarProdutoPage> createState() => _AdicionarProdutoPageState();
}

class _AdicionarProdutoPageState extends State<AdicionarProdutoPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController valorController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();

  File? _imagemSelecionada;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.produto != null) {
      // Se um produto foi passado, preenche os campos com os dados existentes
      nomeController.text = widget.produto!.nome;
      valorController.text = widget.produto!.valor.toString();
      descricaoController.text = widget.produto!.descricao;
      if (widget.produto!.imagem != null) {
        _imagemSelecionada = File(widget.produto!.imagem!);
      }
    }
  }

  // Função para escolher imagem
  Future<void> _selecionarImagem() async {
    final XFile? imagem = await _picker.pickImage(source: ImageSource.gallery);

    if (imagem != null) {
      setState(() {
        _imagemSelecionada = File(imagem.path);
      });
    }
  }

  // Função para salvar as informações do produto
  void _salvarProduto() async {
    if (nomeController.text.isEmpty || valorController.text.isEmpty || descricaoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos')),
      );
      return;
    }

    // Substitui a vírgula por ponto no valor para garantir que funcione com double.parse
    String valorText = valorController.text.replaceAll(',', '.');

    // Tenta converter o valor para double
    double? valor = double.tryParse(valorText);
    if (valor == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, insira um valor numérico válido')),
      );
      return;
    }

    // Verifica se a imagem foi selecionada, caso contrário exibe mensagem de erro
    if (_imagemSelecionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecione uma imagem para o produto')),
      );
      return;
    }

    Produto produto = Produto(
      nome: nomeController.text,
      valor: valor, // Valor convertido
      descricao: descricaoController.text,
      imagem: _imagemSelecionada?.path,
      confeitariaId: widget.confeitaria.id!, // id da confeitaria passada
    );

    try {
      if (widget.produto == null) {
        // Inserir o produto no banco de dados
        await DatabaseHelper.instance.inserirProduto(produto);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Produto ${nomeController.text} salvo com sucesso na confeitaria ${widget.confeitaria.nome}!')),
        );
      } else {
        // Atualizar o produto no banco de dados
        produto.id = widget.produto!.id; // Mantém o id para atualizar o produto existente
        await DatabaseHelper.instance.atualizarProduto(produto);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Produto ${nomeController.text} atualizado com sucesso!')),
        );
      }

      // Limpar os campos
      nomeController.clear();
      valorController.clear();
      descricaoController.clear();
      setState(() {
        _imagemSelecionada = null;
      });

      // Voltar para a tela anterior após o salvamento
      Navigator.pop(context);
    } catch (e) {
      // Exibe um erro caso a inserção no banco de dados falhe
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar produto: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Produto'),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Produtos:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Área para selecionar imagem
              GestureDetector(
                onTap: _selecionarImagem,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.brown),
                  ),
                  child: _imagemSelecionada != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.file(
                            _imagemSelecionada!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Center(
                          child: Icon(
                            Icons.add_a_photo,
                            color: Colors.brown,
                            size: 50,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 20),

              _buildTextField(nomeController, 'Nome do Produto:'),
              _buildTextField(valorController, 'Valor do Produto:', inputType: TextInputType.number),
              _buildTextField(descricaoController, 'Descrição do Produto:', maxLines: 5),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _salvarProduto,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                child: const Text('Salvar Produto e Voltar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para criar TextFields com estilos
  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType inputType = TextInputType.text, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          filled: true,
          fillColor: Colors.white24,
        ),
      ),
    );
  }
}
