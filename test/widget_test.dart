import 'package:flutter_test/flutter_test.dart';
import 'package:studie/main.dart';

void main() {
  testWidgets('Language selection page loads successfully',
      (WidgetTester tester) async {
    // Build the app and trigger a frame
    await tester.pumpWidget(const MyApp());

    // Verify "Select Language" AppBar title is present
    expect(find.text('Select Language'), findsOneWidget);

    // Verify English button is present
    expect(find.text('English'), findsOneWidget);

    // Verify Chichewa button is present
    expect(find.text('Chichewa'), findsOneWidget);
  });
}
