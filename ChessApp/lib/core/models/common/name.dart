import 'package:chess/core/errors/invalid_name_error.dart';
import 'package:chess/core/utilities/result.dart';

final class Name {
  const Name._({required this.value});
  final String value;
  
  static Result<Name, InvalidNameError> create(String name) => _createValid(name: name);
  static Name forceCreate(String name) => Name._(value: name);
  
  static Result<Name, InvalidNameError> _createValid({required String name}){
    const pattern = r'';
    if(RegExp(pattern).hasMatch(name) == false) return Result.failure(InvalidNameError(pattern: pattern));
    return Result.success(Name._(value: name));
  }
}
