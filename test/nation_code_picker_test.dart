import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nation_code_picker/nation_code_picker.dart';

void main() {
  testWidgets('NationCodePicker renders with default values', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NationCodePicker(
            defaultNationCode: NationCodes.us,
          ),
        ),
      ),
    );

    expect(find.byType(NationCodePicker), findsOneWidget);
    expect(find.text('+1'), findsOneWidget);
  });

  testWidgets('NationCodePicker calls onNationSelected callback when a nation is selected',
      (WidgetTester tester) async {
    NationCodes? selectedNation;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NationCodePicker(
            defaultNationCode: NationCodes.us,
            onNationSelected: (nation) {
              selectedNation = nation;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byType(NationCodePicker));
    await tester.pumpAndSettle();

    await tester.tap(find.text(NationCodes.us.name));
    await tester.pumpAndSettle();

    expect(selectedNation, NationCodes.us);
  });
}
