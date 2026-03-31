
import 'package:chess/core/errors/app_user_errors/app_user_error.dart';
import 'package:chess/core/models/chess_profile.dart';
import 'package:chess/core/models/common/name.dart';
import 'package:chess/core/models/opponent.dart';
import 'package:chess/core/utilities/result.dart';
import 'package:dartchess/dartchess.dart';
import 'package:uuid/uuid.dart';

final class UserId {
  const UserId._({required this.uuid}); 
  final String uuid;
  static UserId create() => UserId._(uuid: Uuid().v1());
}

final class AppUser {
  const AppUser._({required this.id, required this.name, required this.profile});
  
  final UserId id;
  final Name name;
  final ChessProfile profile;
  
  static Result<AppUser, AppUserError> createNew(Name name, ChessProfile profile) => _createValid(id: UserId.create(), name: name, profile: profile);
  static AppUser forceCreate(String name, ChessProfile profile) => AppUser._(id: UserId.create(), name: Name.forceCreate(name), profile: profile);
  
  static Result<AppUser, AppUserError> _createValid({required UserId id, required Name name, required ChessProfile profile}) {
    if(Uuid.isValidUUID(fromString: id.uuid) == false) return Result.failure(InvalidUserIdError());
       
    return Result.success(AppUser._(id: id, name: name, profile: profile));
  }
}

extension UserExtensions on AppUser {
  Opponent asOpponent(Side color){
    return HumanOpponent(displayName: name, profile: profile).withColor(color);
  } 
}

