import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  // testWidgets('finds a widget using a Key', (tester) async {
  //   const testKey = Key('AppBar');
  //   await tester.pumpWidget(MaterialApp(key: testKey, home: Container()));
  //   expect(find.byKey(testKey), findsOneWidget);
  // });
  //
  // testWidgets('finds a widget using a Key', (tester) async {
  //   const testKey = Key('BotNav');
  //   await tester.pumpWidget(MaterialApp(key: testKey, home: Container()));
  //   expect(find.byKey(testKey), findsOneWidget);
  // });
  //
  // testWidgets('finds a widget using a Key', (tester) async {
  //   const testKey = Key('btnReg');
  //   await tester.pumpWidget(MaterialApp(key: testKey, home: Container()));
  //   expect(find.byKey(testKey), findsOneWidget);
  // });
  //
  // testWidgets('finds a widget using a Key', (tester) async {
  //   const testKey = Key('btnAuth');
  //   await tester.pumpWidget(MaterialApp(key: testKey, home: Container()));
  //   expect(find.byKey(testKey), findsOneWidget);
  // });
  //
  // testWidgets('finds a widget using a Key', (tester) async {
  //   const testKey = Key('Map');
  //   await tester.pumpWidget(MaterialApp(key: testKey, home: Container()));
  //   expect(find.byKey(testKey), findsOneWidget);
  // });

  testWidgets('finds a Text widget', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Text('Вход'),
      ),
    ));
    expect(find.text('Вход'), findsOneWidget);
  });

  testWidgets('finds a Text widget', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Text('Вход'),
      ),
    ));
    expect(find.text('Вход'), findsOneWidget);
  });

  testWidgets('finds a Text widget', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Text('Регистрация'),
      ),
    ));
    expect(find.text('Регистрация'), findsOneWidget);
  });

  testWidgets('finds a Text widget', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Text('Присоединиться'),
      ),
    ));
    expect(find.text('Присоединиться'), findsOneWidget);
  });

  testWidgets('finds a Text widget', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Text('Предложить проект'),
      ),
    ));
    expect(find.text('Предложить проект'), findsOneWidget);
  });
}
