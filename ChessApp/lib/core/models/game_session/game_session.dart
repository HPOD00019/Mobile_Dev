import 'package:chess/core/models/fen.dart';
import 'package:chess/core/models/opponent.dart';
import 'package:chessground/chessground.dart';
import 'package:dartchess/dartchess.dart';
import 'package:flutter/material.dart';
import 'package:streamline/streamline.dart';
import 'package:uuid/uuid.dart';

typedef SessionId = ({String value});

enum GameStatus { active, completed }

@immutable
final class GameSession {
  final SessionId sessionId;
  final Side turn;
  final GameStatus status;
  final Option<Side> winner;
  final Fen fen;
  final Opponent white;
  final Opponent black;
  final PlayerSide userSide;

  const GameSession._({
    required this.sessionId,
    required this.turn,
    required this.status,
    required this.winner,
    required this.fen,
    required this.white,
    required this.black,
    required this.userSide,
  });

  static GameSession create({
    required Opponent white,
    required Opponent black,
    required PlayerSide userSide,
  }) => GameSession._(
    sessionId: (value: Uuid().v1()),
    turn: Side.white,
    status: GameStatus.active,
    winner: Option.none(),
    fen: Fen.initial,
    white: white,
    black: black,
    userSide: userSide,
  );

  GameSession copyWith({
    SessionId? sessionId,
    Side? turn,
    GameStatus? status,
    Option<Side>? winner,
    Fen? fen,
    Opponent? white,
    Opponent? black,
    PlayerSide? userSide,
  }) => GameSession._(
    sessionId: sessionId ?? this.sessionId,
    turn: turn ?? this.turn,
    status: status ?? this.status,
    winner: winner ?? this.winner,
    fen: fen ?? this.fen,
    white: white ?? this.white,
    black: black ?? this.black,
    userSide: userSide ?? this.userSide,
  );

  @override
  String toString() => "[Session: $sessionId] [$turn's turn] [Status: $status] [User side: $userSide] [fen: ${fen.value}]";
}


