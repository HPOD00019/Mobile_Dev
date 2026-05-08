class MoveRequest {
  final String fen;
  final int elo;
  final int moveTime;

  const MoveRequest({
    required this.fen,
    this.elo = 2000,
    this.moveTime = 1000,
  });

  Map<String, dynamic> toJson() => {
        'fen': fen,
        'elo': elo,
        'moveTime': moveTime,
      };
}