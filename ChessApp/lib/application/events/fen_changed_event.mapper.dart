// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'fen_changed_event.dart';

class GameFenChangedEventMapper extends ClassMapperBase<GameFenChangedEvent> {
  GameFenChangedEventMapper._();

  static GameFenChangedEventMapper? _instance;
  static GameFenChangedEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GameFenChangedEventMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'GameFenChangedEvent';

  static String _$sessionId(GameFenChangedEvent v) => v.sessionId;
  static const Field<GameFenChangedEvent, String> _f$sessionId = Field(
    'sessionId',
    _$sessionId,
  );
  static String _$fen(GameFenChangedEvent v) => v.fen;
  static const Field<GameFenChangedEvent, String> _f$fen = Field('fen', _$fen);

  @override
  final MappableFields<GameFenChangedEvent> fields = const {
    #sessionId: _f$sessionId,
    #fen: _f$fen,
  };

  static GameFenChangedEvent _instantiate(DecodingData data) {
    return GameFenChangedEvent(
      sessionId: data.dec(_f$sessionId),
      fen: data.dec(_f$fen),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static GameFenChangedEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameFenChangedEvent>(map);
  }

  static GameFenChangedEvent fromJson(String json) {
    return ensureInitialized().decodeJson<GameFenChangedEvent>(json);
  }
}

mixin GameFenChangedEventMappable {
  String toJson() {
    return GameFenChangedEventMapper.ensureInitialized()
        .encodeJson<GameFenChangedEvent>(this as GameFenChangedEvent);
  }

  Map<String, dynamic> toMap() {
    return GameFenChangedEventMapper.ensureInitialized()
        .encodeMap<GameFenChangedEvent>(this as GameFenChangedEvent);
  }

  GameFenChangedEventCopyWith<
    GameFenChangedEvent,
    GameFenChangedEvent,
    GameFenChangedEvent
  >
  get copyWith =>
      _GameFenChangedEventCopyWithImpl<
        GameFenChangedEvent,
        GameFenChangedEvent
      >(this as GameFenChangedEvent, $identity, $identity);
  @override
  String toString() {
    return GameFenChangedEventMapper.ensureInitialized().stringifyValue(
      this as GameFenChangedEvent,
    );
  }

  @override
  bool operator ==(Object other) {
    return GameFenChangedEventMapper.ensureInitialized().equalsValue(
      this as GameFenChangedEvent,
      other,
    );
  }

  @override
  int get hashCode {
    return GameFenChangedEventMapper.ensureInitialized().hashValue(
      this as GameFenChangedEvent,
    );
  }
}

extension GameFenChangedEventValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GameFenChangedEvent, $Out> {
  GameFenChangedEventCopyWith<$R, GameFenChangedEvent, $Out>
  get $asGameFenChangedEvent => $base.as(
    (v, t, t2) => _GameFenChangedEventCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class GameFenChangedEventCopyWith<
  $R,
  $In extends GameFenChangedEvent,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? sessionId, String? fen});
  GameFenChangedEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _GameFenChangedEventCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameFenChangedEvent, $Out>
    implements GameFenChangedEventCopyWith<$R, GameFenChangedEvent, $Out> {
  _GameFenChangedEventCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GameFenChangedEvent> $mapper =
      GameFenChangedEventMapper.ensureInitialized();
  @override
  $R call({String? sessionId, String? fen}) => $apply(
    FieldCopyWithData({
      if (sessionId != null) #sessionId: sessionId,
      if (fen != null) #fen: fen,
    }),
  );
  @override
  GameFenChangedEvent $make(CopyWithData data) => GameFenChangedEvent(
    sessionId: data.get(#sessionId, or: $value.sessionId),
    fen: data.get(#fen, or: $value.fen),
  );

  @override
  GameFenChangedEventCopyWith<$R2, GameFenChangedEvent, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _GameFenChangedEventCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

