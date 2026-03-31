
import 'package:chess/core/errors/chess_profile_errors/chess_profile.errors.dart';
import 'package:chess/core/models/elo.dart';
import 'package:chess/core/utilities/result.dart';
import 'package:uuid/uuid.dart';

final class ChessProfileId {
  const ChessProfileId._({required this.uuid});
  final String uuid;
  static ChessProfileId create() => ChessProfileId._(uuid: Uuid().v1());
}

final class ChessProfile {
  const ChessProfile._({required this.id, required this.elo});
  
  final ChessProfileId id;
  final Elo elo;
  
  static Result<ChessProfile, ChessProfileError> createNew() => _createValid(id: ChessProfileId.create(), elo: Elo.initial);
  
  Result<ChessProfile, ChessProfileError> withElo(Elo elo) => _createValid(id: id, elo: elo);
  
  static Result<ChessProfile, ChessProfileError> _createValid({required ChessProfileId id, required Elo elo}) {
    if(Uuid.isValidUUID(fromString: id.uuid) == false) Result.failure(InvalidProfileIdError());
    
    return Result.success(ChessProfile._(id: id, elo: elo));
  }
}
