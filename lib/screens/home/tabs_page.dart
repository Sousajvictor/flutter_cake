import 'package:flutter/material.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.brown,
            centerTitle: true,
            title: const Text('P R E E N C H I M E N T O'),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.article_outlined, color:Colors.white)),
                Tab(icon: Icon(Icons.add, color: Colors.white,)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'I N F O R M A Ç Õ E S:',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        labelText: 'Nome do Estabelecimento:',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.white24,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Abaixo a Segunda Tela do Tabs 

              SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        const Text('Nome do Produto:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        const SizedBox( height: 8),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Digite o Nome',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Colors.white24,
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        //Abaixo Campo de Valor do Produto.
                        
                        const Text('Valor do Produto:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        const SizedBox( height: 8),
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Digite o Valor',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Colors.white24,
                          ),
                        ),
                        const SizedBox(height: 16),

                        //Abaixo Campo de Descrição do Produto.


                        const Text('Descrição do Produto:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        const SizedBox( height: 8),
                        ConstrainedBox(constraints: const BoxConstraints(
                          minHeight: 100,
                          maxHeight: 300,
                        ), child: TextField(
                            maxLines: null,
                            expands: true,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: InputDecoration(
                              hintText: 'Escreva uma Descrição',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.white24,
                            ),
                        )),
                        const SizedBox(height: 80),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(padding: const EdgeInsets.only(top: 555),
                        child: ElevatedButton(onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Cadastro com Sucesso')),
                          );
                        },style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                          ),
                          child: const Text('Cadastrar'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

