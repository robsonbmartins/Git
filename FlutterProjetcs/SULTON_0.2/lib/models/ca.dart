import 'package:flutter/material.dart';

//import 'package:http/http.dart' as http;

class CA {
  final String id;
  final String name;
  final String mac;
  final String avatarUrl;
  final bool enable;

  const CA({
    this.id,
    @required this.name,
    @required this.mac,
    this.avatarUrl,
    this.enable,
  });
}
