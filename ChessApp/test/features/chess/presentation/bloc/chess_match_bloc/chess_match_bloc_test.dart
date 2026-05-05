import 'package:chess/core/utilities/result.dart';
import 'package:chess/features/chess/domain/models/chess_profile.dart';
import 'package:chess/features/chess/domain/models/elo.dart';
import 'package:chess/features/chess/domain/models/game_session.dart';
import 'package:chess/features/chess/domain/models/match_result.dart';
import 'package:chess/features/chess/domain/models/opponent.dart';
import 'package:chess/features/chess/domain/repository/i_bot_repository.dart';
import 'package:chess/features/chess/domain/repository/i_session_repository.dart';
import 'package:chess/features/chess/domain/usecases/get_opponent_turn_usecase.dart';
import 'package:chess/features/chess/domain/usecases/get_session_usecase.dart';
import 'package:chess/features/chess/domain/usecases/make_move_usecase.dart';
import 'package:chess/features/chess/domain/usecases/match_result_evaluate_usecase.dart';
import 'package:chess/features/chess/errors/failures.dart';
import 'package:chess/features/chess/presentation/bloc/chess_match_bloc/chess_match_bloc.dart';
import 'package:chess/features/chess/presentation/bloc/chess_match_bloc/events.dart';
import 'package:chess/features/chess/presentation/bloc/chess_match_bloc/states.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartchess/dartchess.dart';

import 'chess_match_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<MakeMoveUsecase>(),
  MockSpec<GetAppUserUsecase>(),
  MockSpec<ISessionRepository>(),
  MockSpec<IBotRepository>(),
  MockSpec<GetOpponentTurnUsecase>(),
  MockSpec<MatchResultEvaluateUseCase>(),
])
void main() {
  final dummyOpponentId = OpponentId.restore(uuid: 'dummy');
  final dummyAppUser = HumanOpponent(
    id: dummyOpponentId,
    displayName: 'dummy',
    profile: ChessProfile(elo: Elo(1000)),
  );
  final dummySession = GameSession.createNew(
    SessionOpponent(id: dummyOpponentId, type: OpponentType.player),
    SessionOpponent(id: dummyOpponentId, type: OpponentType.bot),
  );
  final dummyBot = BotOpponent(
    id: dummyOpponentId,
    displayName: 'dummy bot',
    difficulty: 1,
  );

  provideDummy<Result<HumanOpponent, GetAppUserFailure>>(Result.success(dummyAppUser));
  provideDummy<GameSession>(dummySession);
  provideDummy<BotOpponent>(dummyBot);
  provideDummy<Result<Position, ChessMoveFailure>>(Result.success(Chess.initial));
  provideDummy<Result<Move, GetOpponentTurnFailure>>(Result.success(NormalMove(from: Square.e2, to: Square.e4)));
  provideDummy<Result<MatchResult, MatchResultEvaluateFailure>>(Result.failure(const MatchResultEvaluateFailure(message: 'dummy')));

  late ChessMatchBloc bloc;
  late MockMakeMoveUsecase mockMakeMoveUsecase;
  late MockGetAppUserUsecase mockGetAppUserUsecase;
  late MockISessionRepository mockISessionRepository;
  late MockIBotRepository mockIBotRepository;
  late MockGetOpponentTurnUsecase mockGetOpponentTurnUsecase;
  late MockMatchResultEvaluateUseCase mockMatchResultEvaluateUseCase;

  setUp(() {
    mockMakeMoveUsecase = MockMakeMoveUsecase();
    mockGetAppUserUsecase = MockGetAppUserUsecase();
    mockISessionRepository = MockISessionRepository();
    mockIBotRepository = MockIBotRepository();
    mockGetOpponentTurnUsecase = MockGetOpponentTurnUsecase();
    mockMatchResultEvaluateUseCase = MockMatchResultEvaluateUseCase();

    bloc = ChessMatchBloc(
      makeMoveUsecase: mockMakeMoveUsecase,
      getAppUserUsecase: mockGetAppUserUsecase,
      sessions: mockISessionRepository,
      bots: mockIBotRepository,
      getOpponentTurnUsecase: mockGetOpponentTurnUsecase,
      matchResultEvaluateUseCase: mockMatchResultEvaluateUseCase,
    );
  });

  final tAppUser = HumanOpponent(
    id: OpponentId.restore(uuid: 'user1'),
    displayName: 'Test User',
    profile: ChessProfile(elo: Elo(1500)),
  );

  final tSessionId = SessionId.restore(uuid: '550e8400-e29b-41d4-a716-446655440000');
  
  final tSession = GameSession.createNew(
    SessionOpponent(id: OpponentId.restore(uuid: 'user1'), type: OpponentType.player),
    SessionOpponent(id: OpponentId.restore(uuid: 'bot1'), type: OpponentType.bot),
  );

  group('LoadMatchRequested', () {
    blocTest<ChessMatchBloc, ChessMatchBlocState>(
      'should emit MatchStateActive when loading is successful',
      build: () {
        when(mockGetAppUserUsecase(any)).thenAnswer((_) async => Result.success(tAppUser));
        when(mockISessionRepository.getById(any)).thenAnswer((_) async => tSession);
        // Also need to handle _restoreOpponent calls in bloc
        when(mockIBotRepository.getById(any)).thenAnswer((_) async => BotOpponent(
          id: OpponentId.restore(uuid: 'bot1'),
          displayName: 'Test Bot',
          difficulty: 1,
        ));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadMatchRequested(sessionId: tSessionId)),
      expect: () => [
        isA<MatchStateActive>(),
      ],
    );
  });
}
