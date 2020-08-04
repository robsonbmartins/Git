import 'package:flutter/material.dart';
import 'package:flutter_crud/models/users.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    //carrega valores apenas for edição, se for cadastro novo usuario escapa do if
    if (user != null) {
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final User user = ModalRoute.of(context).settings.arguments;
    //carrega em user o conteudo através do metodo de carga
    _loadFormData(user);
  }

  @override
  Widget build(BuildContext context) {
    /*TESTA NO CONSOLE IMPREÇAO DA VARIAVEL
    print(user.name); 
    */
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulario de Usuario"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final isValid =
                  _form.currentState.validate(); //valida conteudo do preenchido
              if (isValid) {
                _form.currentState
                    .save(); //Salva o formulario recebento valor de todos os "onSave"

                //carrega conteudo do formulario no provider
                Provider.of<Users>(context, listen: false).put(
                  User(
                    id: _formData['id'],
                    name: _formData['name'],
                    email: _formData['email'],
                    avatarUrl: _formData['avatarUrl'],
                  ),
                );
                Navigator.of(context).pop(); // Movimenta para a tela anterior
              }
            },
          ),
        ],
      ),
      body: Padding(
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
                initialValue: _formData['email'],
                decoration: InputDecoration(labelText: 'e-mail'),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'E-Mail inválido!';
                  }
                  if (value.trim().length < 3) {
                    return "E-Mail muito curto.";
                  }

                  return null;
                }, //Trexo logico de validação que dos dados

                /*TESTE DE IMPRESSAO NO CONSOLE DOS CAMPOS DO FORMULARIO
                onSaved: (value) {
                  print(value);
                },
                */
                onSaved: (value) => _formData['email'] = value,
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
