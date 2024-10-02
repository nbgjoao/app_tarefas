import 'package:app_tarefas/constants/colors.dart';
import '../model/tarefa.dart';
import 'package:flutter/material.dart';

class ItemTarefa extends StatelessWidget {
  final Tarefa tarefa;
  final emTarefa;
  final emDeletado;

  const ItemTarefa({
    Key? key, 
    required this.tarefa, 
    required this.emTarefa, 
    required this.emDeletado,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          //print('Tarefa selecionada');
          emTarefa(tarefa);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          tarefa.feito ? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
          ),
        title: Text(
          tarefa.tarefaTexto!, 
          style: TextStyle(
          fontSize: 16, 
          color: tdBlack, 
          decoration: tarefa.feito? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),            
            onPressed: () {
              //print('Botão deletar selecionado');
              emDeletado(tarefa.id);
            },
            ),
        ),
      ),

    );
  }
}