import 'package:chess/features/chess/domain/models/match_result.dart';
import 'package:chess/features/chess/domain/models/opponent.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final class MatchResultScreen extends StatelessWidget {
  const MatchResultScreen({super.key, required this.result});

  final MatchResult result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Match Over',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                result.reason,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 48),
              _OpponentPortraits(result: result),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  context.pop();
                },
                child: const Text('Back to Menu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class AnimatedMatchOverScreen extends StatefulWidget {
  const AnimatedMatchOverScreen({super.key, required this.result});

  final MatchResult result;

  @override
  State<AnimatedMatchOverScreen> createState() => _AnimatedMatchOverScreenState();
}

final class _AnimatedMatchOverScreenState extends State<AnimatedMatchOverScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: MatchResultScreen(result: widget.result),
      ),
    );
  }
}

final class _OpponentPortraits extends StatelessWidget {
  const _OpponentPortraits({required this.result});

  final MatchResult result;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _OpponentPortrait(
          opponent: result.winner,
          isWinner: true,
        ),
        const SizedBox(width: 32),
        _ScoreDisplay(result: result),
        const SizedBox(width: 32),
        _OpponentPortrait(
          opponent: result.loser,
          isWinner: false,
        ),
      ],
    );
  }
}

final class _OpponentPortrait extends StatelessWidget {
  const _OpponentPortrait({
    required this.opponent,
    required this.isWinner,
  });

  final Opponent? opponent;
  final bool isWinner;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isWinner ? Colors.green : Colors.red,
          width: 3,
        ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isWinner ? Icons.emoji_events : Icons.person_off,
            size: 48,
            color: isWinner ? Colors.amber : Colors.grey,
          ),
          const SizedBox(height: 12),
          Text(
            opponent?.displayName ?? 'Draw',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

final class _ScoreDisplay extends StatelessWidget {
  const _ScoreDisplay({required this.result});

  final MatchResult result;

  @override
  Widget build(BuildContext context) {
    return Text(
      result.isDraw ? '½ : ½' : '1 : 0',
      style: const TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
