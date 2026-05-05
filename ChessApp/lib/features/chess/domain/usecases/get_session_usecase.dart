import 'package:chess/core/errors/failure.dart';
import 'package:chess/core/usecases/usecase.dart';
import 'package:chess/core/utilities/result.dart';
import 'package:chess/features/chess/domain/models/chess_profile.dart';
import 'package:chess/features/chess/domain/models/elo.dart';
import 'package:chess/features/chess/domain/models/opponent.dart';
import 'package:injectable/injectable.dart';

final class NoParams {}

final class GetAppUserFailure extends AppFailure{}

@lazySingleton
class GetAppUserUsecase extends UseCase<HumanOpponent, NoParams> {
  
  // TODO: Replace mock with actual authentificated user. (from UserRepository)
  final HumanOpponent _appUser = HumanOpponent(
    id: OpponentId.createNew(), 
    displayName: "Anonymus",
    profile: ChessProfile(elo: Elo(2000)));
  
  @override
  Future<Result<HumanOpponent, GetAppUserFailure>> call(NoParams params) async {
    return Result.success(_appUser);
  }
}
