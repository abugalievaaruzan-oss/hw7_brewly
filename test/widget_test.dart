
import 'package:flutter_test/flutter_test.dart';
import 'package:hw7_brewly/hw7.dart';

void main() {
  testWidgets('Brewly app opens correctly', (tester) async {
    await tester.pumpWidget(const BrewlyApp());

    expect(find.text('BREWLY'), findsOneWidget);
    expect(find.text('Our Coffee'), findsOneWidget);
  });
}
