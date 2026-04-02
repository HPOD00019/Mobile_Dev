import 'package:chess/core/utilities/result.dart';

abstract class UseCase<T, Params>{
  Future<Result<T, Failure>> call(Params params);
}
