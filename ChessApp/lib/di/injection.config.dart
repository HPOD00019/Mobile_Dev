// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;

import '../features/chess/data/datasources/remote/api_client.dart' as _i259;
import '../features/chess/data/datasources/remote/chess_remote_datasource.dart'
    as _i481;
import '../features/chess/domain/repository/i_bot_repository.dart' as _i746;
import '../features/chess/domain/repository/i_session_repository.dart'
    as _i1022;
import '../features/chess/domain/usecases/create_match_usecase.dart' as _i399;
import '../features/chess/domain/usecases/get_bot_turn_usecase.dart' as _i118;
import '../features/chess/domain/usecases/get_opponent_turn_usecase.dart'
    as _i861;
import '../features/chess/domain/usecases/get_player_turn_usecase.dart' as _i3;
import '../features/chess/domain/usecases/get_session_usecase.dart' as _i1045;
import '../features/chess/domain/usecases/make_move_usecase.dart' as _i674;
import '../features/chess/domain/usecases/match_result_evaluate_usecase.dart'
    as _i286;
import '../features/chess/domain/usecases/start_match_usecase.dart' as _i1055;
import '../features/chess/domain/usecases/try_find_existing_match_usecase.dart'
    as _i821;
import '../features/chess/persistence/repository/bot_repository.dart' as _i1045;
import '../features/chess/persistence/repository/game_session_repository.dart'
    as _i448;
import '../features/chess/presentation/bloc/bot_select_bloc/bot_select_bloc.dart'
    as _i266;
import '../features/chess/presentation/bloc/chess_match_bloc/chess_match_bloc.dart'
    as _i361;
import 'bot_network_module.dart' as _i828;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i519.Client>(() => networkModule.httpClient);
    gh.lazySingleton<_i118.GetBotTurnUsecase>(() => _i118.GetBotTurnUsecase());
    gh.lazySingleton<_i3.GetPlayerTurnUsecase>(
      () => _i3.GetPlayerTurnUsecase(),
    );
    gh.lazySingleton<_i1045.GetAppUserUsecase>(
      () => _i1045.GetAppUserUsecase(),
    );
    gh.lazySingleton<_i674.MakeMoveUsecase>(() => _i674.MakeMoveUsecase());
    gh.lazySingleton<_i286.MatchResultEvaluateUseCase>(
      () => _i286.MatchResultEvaluateUseCase(),
    );
    gh.lazySingleton<_i1022.ISessionRepository>(
      () => _i448.GameSessionRepository(),
    );
    gh.lazySingleton<_i399.CreateMatchUseCase>(
      () => _i399.CreateMatchUseCase(
        sessionsRepository: gh<_i1022.ISessionRepository>(),
      ),
    );
    gh.lazySingleton<_i821.TryFindExistingMatchUseCase>(
      () => _i821.TryFindExistingMatchUseCase(
        sessionsRepository: gh<_i1022.ISessionRepository>(),
        getAppUserUsecase: gh<_i1045.GetAppUserUsecase>(),
      ),
    );
    gh.lazySingleton<_i746.IBotRepository>(() => _i1045.BotRepository());
    gh.lazySingleton<_i1055.StartMatchUseCase>(
      () => _i1055.StartMatchUseCase(
        botsRepository: gh<_i746.IBotRepository>(),
        sessionsRepository: gh<_i1022.ISessionRepository>(),
        getAppUserUsecase: gh<_i1045.GetAppUserUsecase>(),
      ),
    );
    gh.factory<_i266.BotSelectBloc>(
      () => _i266.BotSelectBloc(
        botsRepository: gh<_i746.IBotRepository>(),
        tryFindExistingMatchUseCase: gh<_i821.TryFindExistingMatchUseCase>(),
        createMatchUseCase: gh<_i399.CreateMatchUseCase>(),
        getAppUserUsecase: gh<_i1045.GetAppUserUsecase>(),
      ),
    );
    gh.lazySingleton<_i861.GetOpponentTurnUsecase>(
      () => _i861.GetOpponentTurnUsecase(
        getBotTurnUsecase: gh<_i118.GetBotTurnUsecase>(),
        getPlayerTurnUsecase: gh<_i3.GetPlayerTurnUsecase>(),
      ),
    );
    gh.lazySingleton<_i259.ApiClient>(
      () => networkModule.apiClient(gh<_i519.Client>()),
    );
    gh.lazySingleton<_i481.ChessRemoteDataSource>(
      () => networkModule.chessRemoteDataSource(gh<_i259.ApiClient>()),
    );
    gh.factory<_i361.ChessMatchBloc>(
      () => _i361.ChessMatchBloc(
        makeMoveUsecase: gh<_i674.MakeMoveUsecase>(),
        sessions: gh<_i1022.ISessionRepository>(),
        getAppUserUsecase: gh<_i1045.GetAppUserUsecase>(),
        bots: gh<_i746.IBotRepository>(),
        getOpponentTurnUsecase: gh<_i861.GetOpponentTurnUsecase>(),
        matchResultEvaluateUseCase: gh<_i286.MatchResultEvaluateUseCase>(),
      ),
    );
    return this;
  }
}

class _$NetworkModule extends _i828.NetworkModule {}
