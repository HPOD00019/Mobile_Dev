import 'package:chess/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Full app flow: select bot and start game', (tester) async {
    // Load the app
    await tester.pumpWidget(const MainApp());
    await tester.pumpAndSettle();

    // Verify we are on the Bot Select screen
    expect(find.text('Choose Your Opponent'), findsOneWidget);

    // Find the list of bots and select one (e.g., the first one)
    final botItem = find.textContaining('Level').first;
    await tester.tap(botItem);
    await tester.pumpAndSettle();

    // Press 'Play' button
    final playButton = find.text('Play');
    await tester.tap(playButton);
    
    // Wait for the transition to Game screen
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Verify we are on the Game screen (check for chessboard or some game text)
    // Assuming the game screen has some identifier or unique text
    // Let's check if the AppBar title changed or if some widget is present
    // For now, just check that we are not on the select screen anymore
    expect(find.text('Choose Your Opponent'), findsNothing);
  });
}
