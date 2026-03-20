import 'package:chess/application/queries/get_current_fen/get_current_fen_queary.dart';
import 'package:injectable/injectable.dart';
import 'package:streamline/streamline.dart';

@injectable
class GetCurrentFenQuearyHandler
    implements IQueryHandler<GetCurrentFenQueary, String> {
  @override
  Future<String> handle(GetCurrentFenQueary query) {
    // TODO: implement handle
    throw UnimplementedError();
  }
}
