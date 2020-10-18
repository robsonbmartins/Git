import 'package:flutter/material.dart';
import 'package:flutter_crud/provider/login.dart';
import 'package:flutter_crud/views/ca_form.dart';
import 'package:flutter_crud/views/ca_list.dart';
import 'package:flutter_crud/views/ca_login.dart';
import 'package:flutter_crud/views/log_list.dart';

class AppRoutes {
  static const HOME = 'home';
  static const CA_FORM = 'ca-form';
  static const CA_LOGS = 'ca-logs';
  static const CA_LOGIN = '/';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  // Here we'll handle all the routing
  var args = settings.arguments;

  switch (settings.name) {
    case AppRoutes.HOME:
      return MaterialPageRoute(
          builder: (context) => CAList(
                auth: new Auth(),
                loggedUser: args,
              ));
    case AppRoutes.CA_LOGIN:
      return MaterialPageRoute(builder: (context) => CALogin(auth: new Auth()));
    case AppRoutes.CA_FORM:
      return MaterialPageRoute(
          builder: (context) => CAForm(
                ca: args,
              ));
    case AppRoutes.CA_LOGS:
      return MaterialPageRoute(
          builder: (context) => CALogs(
                ca: args,
              ));
    default:
      return MaterialPageRoute(
          builder: (context) => CAList(
                auth: new Auth(),
              ));
  }
}
