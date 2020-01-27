// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_app_tdd/di/injector.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app_tdd/main.dart';

void main() {

  testWidgets('Basic UI test', (WidgetTester tester) async {
    ModuleContainer().initialise(Injector.getInjector());
    await tester.pumpWidget(MyApp());
    tester.idle().then((value){
      expect(find.text('Flight Tickets'), findsOneWidget);
    });
  });
}
