class MoveResponse {
  final String bestMove; // например "e2e4"
  final int? evaluation;

  const MoveResponse({
    required this.bestMove,
    this.evaluation,
  });

  factory MoveResponse.fromJson(Map<String, dynamic> json) {
    return MoveResponse(
      bestMove: json['bestMove'] as String? ?? '',
      evaluation: json['evaluation'] as int?,
    );
  }
}