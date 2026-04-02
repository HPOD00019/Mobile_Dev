import 'dart:math';
import 'package:equatable/equatable.dart';

final class Elo extends Equatable{
  const Elo(this.amount);
  final int amount;

  Elo operator +(Elo other) => Elo(max(0, amount + other.amount));
  Elo operator -(Elo other) => Elo(max(0, amount + other.amount));

  @override
  List<Object?> get props => [amount];
}
