import 'package:aplicatie_calorii/src/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app builds', (tester) async {
    await tester.pumpWidget(const CalorieTrackerApp());
    expect(find.text('Onboarding'), findsOneWidget);
  });
}
