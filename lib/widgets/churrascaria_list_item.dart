import 'package:churrascaria/model/churrascaria.dart';
import 'package:churrascaria/pages/churrascaria_page02.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ChurrascariaListItem extends StatelessWidget {
  const ChurrascariaListItem(
      {Key? key, required this.produto, required this.onDelete})
      : super(key: key);

  final ChurrascoProduto produto;

  final Function(ChurrascoProduto) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.grey[300],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Produto: " + produto.nomeProduto,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Valor: " + produto.valorProduto,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Qtde: " + produto.qtdeProduto,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconSlideAction(
            color: Colors.redAccent,
            icon: Icons.delete,
            caption: "Deletar",
            onTap: () {
              onDelete(produto);
            },
          ),
        ],
      ),
    );
  }
}
