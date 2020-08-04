import 'produto.dart';


class Item{
Produto produto;
int quantidade;
double _preco; //privado - com anderline fica inacessivel fora do arquivo

Item ({this.produto, this.quantidade});

//entrega valor do preco aplicando valor de desconto
double get preco {
  if(produto != null && _preco == null){
    _preco = produto.precoComDesconto;
  }
  return _preco;
}

//Recebe novo valor de preco via set
void set preco(double novoPreco){
  if(novoPreco > 0){ //Garante que valor não é menor que 0
    _preco = novoPreco;
  }
}

}

