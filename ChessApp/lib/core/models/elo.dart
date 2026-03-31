import 'dart:math';

final class Elo {
  const Elo._({required this.amount});
  
  final double amount;
  
  static const Elo initial = Elo._(amount: 2000);
    
  Elo operator +(double amount) => Elo._(amount: max(0, (this.amount + amount)));
  Elo operator -(double amount) => Elo._(amount: max(0, (this.amount - amount)));
}
