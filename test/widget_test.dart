import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tinyguide_1/main.dart';

void main() {
  testWidgets('TinyGuide app launches successfully',
          (WidgetTester tester) async {
        await tester.pumpWidget(const TinyGuideApp());

        expect(find.byType(MaterialApp), findsOneWidget);
      });
}