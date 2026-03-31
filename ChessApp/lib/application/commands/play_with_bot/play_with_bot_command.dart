import 'package:chess/core/models/opponent.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:streamline/streamline.dart';

part 'play_with_bot_command.mapper.dart';

@MappableClass()
class PlayWithBotCommand
  with PlayWithBotCommandMappable
  implements ICommand<void> {

  const PlayWithBotCommand({required this.context, required this.bot});

  final BuildContext context;
  final BotOpponent bot;
}
