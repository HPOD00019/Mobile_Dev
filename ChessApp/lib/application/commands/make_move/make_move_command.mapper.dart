// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'make_move_command.dart';

class MakeMoveCommandMapper extends ClassMapperBase<MakeMoveCommand> {
  MakeMoveCommandMapper._();

  static MakeMoveCommandMapper? _instance;
  static MakeMoveCommandMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MakeMoveCommandMapper._());
      _t$_R0Mapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MakeMoveCommand';

  static SessionId _$sessionId(MakeMoveCommand v) => v.sessionId;
  static const Field<MakeMoveCommand, SessionId> _f$sessionId = Field(
    'sessionId',
    _$sessionId,
  );
  static Move _$move(MakeMoveCommand v) => v.move;
  static const Field<MakeMoveCommand, Move> _f$move = Field('move', _$move);

  @override
  final MappableFields<MakeMoveCommand> fields = const {
    #sessionId: _f$sessionId,
    #move: _f$move,
  };

  static MakeMoveCommand _instantiate(DecodingData data) {
    return MakeMoveCommand(
      sessionId: data.dec(_f$sessionId),
      move: data.dec(_f$move),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MakeMoveCommand fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MakeMoveCommand>(map);
  }

  static MakeMoveCommand fromJson(String json) {
    return ensureInitialized().decodeJson<MakeMoveCommand>(json);
  }
}

mixin MakeMoveCommandMappable {
  String toJson() {
    return MakeMoveCommandMapper.ensureInitialized()
        .encodeJson<MakeMoveCommand>(this as MakeMoveCommand);
  }

  Map<String, dynamic> toMap() {
    return MakeMoveCommandMapper.ensureInitialized().encodeMap<MakeMoveCommand>(
      this as MakeMoveCommand,
    );
  }

  MakeMoveCommandCopyWith<MakeMoveCommand, MakeMoveCommand, MakeMoveCommand>
  get copyWith =>
      _MakeMoveCommandCopyWithImpl<MakeMoveCommand, MakeMoveCommand>(
        this as MakeMoveCommand,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return MakeMoveCommandMapper.ensureInitialized().stringifyValue(
      this as MakeMoveCommand,
    );
  }

  @override
  bool operator ==(Object other) {
    return MakeMoveCommandMapper.ensureInitialized().equalsValue(
      this as MakeMoveCommand,
      other,
    );
  }

  @override
  int get hashCode {
    return MakeMoveCommandMapper.ensureInitialized().hashValue(
      this as MakeMoveCommand,
    );
  }
}

extension MakeMoveCommandValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MakeMoveCommand, $Out> {
  MakeMoveCommandCopyWith<$R, MakeMoveCommand, $Out> get $asMakeMoveCommand =>
      $base.as((v, t, t2) => _MakeMoveCommandCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class MakeMoveCommandCopyWith<$R, $In extends MakeMoveCommand, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({SessionId? sessionId, Move? move});
  MakeMoveCommandCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _MakeMoveCommandCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MakeMoveCommand, $Out>
    implements MakeMoveCommandCopyWith<$R, MakeMoveCommand, $Out> {
  _MakeMoveCommandCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MakeMoveCommand> $mapper =
      MakeMoveCommandMapper.ensureInitialized();
  @override
  $R call({SessionId? sessionId, Move? move}) => $apply(
    FieldCopyWithData({
      if (sessionId != null) #sessionId: sessionId,
      if (move != null) #move: move,
    }),
  );
  @override
  MakeMoveCommand $make(CopyWithData data) => MakeMoveCommand(
    sessionId: data.get(#sessionId, or: $value.sessionId),
    move: data.get(#move, or: $value.move),
  );

  @override
  MakeMoveCommandCopyWith<$R2, MakeMoveCommand, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MakeMoveCommandCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

typedef _t$_R0<A> = ({A value});

class _t$_R0Mapper extends RecordMapperBase<_t$_R0> {
  static _t$_R0Mapper? _instance;
  _t$_R0Mapper._();

  static _t$_R0Mapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = _t$_R0Mapper._());
      MapperBase.addType(<A>(f) => f<({A value})>());
    }
    return _instance!;
  }

  static dynamic _$value(_t$_R0 v) => v.value;
  static dynamic _arg$value<A>(f) => f<A>();
  static const Field<_t$_R0, dynamic> _f$value = Field(
    'value',
    _$value,
    arg: _arg$value,
  );

  @override
  final MappableFields<_t$_R0> fields = const {#value: _f$value};

  @override
  Function get typeFactory =>
      <A>(f) => f<_t$_R0<A>>();

  static _t$_R0<A> _instantiate<A>(DecodingData<_t$_R0> data) {
    return (value: data.dec(_f$value));
  }

  @override
  final Function instantiate = _instantiate;

  static _t$_R0<A> fromMap<A>(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<_t$_R0<A>>(map);
  }

  static _t$_R0<A> fromJson<A>(String json) {
    return ensureInitialized().decodeJson<_t$_R0<A>>(json);
  }
}

