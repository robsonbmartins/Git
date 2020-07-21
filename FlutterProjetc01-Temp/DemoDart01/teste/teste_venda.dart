import '../modelo/cliente.dart';
import '../modelo/item.dart';
import '../modelo/produto.dart';
import '../modelo/vendas.dart';


main() {
  var venda = Venda(
    cliente: new Cliente(
      cpf: "123123123123",
      nome: "Maria"
    ),
    itens: <Item>[
      Item(
        quantidade: 3,
        produto: Produto(
          codigo: 12, 
          desconto: 0.2,
          nome: "Pizza",
          preco: 53.50
          ) 
        ),
      Item(
        quantidade: 3,
        produto: Produto(
          codigo: 13, 
          desconto: 0.1,
          nome: "Calzone",
          preco: 33.50
          ) 
        ),
      Item(
        quantidade: 1,
        produto: Produto(
          codigo: 15, 
          desconto: 0.0,
          nome: "burguer",
          preco: 10.0
          ) 
        )
    ]
  );
print("o valor todal é = R\$${venda.valorTotal}");
  
}