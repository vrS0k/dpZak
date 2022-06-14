import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  testWidgets('finds a widget using a Key', (tester) async {
    const testKey = Key('Key');
    await tester.pumpWidget(MaterialApp(key: testKey, home: Container()));
    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('finds a Text widget', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Text('Вход'),
      ),
    ));
    expect(find.text('Вход'), findsOneWidget);
  });
}
