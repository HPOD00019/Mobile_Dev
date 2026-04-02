import 'package:chess/core/utilities/result.dart';
import 'package:chess/core/errors/failure.dart';

abstract class UseCase<T, Params>{
  const UseCase();
  Future<Result<T, AppFailure>> call(Params params);
}



