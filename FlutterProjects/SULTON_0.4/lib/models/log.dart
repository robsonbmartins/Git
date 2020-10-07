import 'package:flutter/material.dart';

//import 'package:http/http.dart' as http;

class Log {
  final String id;
  final String name;
  final String mac;
  final String codErro;
  final bool sensor1;

  const Log({
    this.id,
    @required this.name,
    @required this.mac,
    this.codErro,
    this.sensor1,
  });
}
