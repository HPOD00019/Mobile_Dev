import 'dart:collection';
import 'package:chess/core/errors/failure.dart';

final class ValidationErrors {
  final HashMap<String, HashSet<String>> _errors = HashMap();
  
  void addError(String prop, String error) {
    _errors[prop]?.add(error);
    if(_errors.containsKey(prop) == false){
      _errors[prop] = HashSet.from([error]);
    }
  }  
  
  Iterator<MapEntry<String, HashSet<String>>> get iterator => _errors.entries.iterator;
}

final class ValidationFailure extends AppFailure {
  const ValidationFailure({required this.errors});
  final ValidationErrors errors;
}
