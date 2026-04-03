

import 'package:chess/di/injection.dart';
import 'package:chess/features/chess/domain/models/game_session.dart';
import 'package:chess/features/chess/presentation/bloc/chess_match_bloc/chess_match_bloc.dart';
import 'package:chess/ui/screens/match_screen/match_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class MatchPage extends StatelessWidget {
  const MatchPage({super.key, required this.sessionId});

  final SessionId sessionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChessMatchBloc>(
      create: (BuildContext context) => getIt.get<ChessMatchBloc>(),
      child: MatchScreen(sessionId: sessionId));
  }
}
