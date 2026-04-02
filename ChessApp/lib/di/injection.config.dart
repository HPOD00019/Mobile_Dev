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

import '../application/commands/make_move/make_move_command_handler.dart'
    as _i681;
import '../application/commands/play_with_bot/play_with_bot_command_handler.dart'
    as _i170;
import '../application/queries/get_bot_by_difficulty/get_bot_by_difficulty_query_handler.dart'
    as _i750;
import '../application/queries/get_bots/get_bots_query_handler.dart' as _i202;
import '../application/queries/get_current_fen/get_current_fen_queary_handler.dart'
    as _i99;
import '../application/queries/get_session/get_session_by_id_queary_handler.dart'
    as _i96;
import '../application/state/application_storage.dart' as _i60;
import '../core/api/chess_api.dart' as _i793;
import '../persistence/bots_repository.dart' as _i982;
import '../persistence/sessions_repository.dart' as _i248;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i99.GetCurrentFenQuearyHandler>(
      () => _i99.GetCurrentFenQuearyHandler(),
    );
    gh.singleton<_i60.ApplicationStorage>(() => _i60.ApplicationStorage());
    gh.lazySingleton<_i793.ChessApi>(() => _i793.ChessApi());
    gh.lazySingleton<_i982.IBotsRepository>(
      () => _i982.PersistantBotsRepository(),
    );
    gh.lazySingleton<_i248.ISessionRepository>(
      () => _i248.OfflineSessionRepository(),
    );
    gh.factory<_i170.PlayWithBotCommandHandler>(
      () => _i170.PlayWithBotCommandHandler(gh<_i248.ISessionRepository>()),
    );
    gh.factory<_i681.MakeMoveCommandHandler>(
      () => _i681.MakeMoveCommandHandler(
        sessions: gh<_i248.ISessionRepository>(),
        appStorage: gh<_i60.ApplicationStorage>(),
      ),
    );
    gh.factory<_i750.GetBotByDifficultyQueryHandler>(
      () => _i750.GetBotByDifficultyQueryHandler(gh<_i982.IBotsRepository>()),
    );
    gh.factory<_i202.GetBotsQueryHandler>(
      () => _i202.GetBotsQueryHandler(gh<_i982.IBotsRepository>()),
    );
    gh.factory<_i96.GetSessionQuearyHandler>(
      () => _i96.GetSessionQuearyHandler(
        sessions: gh<_i248.ISessionRepository>(),
      ),
    );
    return this;
  }
}
