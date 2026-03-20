
import 'package:chess/application/commands/make_move/make_move_command.dart';
import 'package:injectable/injectable.dart';
import 'package:streamline/streamline.dart';

@injectable
final class MakeMoveCommandHandler implements ICommandHandler<MakeMoveCommand, String>{
  @override
  Future<String> handle(MakeMoveCommand command) {
    // TODO: implement make move handle
        
    // DO NOT FORGET ABOUT $emit(); TO NOTIFY UI ABOUT CHANGES
    throw UnimplementedError();
  }  
}
