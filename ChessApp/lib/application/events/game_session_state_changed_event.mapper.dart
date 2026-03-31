// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'game_session_state_changed_event.dart';

class GameSessionStateChangedEventMapper
    extends ClassMapperBase<GameSessionStateChangedEvent> {
  GameSessionStateChangedEventMapper._();

  static GameSessionStateChangedEventMapper? _instance;
  static GameSessionStateChangedEventMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = GameSessionStateChangedEventMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'GameSessionStateChangedEvent';

  @override
  final MappableFields<GameSessionStateChangedEvent> fields = const {};

  static GameSessionStateChangedEvent _instantiate(DecodingData data) {
    return GameSessionStateChangedEvent();
  }

  @override
  final Function instantiate = _instantiate;

  static GameSessionStateChangedEvent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GameSessionStateChangedEvent>(map);
  }

  static GameSessionStateChangedEvent fromJson(String json) {
    return ensureInitialized().decodeJson<GameSessionStateChangedEvent>(json);
  }
}

mixin GameSessionStateChangedEventMappable {
  String toJson() {
    return GameSessionStateChangedEventMapper.ensureInitialized()
        .encodeJson<GameSessionStateChangedEvent>(
          this as GameSessionStateChangedEvent,
        );
  }

  Map<String, dynamic> toMap() {
    return GameSessionStateChangedEventMapper.ensureInitialized()
        .encodeMap<GameSessionStateChangedEvent>(
          this as GameSessionStateChangedEvent,
        );
  }

  GameSessionStateChangedEventCopyWith<
    GameSessionStateChangedEvent,
    GameSessionStateChangedEvent,
    GameSessionStateChangedEvent
  >
  get copyWith =>
      _GameSessionStateChangedEventCopyWithImpl<
        GameSessionStateChangedEvent,
        GameSessionStateChangedEvent
      >(this as GameSessionStateChangedEvent, $identity, $identity);
  @override
  String toString() {
    return GameSessionStateChangedEventMapper.ensureInitialized()
        .stringifyValue(this as GameSessionStateChangedEvent);
  }

  @override
  bool operator ==(Object other) {
    return GameSessionStateChangedEventMapper.ensureInitialized().equalsValue(
      this as GameSessionStateChangedEvent,
      other,
    );
  }

  @override
  int get hashCode {
    return GameSessionStateChangedEventMapper.ensureInitialized().hashValue(
      this as GameSessionStateChangedEvent,
    );
  }
}

extension GameSessionStateChangedEventValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GameSessionStateChangedEvent, $Out> {
  GameSessionStateChangedEventCopyWith<$R, GameSessionStateChangedEvent, $Out>
  get $asGameSessionStateChangedEvent => $base.as(
    (v, t, t2) => _GameSessionStateChangedEventCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class GameSessionStateChangedEventCopyWith<
  $R,
  $In extends GameSessionStateChangedEvent,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  GameSessionStateChangedEventCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _GameSessionStateChangedEventCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GameSessionStateChangedEvent, $Out>
    implements
        GameSessionStateChangedEventCopyWith<
          $R,
          GameSessionStateChangedEvent,
          $Out
        > {
  _GameSessionStateChangedEventCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<GameSessionStateChangedEvent> $mapper =
      GameSessionStateChangedEventMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  GameSessionStateChangedEvent $make(CopyWithData data) =>
      GameSessionStateChangedEvent();

  @override
  GameSessionStateChangedEventCopyWith<$R2, GameSessionStateChangedEvent, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _GameSessionStateChangedEventCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

