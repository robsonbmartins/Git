import 'package:flutter/material.dart';
import 'package:flutter_crud/models/cas.dart';
import 'package:flutter_crud/provider/ca.dart';
import 'package:provider/provider.dart';

class CAForm extends StatefulWidget {
  @override
  _CAFormState createState() => _CAFormState();
}

class _CAFormState extends State<CAForm> {
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;

  final Map<String, String> _formData = {};

  void _loadFormData(CA ca) {
    //carrega valores apenas for edição, se for cadastro novo usuario escapa do if
    if (ca != null) {
      _formData['id'] = ca.id;
      _formData['name'] = ca.name;
      _formData['mac'] = ca.mac;
      _formData['avatarUrl'] = ca.avatarUrl;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final CA ca = ModalRoute.of(context).settings.arguments;
    //carrega em CA o conteudo através do metodo de carga
    _loadFormData(ca);
  }

  @override
  Widget build(BuildContext context) {
    /*TESTA NO CONSOLE IMPREÇAO DA VARIAVEL
    print(CA.name); 
    */
    return Scaffold(
      appBar: AppBar(
        title: Text("Configurações"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            /*
            Esta função recebeu o função assincrona para comportar o delay do Firebase
            Este metodo async faz com que o sistema espere no "await" até obter o retorno
            
            onPressed: () {
            */
            onPressed: () async {
              final isValid =
                  _form.currentState.validate(); //valida conteudo do preenchido
              if (isValid) {
                _form.currentState.save();
                //Salva o formulario recebento valor de todos os "onSave"

                //Altera o stado da variavel booleana que exibe a ampulheta em caso de true
                setState(() {
                  _isLoading = true;
                });

                //carrega conteudo do formulario no provider
                await Provider.of<CAS>(context, listen: false).put(
                  CA(
                    id: _formData['id'],
                    name: _formData['name'],
                    mac: _formData['mac'],
                    avatarUrl: _formData['avatarUrl'],
                  ),
                );

                //Altera o stado da variavel booleana que exibe a ampulheta em caso de true
                setState(() {
                  _isLoading = false;
                });

                Navigator.of(context).pop(); // Movimenta para a tela anterior
              }
            },
          ),
        ],
      ),
      //Foi adicionado a logica booleana que exibe uma ampuleta enquanto aguarda o firebase
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(15),
              child: Form(
                key: _form,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      //Inicializa o valor do campo do formulario
                      initialValue: _formData['name'],
                      decoration: InputDecoration(labelText: 'Nome'),
                      onSaved: (value) => _formData['name'] = value,
                    ),
                    TextFormField(
                      initialValue: _formData['mac'],
                      decoration: InputDecoration(labelText: 'MAC'),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@')) {
                          return 'MAC inválido!';
                        }
                        if (value.trim().length < 3) {
                          return "MAC muito curto.";
                        }

                        return null;
                      }, //Trexo logico de validação que dos dados

                      /*TESTE DE IMPRESSAO NO CONSOLE DOS CAMPOS DO FORMULARIO
                onSaved: (value) {
                  print(value);
                },
                */
                      onSaved: (value) => _formData['mac'] = value,
                    ),
                    TextFormField(
                      initialValue: _formData['avatarUrl'],
                      decoration: InputDecoration(labelText: 'URL do Avatar'),
                      onSaved: (value) => _formData['avatarUrl'] = value,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
