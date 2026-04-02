
import 'package:chess/core/models/app_user.dart';
import 'package:chess/core/models/chess_profile.dart';
import 'package:chess/core/models/common/name.dart';
import 'package:chess/core/utilities/result.dart';
import 'package:injectable/injectable.dart';
import 'package:streamline/streamline.dart';

@singleton
final class ApplicationStorage {

    ApplicationStorage() {
      assignUser();
    }

    // TODO: Should be sign-in or logged-in instead of force creation
    void assignUser() {
      
      var name = Name.create("Anonymus");  
      var profile = ChessProfile.createNew();  
      
      var appUser = AppUser.createNew(name.value, profile.value);
      user = appUser.when(success: (user) => Option.some(user), failure: (_) => Option.none());
    }
  
  Option<AppUser> user = Option.none();
}
