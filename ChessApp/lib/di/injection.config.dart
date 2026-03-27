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

import '../application/commands/confirm_bot_selection/play_with_bot_command_handler.dart'
    as _i378;
import '../application/commands/make_move/make_move_command_handler.dart'
    as _i681;
import '../application/queries/get_bots/get_bots_query_handler.dart' as _i202;
import '../application/queries/get_current_fen/get_current_fen_queary_handler.dart'
    as _i99;
import '../application/queries/get_opponent/get_opponent_query_handler.dart'
    as _i293;
import '../application/queries/get_session/get_session_queary_handler.dart'
    as _i326;
import '../application/state/opponent_provider.dart' as _i626;
import '../core/api/chess_api.dart' as _i793;
import '../persistence/bots_repository.dart' as _i982;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i681.MakeMoveCommandHandler>(
      () => _i681.MakeMoveCommandHandler(),
    );
    gh.factory<_i99.GetCurrentFenQuearyHandler>(
      () => _i99.GetCurrentFenQuearyHandler(),
    );
    gh.factory<_i326.GetSessionQuearyHandler>(
      () => _i326.GetSessionQuearyHandler(),
    );
    gh.lazySingleton<_i793.ChessApi>(() => _i793.ChessApi());
    gh.lazySingleton<_i982.IBotsRepository>(
      () => _i982.PersistantBotsRepository(),
    );
    gh.lazySingleton<_i626.IOpponentProvider>(() => _i626.OpponentProvider());
    gh.factory<_i378.PlayWithBotCommandHandler>(
      () => _i378.PlayWithBotCommandHandler(gh<_i626.IOpponentProvider>()),
    );
    gh.factory<_i293.GetOpponentQueryHandler>(
      () => _i293.GetOpponentQueryHandler(gh<_i626.IOpponentProvider>()),
    );
    gh.factory<_i202.GetBotsQueryHandler>(
      () => _i202.GetBotsQueryHandler(gh<_i982.IBotsRepository>()),
    );
    return this;
  }
}
