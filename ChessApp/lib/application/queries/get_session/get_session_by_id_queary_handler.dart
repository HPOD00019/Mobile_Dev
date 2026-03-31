
import 'package:chess/application/queries/get_session/get_session_by_id_queary.dart';
import 'package:chess/application/queries/get_session/responses/get_session_response.dart';
import 'package:chess/core/errors/session_errors.dart';
import 'package:chess/persistence/sessions_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:streamline/streamline.dart';

@injectable
final class GetSessionQuearyHandler
    implements IQueryHandler<GetSessionByIdQueary, GetSessionResponse> {
  const GetSessionQuearyHandler({required this.sessions});

  final ISessionRepository sessions;
  
  @override
  Future<GetSessionResponse> handle(GetSessionByIdQueary query) async {
    try {
      var session = sessions.getById(query.id);
      return Found(session: session);
    }
    on SessionNotFoundError {
      return NotFound();
    }
  }
}
