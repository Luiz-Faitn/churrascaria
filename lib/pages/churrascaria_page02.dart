import 'package:churrascaria/model/churrascaria.dart';
import 'package:churrascaria/widgets/churrascaria_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Page2 extends StatefulWidget {
  Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  List<String> valores = [];
  List<String> qtdes = [];

  List<ChurrascoProduto> churrascoProdutos = [];
  double precoTotal = 0;

  final TextEditingController produtoController = TextEditingController();
  final TextEditingController valorController = TextEditingController();
  final TextEditingController qtdeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void adicionar() {
    if (_formKey.currentState!.validate()) {
      String text = produtoController.text;
      String text2 = valorController.text;
      String text3 = qtdeController.text;
      var newChurrascoProduto = ChurrascoProduto(
          DateTime.now().toIso8601String(), text, text2, text3);
      int qtde = int.tryParse(text3) != null ? int.parse(text3) : 0;
      double valor = double.tryParse(text2) != null ? double.parse(text2) : 0;
      var precoFinal = qtde * valor;
      setState(() {
        churrascoProdutos.add(newChurrascoProduto);
        precoTotal += precoFinal;
      });
      produtoController.clear();
      valorController.clear();
      qtdeController.clear();
    }
  }

  String? validateIsEmpty(String? formValue, String errorMsg) {
    if (formValue == null || formValue.isEmpty) {
      return errorMsg;
    }
    return null;
  }

  void onDelete(ChurrascoProduto produtoToDelete) {
    setState(() {
      churrascoProdutos
          .removeWhere((element) => element.id == produtoToDelete.id);
    });
  }

  void limparTudo() {
    setState(() {
      churrascoProdutos = [];
      precoTotal = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: produtoController,
                              validator: (value) {
                                return validateIsEmpty(
                                    value, "Adicione um produto!");
                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Produto",
                                  hintText: "Ex.: Cerveja"),
                            ),
                          ),
                          const SizedBox(height: 70),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: valorController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*.?\d{0,2}')),
                              ],
                              validator: (value) {
                                return validateIsEmpty(
                                    value, "Adicione um valor!");
                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Valor",
                                  hintText: "Ex.: R\$1.99"),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: qtdeController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: (value) {
                                return validateIsEmpty(
                                    value, "Adicione uma quantidade!");
                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Quantidade",
                                  hintText: "Ex.: 5"),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: adicionar,
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurple,
                              padding: const EdgeInsets.all(10),
                            ),
                            child: const Text(
                              "+",
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 500,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (final produto in churrascoProdutos)
                        ChurrascariaListItem(
                          produto: produto,
                          onDelete: onDelete,
                        ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "O total da compra deu: R\$ " + precoTotal.toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: limparTudo,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                        padding: const EdgeInsets.all(10),
                      ),
                      child: const Text("Limpar Tudo"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
