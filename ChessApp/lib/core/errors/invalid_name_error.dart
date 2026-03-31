
final class InvalidNameError implements Exception {
  const InvalidNameError({required this.pattern});
  
  final String pattern;
  @override
  String toString() => 'Name should match regex: [$pattern]!';
}
