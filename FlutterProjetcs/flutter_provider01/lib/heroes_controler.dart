import 'package:flutter/material.dart';
import 'package:flutter_provider01/model/hero_model.dart';

//"extends ChangeNotifier" ------ permite notificar a tela das alterações do provider
//*********** porem é necessario usar um tipo especifico de "provider" ----- "ChangeNofifierProvider"
class HeroesControler extends ChangeNotifier {
  List<HeroModel> heroes = [
    HeroModel(name: "Thor"),
    HeroModel(name: "Homem Aranha"),
    HeroModel(name: "Fin o Humano"),
    HeroModel(name: "Robson"),
    HeroModel(name: "Arthur"),
  ];

  checkFavorite(HeroModel model) {
    model.isFavorte = !model.isFavorte;
    notifyListeners();
  }
}
