import 'cliente.dart';
import 'produto.dart';
import 'item.dart';

class Venda {
  Cliente cliente;
  List<Item> itens; //"Notação NGX" Torna obrigatorio apenas inclusão de "Item";

  Venda({this.cliente, this.itens = const []});

  double get valorTotal {

    // EXEMPLO MAP Reduce
    return itens
      .map((i) => i.quantidade *i.preco)
      .reduce((t, a) => t +a);

    /* EXEMPLO  PROCIDURRAL
    double total = 0.0; //Cria variavel Total
    for (Item i in itens) { // Percorre a lista somando o total
      total += i.quantidade * i.preco;
    }
    return total;
    */

  }
}


/*EXEMPRO DE EXECUCAO Para rodar e testar e ver o conteudo de retorno
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