// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'play_with_bot_command.dart';

class PlayWithBotCommandMapper extends ClassMapperBase<PlayWithBotCommand> {
  PlayWithBotCommandMapper._();

  static PlayWithBotCommandMapper? _instance;
  static PlayWithBotCommandMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PlayWithBotCommandMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PlayWithBotCommand';

  static BuildContext _$context(PlayWithBotCommand v) => v.context;
  static const Field<PlayWithBotCommand, BuildContext> _f$context = Field(
    'context',
    _$context,
  );
  static BotOpponent _$bot(PlayWithBotCommand v) => v.bot;
  static const Field<PlayWithBotCommand, BotOpponent> _f$bot = Field(
    'bot',
    _$bot,
  );

  @override
  final MappableFields<PlayWithBotCommand> fields = const {
    #context: _f$context,
    #bot: _f$bot,
  };

  static PlayWithBotCommand _instantiate(DecodingData data) {
    return PlayWithBotCommand(
      context: data.dec(_f$context),
      bot: data.dec(_f$bot),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PlayWithBotCommand fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PlayWithBotCommand>(map);
  }

  static PlayWithBotCommand fromJson(String json) {
    return ensureInitialized().decodeJson<PlayWithBotCommand>(json);
  }
}

mixin PlayWithBotCommandMappable {
  String toJson() {
    return PlayWithBotCommandMapper.ensureInitialized()
        .encodeJson<PlayWithBotCommand>(this as PlayWithBotCommand);
  }

  Map<String, dynamic> toMap() {
    return PlayWithBotCommandMapper.ensureInitialized()
        .encodeMap<PlayWithBotCommand>(this as PlayWithBotCommand);
  }

  PlayWithBotCommandCopyWith<
    PlayWithBotCommand,
    PlayWithBotCommand,
    PlayWithBotCommand
  >
  get copyWith =>
      _PlayWithBotCommandCopyWithImpl<PlayWithBotCommand, PlayWithBotCommand>(
        this as PlayWithBotCommand,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PlayWithBotCommandMapper.ensureInitialized().stringifyValue(
      this as PlayWithBotCommand,
    );
  }

  @override
  bool operator ==(Object other) {
    return PlayWithBotCommandMapper.ensureInitialized().equalsValue(
      this as PlayWithBotCommand,
      other,
    );
  }

  @override
  int get hashCode {
    return PlayWithBotCommandMapper.ensureInitialized().hashValue(
      this as PlayWithBotCommand,
    );
  }
}

extension PlayWithBotCommandValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PlayWithBotCommand, $Out> {
  PlayWithBotCommandCopyWith<$R, PlayWithBotCommand, $Out>
  get $asPlayWithBotCommand => $base.as(
    (v, t, t2) => _PlayWithBotCommandCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class PlayWithBotCommandCopyWith<
  $R,
  $In extends PlayWithBotCommand,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({BuildContext? context, BotOpponent? bot});
  PlayWithBotCommandCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PlayWithBotCommandCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PlayWithBotCommand, $Out>
    implements PlayWithBotCommandCopyWith<$R, PlayWithBotCommand, $Out> {
  _PlayWithBotCommandCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PlayWithBotCommand> $mapper =
      PlayWithBotCommandMapper.ensureInitialized();
  @override
  $R call({BuildContext? context, BotOpponent? bot}) => $apply(
    FieldCopyWithData({
      if (context != null) #context: context,
      if (bot != null) #bot: bot,
    }),
  );
  @override
  PlayWithBotCommand $make(CopyWithData data) => PlayWithBotCommand(
    context: data.get(#context, or: $value.context),
    bot: data.get(#bot, or: $value.bot),
  );

  @override
  PlayWithBotCommandCopyWith<$R2, PlayWithBotCommand, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PlayWithBotCommandCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

