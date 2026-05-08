import 'package:chess/core/utilities/result.dart';
import 'package:chess/features/chess/domain/models/chess_profile.dart';
import 'package:chess/features/chess/domain/models/elo.dart';
import 'package:chess/features/chess/domain/models/game_session.dart';
import 'package:chess/features/chess/domain/models/opponent.dart';
import 'package:chess/features/chess/domain/repository/i_bot_repository.dart';
import 'package:chess/features/chess/domain/usecases/create_match_usecase.dart';
import 'package:chess/features/chess/domain/usecases/get_session_usecase.dart';
import 'package:chess/features/chess/domain/usecases/try_find_existing_match_usecase.dart';
import 'package:chess/features/chess/presentation/bloc/bot_select_bloc/bot_select_bloc.dart';
import 'package:chess/features/chess/presentation/bloc/bot_select_bloc/events.dart';
import 'package:chess/features/chess/presentation/bloc/bot_select_bloc/states.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'bot_select_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<IBotRepository>(),
  MockSpec<TryFindExistingMatchUseCase>(),
  MockSpec<CreateMatchUseCase>(),
  MockSpec<GetAppUserUsecase>(),
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

  provideDummy<Result<HumanOpponent, GetAppUserFailure>>(Result.success(dummyAppUser));
  provideDummy<Result<GameSession, FindExistingMatchFailure>>(Result.success(dummySession));
  provideDummy<Result<SessionId, CreateMatchFailure>>(Result.success(SessionId.restore(uuid: '550e8400-e29b-41d4-a716-446655440000')));

  late BotSelectBloc bloc;
  late MockIBotRepository mockBotRepository;
  late MockTryFindExistingMatchUseCase mockTryFindExistingMatchUseCase;
  late MockCreateMatchUseCase mockCreateMatchUseCase;
  late MockGetAppUserUsecase mockGetAppUserUsecase;

  setUp(() {
    mockBotRepository = MockIBotRepository();
    mockTryFindExistingMatchUseCase = MockTryFindExistingMatchUseCase();
    mockCreateMatchUseCase = MockCreateMatchUseCase();
    mockGetAppUserUsecase = MockGetAppUserUsecase();

    bloc = BotSelectBloc(
      botsRepository: mockBotRepository,
      tryFindExistingMatchUseCase: mockTryFindExistingMatchUseCase,
      createMatchUseCase: mockCreateMatchUseCase,
      getAppUserUsecase: mockGetAppUserUsecase,
    );
  });

  test('initial state is BotSelectInitial', () {
    expect(bloc.state, const BotSelectInitial());
  });

  group('BotOptionsRequested', () {
    final bots = {
      BotOpponent(
        id: OpponentId.restore(uuid: 'bot1'),
        displayName: 'Easy Bot',
        difficulty: 1,
        thinkingTime: 1,
        depth: 1,
      ),
      BotOpponent(
        id: OpponentId.restore(uuid: 'bot2'),
        displayName: 'Hard Bot',
        difficulty: 9,
        thinkingTime: 1,
        depth: 1,
      ),
    };

    blocTest<BotSelectBloc, BotSelectBlocState>(
      'should emit [BotsLoading, BotsLoaded] when successful',
      build: () {
        when(mockBotRepository.getAll()).thenAnswer((_) async => bots);
        return bloc;
      },
      act: (bloc) => bloc.add(const BotOptionsRequested()),
      expect: () => [
        const BotsLoading(),
        isA<BotsLoaded>(),
      ],
    );

    blocTest<BotSelectBloc, BotSelectBlocState>(
      'should emit [BotsLoading, BotSelectError] when it fails',
      build: () {
        when(mockBotRepository.getAll()).thenThrow(Exception('Network error'));
        return bloc;
      },
      act: (bloc) => bloc.add(const BotOptionsRequested()),
      expect: () => [
        const BotsLoading(),
        isA<BotSelectError>(),
      ],
    );
  });

  group('BotSelected', () {
    final bot1 = BotOpponent(
      id: OpponentId.restore(uuid: 'bot1'),
      displayName: 'Bot1',
      difficulty: 1,
      thinkingTime: 1,
      depth: 1,
    );
    final bot2 = BotOpponent(
      id: OpponentId.restore(uuid: 'bot2'),
      displayName: 'Bot2',
      difficulty: 5,
      thinkingTime: 1,
      depth: 1,
    );

    blocTest<BotSelectBloc, BotSelectBlocState>(
      'should emit BotsLoaded with new selected bot',
      build: () => bloc,
      seed: () => BotsLoaded(bots: {bot1, bot2}, selectedBot: bot1),
      act: (bloc) => bloc.add(BotSelected(bot: bot2)),
      expect: () => [
        isA<BotsLoaded>().having((s) => s.selectedBot, 'selectedBot', bot2),
      ],
    );
  });

  group('MatchRequested', () {
    final bot = BotOpponent(
      id: OpponentId.restore(uuid: 'bot1'),
      displayName: 'TestBot',
      difficulty: 3,
      thinkingTime: 1,
      depth: 1,
    );
    final appUser = HumanOpponent(
      id: OpponentId.restore(uuid: 'user1'),
      displayName: 'Player',
      profile: ChessProfile(elo: Elo(1500)),
    );

    blocTest<BotSelectBloc, BotSelectBlocState>(
      'should emit MatchReady when no existing match is found and creation is successful',
      build: () {
        when(mockTryFindExistingMatchUseCase(any)).thenAnswer((_) async => Result.failure(const NoActiveMatch()));
        when(mockGetAppUserUsecase(any)).thenAnswer((_) async => Result.success(appUser));
        when(mockCreateMatchUseCase(white: anyNamed('white'), black: anyNamed('black')))
            .thenAnswer((_) async => Result.success(SessionId.restore(uuid: '550e8400-e29b-41d4-a716-446655440000')));
        return bloc;
      },
      act: (bloc) => bloc.add(MatchRequested(bot: bot)),
      expect: () => [
        isA<MatchReady>(),
      ],
    );
  });
}
