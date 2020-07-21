//import 'cliente.dart';

class Produto {
  int codigo;
  String nome;
  double preco;
  double desconto;

  Produto({this.codigo, this.desconto = 0, this.nome, this.preco});

//Atributo precoComDesconto
  double get precoComDesconto {
    return (1 - desconto) * preco;
  }

//Metodo getPrecoComDesconto
  double getPrecoComDesconto() {
    return (1 - desconto) * preco;
  }
}

/*
main() {
//Exemplo de Cliente.dart
  var c1 = Cliente(cpf: "123.123.123", nome: "João");
  print("${c1.nome}${c1.cpf}");

//Exemplo do produto.dart
  var p1 = Produto(codigo: 1, desconto: 0.13, nome: "Caneta", preco: 2.13);
  print(p1.precoComDesconto); //Acessa o atributo como uma propriedade
  print(p1.getPrecoComDesconto()); //Acessa o metodo como uma propriedade
}
*/