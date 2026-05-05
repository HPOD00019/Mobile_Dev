import 'package:chess/features/chess/domain/models/opponent.dart';
import 'package:chess/features/chess/presentation/bloc/bot_select_bloc/bot_select_bloc.dart';
import 'package:chess/features/chess/presentation/bloc/bot_select_bloc/states.dart';
import 'package:chess/ui/screens/bot_select_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'bot_select_screen_test.mocks.dart';

@GenerateNiceMocks([MockSpec<BotSelectBloc>()])
void main() {
  late MockBotSelectBloc mockBloc;

  setUp(() {
    mockBloc = MockBotSelectBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<BotSelectBloc>.value(
        value: mockBloc,
        child: const BotSelectScreen(),
      ),
    );
  }

  testWidgets('should display loading indicator when state is BotsLoading', (WidgetTester tester) async {
    // Arrange
    when(mockBloc.state).thenReturn(const BotsLoading());
    when(mockBloc.stream).thenAnswer((_) => const Stream.empty());

    // Act
    await tester.pumpWidget(createWidgetUnderTest());

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should display bots list when state is BotsLoaded', (WidgetTester tester) async {
    // Arrange
    final bot = BotOpponent(
      id: OpponentId.restore(uuid: 'bot1'),
      displayName: 'Easy Bot',
      difficulty: 1,
    );
    when(mockBloc.state).thenReturn(BotsLoaded(bots: {bot}, selectedBot: bot));
    when(mockBloc.stream).thenAnswer((_) => const Stream.empty());

    // Act
    await tester.pumpWidget(createWidgetUnderTest());

    // Assert
    expect(find.text('Bot Easy Bot: Level 1'), findsOneWidget);
    expect(find.text('Easy'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
  });
}
