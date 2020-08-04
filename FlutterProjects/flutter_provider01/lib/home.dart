import 'package:flutter/material.dart';
import 'package:flutter_provider01/heroes_controler.dart';
import 'package:flutter_provider01/model/hero_model.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _buildList() {
    //_buildList(HeroesControler heroesControler) {
    //com o "of" voce consegue recuperar o controler em qualquer parte do codigo
    HeroesControler heroesControler = Provider.of<HeroesControler>(context);

    return ListView.builder(
      itemCount: heroesControler.heroes.length,
      itemBuilder: (context, index) {
        //Controi toda a lista passando um indice por vez automaticamente
        //return _buildItens(heroesControler.heroes[index], heroesControler); // Passou a acessar por metodo sem passar por parametro
        return _buildItens(heroesControler.heroes[index]);
      },
    );
  }

  //_buildItens(HeroModel model, HeroesControler heroesControler) { //Com o "of" não precisa receber por parametro pois instancia o metodo

  _buildItens(HeroModel model) {
    //com o "of" voce consegue recuperar o controler em qualquer parte do codigo
    HeroesControler heroesControler = Provider.of<HeroesControler>(context);

    return ListTile(
      onTap: () {
        //print("clicado");
        //model.isFavorte = !model.isFavorte; //Este trexo passou a ser um metodo em model
        //heroesControler.notifyListeners();
        heroesControler.checkFavorite(model);
        //agora basta acessaro metodo checkFavorite passndo model
      },
      title: Text(model.name),
      trailing: model.isFavorte
          ? Icon(
              Icons.star,
              color: Colors.yellow,
            )
          : Icon(Icons.star_border),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider"),
        leading: Consumer<HeroesControler>(
            builder: (context, heroesControler, widget) {
          return Center(
            child: Text(
              "${heroesControler.heroes.where((i) => i.isFavorte).length}",
              style: TextStyle(fontSize: 18),
            ),
          );
        }),
      ),
      body: Consumer<HeroesControler>(
        builder: (context, heroesControler, widget) {
          //return _buildList(heroesControler);
          return _buildList();
        },
      ),
    );
  }
}
