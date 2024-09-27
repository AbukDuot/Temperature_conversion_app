import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:temp_conversion_app/main.dart';  // Import your main file

void main() {
  testWidgets('Temperature Converter app works correctly', (WidgetTester tester) async {
    // Build the TempConversionApp widget.
    await tester.pumpWidget(TempConversionApp());

    // Verify that the dropdown initially shows "F to C".
    expect(find.text('F to C'), findsOneWidget);

    // Verify the initial result is an empty string.
    expect(find.text('Converted Temperature: '), findsOneWidget);

    // Find the input field and enter a temperature value of 100.
    await tester.enterText(find.byType(TextFormField), '100');

    // Find the convert button and tap it.
    await tester.tap(find.text('Convert'));

    // Rebuild the widget after the state has changed.
    await tester.pump();

    // Verify that the converted result for 100 F to C is displayed correctly.
    expect(find.text('Converted Temperature: 37.78'), findsOneWidget);

    // Now change the conversion to "C to F" using the dropdown.
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('C to F').last);
    await tester.pumpAndSettle();

    // Enter a new temperature value of 0 (Celsius).
    await tester.enterText(find.byType(TextFormField), '0');
    await tester.tap(find.text('Convert'));
    await tester.pump();

    // Verify that the result is now converted to Fahrenheit.
    expect(find.text('Converted Temperature: 32.00'), findsOneWidget);

    // Verify that the history section contains the two previous conversions.
    expect(find.text('F to C: 100.0 => 37.78'), findsOneWidget);
    expect(find.text('C to F: 0.0 => 32.00'), findsOneWidget);
  });
}
