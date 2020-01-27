import 'package:flutter/material.dart';
import 'package:flutter_app_tdd/di/injector.dart';
import 'features/ticket_details/ticket_list_widget.dart';
import 'package:provider/provider.dart';
import 'features/ticket_details/ticket_list_provider.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

void main() {
  print("main method");
  runApp(MyApp());
  ModuleContainer().initialise(Injector.getInjector());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("My app build");
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TicketList(),
    );
  }
}
