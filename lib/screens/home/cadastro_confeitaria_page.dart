import 'package:flutter/material.dart';
import 'package:projeto_bolo/database/database_helper.dart';
import 'package:projeto_bolo/confeitaria.dart';

class CadastroConfeitariaPage extends StatefulWidget {
  final Confeitaria? confeitariaExistente; // <-- Recebe confeitaria existente (pode ser nulo)

  const CadastroConfeitariaPage({this.confeitariaExistente, super.key});

  @override
  State<CadastroConfeitariaPage> createState() => _CadastroConfeitariaPageState();
}

class _CadastroConfeitariaPageState extends State<CadastroConfeitariaPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController ruaController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController bairroController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.confeitariaExistente != null) {
      final c = widget.confeitariaExistente!;
      nomeController.text = c.nome;
      latitudeController.text = c.latitude.toString();
      longitudeController.text = c.longitude.toString();
      cepController.text = c.cep;
      ruaController.text = c.rua;
      numeroController.text = c.numero;
      bairroController.text = c.bairro;
      cidadeController.text = c.cidade;
      estadoController.text = c.estado;
      telefoneController.text = c.telefone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.confeitariaExistente == null ? 'Cadastrar Confeitaria' : 'Editar Confeitaria'),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Dados da Confeitaria:'),
            _buildTextField(nomeController, 'Nome do Estabelecimento:'),
            _buildTextField(latitudeController, 'Latitude:', inputType: TextInputType.number),
            _buildTextField(longitudeController, 'Longitude:', inputType: TextInputType.number),
            _buildTextField(cepController, 'CEP:'),
            _buildTextField(ruaController, 'Rua:'),
            _buildTextField(numeroController, 'Número:'),
            _buildTextField(bairroController, 'Bairro:'),
            _buildTextField(cidadeController, 'Cidade:'),
            _buildTextField(estadoController, 'Estado:'),
            _buildTextField(telefoneController, 'Telefone:'),

            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _salvarConfeitaria,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: Text(widget.confeitariaExistente == null ? 'Salvar' : 'Atualizar', style: const TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {TextInputType inputType = TextInputType.text, int maxLines = 1}) {
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

  Future<void> _salvarConfeitaria() async {
    try {
      final confeitaria = Confeitaria(
        id: widget.confeitariaExistente?.id, // Se estiver editando, mantém o ID
        nome: nomeController.text,
        latitude: double.tryParse(latitudeController.text) ?? 0.0,
        longitude: double.tryParse(longitudeController.text) ?? 0.0,
        cep: cepController.text,
        rua: ruaController.text,
        numero: numeroController.text,
        bairro: bairroController.text,
        cidade: cidadeController.text,
        estado: estadoController.text,
        telefone: telefoneController.text,
      );

      if (widget.confeitariaExistente == null) {
        await DatabaseHelper.instance.inserirConfeitaria(confeitaria);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Confeitaria cadastrada com sucesso!')));
      } else {
        await DatabaseHelper.instance.atualizarConfeitaria(confeitaria);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Confeitaria atualizada com sucesso!')));
      }

      Navigator.pop(context, true); // Retorna para a tela anterior indicando sucesso
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar: $e')),
      );
    }
  }
}
