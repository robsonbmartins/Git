import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class CA {
  final String id;
  final String name;
  final String mac;
  final String avatarUrl;

  const CA({
    this.id,
    @required this.name,
    @required this.mac,
    @required this.avatarUrl,
  });

//tentativa
  factory CA.fromJson(Map<String, dynamic> json) {
    return CA(
      id: json['id'],
      name: json['name'],
      mac: json['mac'],
      avatarUrl: json['avatarUrl'],
    );
  }
}
