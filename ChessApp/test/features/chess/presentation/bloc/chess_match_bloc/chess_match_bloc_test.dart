import 'package:chess/core/utilities/result.dart';
import 'package:chess/features/chess/domain/models/chess_profile.dart';
import 'package:chess/features/chess/domain/models/elo.dart';
import 'package:chess/features/chess/domain/models/game_session.dart';
import 'package:chess/features/chess/domain/models/match_result.dart';
import 'package:chess/features/chess/domain/models/match_state.dart';
import 'package:chess/features/chess/domain/models/opponent.dart';
import 'package:chess/features/chess/domain/repository/i_bot_repository.dart';
import 'package:chess/features/chess/domain/repository/i_session_repository.dart';
import 'package:chess/features/chess/domain/usecases/get_opponent_turn_usecase.dart';
import 'package:chess/features/chess/domain/usecases/get_session_usecase.dart';
import 'package:chess/features/chess/domain/usecases/make_move_usecase.dart';
import 'package:chess/features/chess/domain/usecases/match_result_evaluate_usecase.dart';
import 'package:chess/features/chess/errors/failures.dart' as failures;
import 'package:chess/features/chess/presentation/bloc/chess_match_bloc/chess_match_bloc.dart';
import 'package:chess/features/chess/presentation/bloc/chess_match_bloc/events.dart';
import 'package:chess/features/chess/presentation/bloc/chess_match_bloc/states.dart';
import 'package:chessground/chessground.dart';
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
  provideDummy<Result<Position, failures.ChessMoveFailure>>(Result.success(Chess.initial));
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

  test('initial state is EmptyState', () {
    expect(bloc.state, isA<EmptyState>());
  });

  group('LoadMatchRequested', () {
    blocTest<ChessMatchBloc, ChessMatchBlocState>(
      'should emit MatchStateActive when loading is successful',
      build: () {
        when(mockGetAppUserUsecase(any)).thenAnswer((_) async => Result.success(tAppUser));
        when(mockISessionRepository.getById(any)).thenAnswer((_) async => tSession);
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

    blocTest<ChessMatchBloc, ChessMatchBlocState>(
      'should emit InternalError when loading fails',
      build: () {
        when(mockGetAppUserUsecase(any)).thenThrow(Exception('Auth failed'));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadMatchRequested(sessionId: tSessionId)),
      expect: () => [isA<InternalError>()],
    );
  });

  group('MoveRequested', () {
    final tMatchState = MatchState(
      position: Chess.initial,
      userSide: PlayerSide.white,
      white: tAppUser,
      black: BotOpponent(
        id: OpponentId.restore(uuid: 'bot1'),
        displayName: 'Bot',
        difficulty: 5,
      ),
      relatedSessionId: tSessionId,
    );

    blocTest<ChessMatchBloc, ChessMatchBlocState>(
      'should emit MatchStateActive with updated position when move is successful',
      build: () {
        when(mockMakeMoveUsecase(any)).thenAnswer((_) async => Result.success(Chess.initial));
        when(mockISessionRepository.getById(any)).thenAnswer((_) async => tSession);
        return bloc;
      },
      seed: () => MatchStateActive(state: tMatchState),
      act: (bloc) => bloc.add(
        MoveRequested(
          move: NormalMove(from: Square.e2, to: Square.e4),
        ),
      ),
      expect: () => [isA<MatchStateActive>()],
    );

    blocTest<ChessMatchBloc, ChessMatchBlocState>(
      'should emit InternalError when move fails',
      build: () {
        when(mockMakeMoveUsecase(any)).thenAnswer((_) async => Result.failure(failures.UnknownChessMoveFailure(error: 'Invalid move')));
        return bloc;
      },
      seed: () => MatchStateActive(state: tMatchState),
      act: (bloc) => bloc.add(
        MoveRequested(
          move: NormalMove(from: Square.e2, to: Square.e4),
        ),
      ),
      expect: () => [isA<InternalError>()],
    );
  });

  group('TurnChanged', () {
    blocTest<ChessMatchBloc, ChessMatchBlocState>(
      'should emit MatchStateActive with bot move when it is bot turn',
      build: () {
        when(
          mockGetOpponentTurnUsecase.call(opponent: anyNamed('opponent'), position: anyNamed('position')),
        ).thenAnswer((_) async => Result.success(NormalMove(from: Square.e7, to: Square.e5)));
        when(mockMakeMoveUsecase(any)).thenAnswer((_) async => Result.success(Chess.initial));
        when(mockISessionRepository.getById(any)).thenAnswer((_) async => tSession);
        return bloc;
      },
      seed: () => MatchStateActive(
        state: MatchState(
          position: Chess.initial,
          userSide: PlayerSide.black,
          white: BotOpponent(
            id: OpponentId.restore(uuid: 'bot1'),
            displayName: 'Bot',
            difficulty: 5,
          ),
          black: tAppUser,
          relatedSessionId: tSessionId,
        ),
      ),
      act: (bloc) => bloc.add(const TurnChanged()),
      expect: () => [isA<MatchStateActive>()],
    );

    blocTest<ChessMatchBloc, ChessMatchBlocState>(
      'should emit MatchOverState when game is over',
      build: () {
        final matchResult = MatchResult(winner: null, loser: null, reason: 'Insufficient material');
        when(mockMatchResultEvaluateUseCase(any)).thenAnswer((_) async => Result.success(matchResult));
        return bloc;
      },
      seed: () => MatchStateActive(
        state: MatchState(
          position: Chess.fromSetup(Setup.parseFen('k7/8/8/8/8/8/8/7K w - - 0 1')),
          userSide: PlayerSide.white,
          white: tAppUser,
          black: BotOpponent(
            id: OpponentId.restore(uuid: 'bot1'),
            displayName: 'Bot',
            difficulty: 5,
          ),
          relatedSessionId: tSessionId,
        ),
      ),
      act: (bloc) => bloc.add(const TurnChanged()),
      wait: const Duration(milliseconds: 1200),
      expect: () => [isA<MatchOverState>()],
    );
  });
}
