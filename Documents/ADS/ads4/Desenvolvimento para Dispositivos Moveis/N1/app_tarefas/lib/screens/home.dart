import 'package:flutter/material.dart';
import '../model/tarefa.dart';
import 'package:app_tarefas/constants/colors.dart';
import '../widgets/item_tarefa.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final tarefaList = Tarefa.tarefaList();
  List<Tarefa> _buscarTarefa = [];
  final _tarefaController = TextEditingController();

  @override
  void initState() {
    _buscarTarefa = tarefaList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          'Todas as tarefas',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      for (Tarefa tarefaa in _buscarTarefa)
                        ItemTarefa(
                          tarefa: tarefaa,
                          emTarefa: _handleEmTarefa,
                          emDeletado: _deleteTarefa,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20, 
                    right: 20, 
                    left: 20
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                    ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [BoxShadow(
                      color: Colors.grey, 
                      offset: Offset(0.0, 0.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                      ),],
                      borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _tarefaController,
                    decoration: InputDecoration(
                      hintText: 'Crie uma nova tarefa',
                      border: InputBorder.none,
                    ),
                  ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    child: Text(
                      '+', 
                      style: TextStyle(
                        fontSize: 40,
                        ),
                        ),
                    onPressed: () {
                      _criarTarefa(_tarefaController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      
                      minimumSize: Size(60, 60),
                      elevation: 10,
                    ),
                    ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleEmTarefa (Tarefa tarefa) {
    setState(() {
    tarefa.feito = !tarefa.feito;      
    });
  }

  void _deleteTarefa(String id){
    setState(() {
    tarefaList.removeWhere((item) => item.id == id);      
    });
  }

  void _criarTarefa(String tarefa){
    setState(() {
      tarefaList.add(Tarefa
      (id: DateTime.now().millisecondsSinceEpoch.toString(), 
      tarefaTexto: tarefa
    ));
    });    
    _tarefaController.clear();
  }

  void _filtrar(String palavraChave){
    List<Tarefa> resultados = [];
    if( palavraChave.isEmpty ) {
        resultados = tarefaList;
    } else {
      resultados = tarefaList
      .where((item) => item.tarefaTexto!
        .toLowerCase()
        .contains(palavraChave.toLowerCase()))
      .toList();
    }

    setState(() {
      _buscarTarefa = resultados;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => _filtrar(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Buscar tarefa',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        ),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/avatar1.jpg'),
          ),
        ),
      ]),
    );
  }
}
