// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../features/chess/domain/repository/i_bot_repository.dart' as _i746;
import '../features/chess/domain/repository/i_session_repository.dart'
    as _i1022;
import '../features/chess/domain/usecases/get_session_usecase.dart' as _i1045;
import '../features/chess/domain/usecases/make_move_usecase.dart' as _i674;
import '../features/chess/domain/usecases/start_match_usecase.dart' as _i1055;
import '../features/chess/persistence/repository/bot_repository.dart' as _i1045;
import '../features/chess/persistence/repository/game_session_repository.dart'
    as _i448;
import '../features/chess/presentation/bloc/bot_select_bloc/bot_select_bloc.dart'
    as _i266;
import '../features/chess/presentation/bloc/chess_match_bloc/chess_match_bloc.dart'
    as _i361;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i1045.GetAppUserUsecase>(
      () => _i1045.GetAppUserUsecase(),
    );
    gh.lazySingleton<_i674.MakeMoveUsecase>(() => _i674.MakeMoveUsecase());
    gh.lazySingleton<_i1022.ISessionRepository>(
      () => _i448.GameSessionRepository(),
    );
    gh.lazySingleton<_i746.IBotRepository>(() => _i1045.BotRepository());
    gh.lazySingleton<_i1055.StartMatchUseCase>(
      () => _i1055.StartMatchUseCase(
        botsRepository: gh<_i746.IBotRepository>(),
        sessionsRepository: gh<_i1022.ISessionRepository>(),
        getAppUserUsecase: gh<_i1045.GetAppUserUsecase>(),
      ),
    );
    gh.factory<_i361.ChessMatchBloc>(
      () => _i361.ChessMatchBloc(
        makeMoveUsecase: gh<_i674.MakeMoveUsecase>(),
        sessions: gh<_i1022.ISessionRepository>(),
        getAppUserUsecase: gh<_i1045.GetAppUserUsecase>(),
        bots: gh<_i746.IBotRepository>(),
      ),
    );
    gh.factory<_i266.BotSelectBloc>(
      () => _i266.BotSelectBloc(
        botsRepository: gh<_i746.IBotRepository>(),
        sessionsRepository: gh<_i1022.ISessionRepository>(),
        getAppUserUsecase: gh<_i1045.GetAppUserUsecase>(),
        startMatchUseCase: gh<_i1055.StartMatchUseCase>(),
      ),
    );
    return this;
  }
}
