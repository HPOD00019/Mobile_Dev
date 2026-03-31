// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'leave_session_command.dart';

class LeaveSessionCommandMapper extends ClassMapperBase<LeaveSessionCommand> {
  LeaveSessionCommandMapper._();

  static LeaveSessionCommandMapper? _instance;
  static LeaveSessionCommandMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LeaveSessionCommandMapper._());
      _t$_R0Mapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LeaveSessionCommand';

  static SessionId _$sessionId(LeaveSessionCommand v) => v.sessionId;
  static const Field<LeaveSessionCommand, SessionId> _f$sessionId = Field(
    'sessionId',
    _$sessionId,
  );

  @override
  final MappableFields<LeaveSessionCommand> fields = const {
    #sessionId: _f$sessionId,
  };

  static LeaveSessionCommand _instantiate(DecodingData data) {
    return LeaveSessionCommand(sessionId: data.dec(_f$sessionId));
  }

  @override
  final Function instantiate = _instantiate;

  static LeaveSessionCommand fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LeaveSessionCommand>(map);
  }

  static LeaveSessionCommand fromJson(String json) {
    return ensureInitialized().decodeJson<LeaveSessionCommand>(json);
  }
}

mixin LeaveSessionCommandMappable {
  String toJson() {
    return LeaveSessionCommandMapper.ensureInitialized()
        .encodeJson<LeaveSessionCommand>(this as LeaveSessionCommand);
  }

  Map<String, dynamic> toMap() {
    return LeaveSessionCommandMapper.ensureInitialized()
        .encodeMap<LeaveSessionCommand>(this as LeaveSessionCommand);
  }

  LeaveSessionCommandCopyWith<
    LeaveSessionCommand,
    LeaveSessionCommand,
    LeaveSessionCommand
  >
  get copyWith =>
      _LeaveSessionCommandCopyWithImpl<
        LeaveSessionCommand,
        LeaveSessionCommand
      >(this as LeaveSessionCommand, $identity, $identity);
  @override
  String toString() {
    return LeaveSessionCommandMapper.ensureInitialized().stringifyValue(
      this as LeaveSessionCommand,
    );
  }

  @override
  bool operator ==(Object other) {
    return LeaveSessionCommandMapper.ensureInitialized().equalsValue(
      this as LeaveSessionCommand,
      other,
    );
  }

  @override
  int get hashCode {
    return LeaveSessionCommandMapper.ensureInitialized().hashValue(
      this as LeaveSessionCommand,
    );
  }
}

extension LeaveSessionCommandValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LeaveSessionCommand, $Out> {
  LeaveSessionCommandCopyWith<$R, LeaveSessionCommand, $Out>
  get $asLeaveSessionCommand => $base.as(
    (v, t, t2) => _LeaveSessionCommandCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LeaveSessionCommandCopyWith<
  $R,
  $In extends LeaveSessionCommand,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({SessionId? sessionId});
  LeaveSessionCommandCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LeaveSessionCommandCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LeaveSessionCommand, $Out>
    implements LeaveSessionCommandCopyWith<$R, LeaveSessionCommand, $Out> {
  _LeaveSessionCommandCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LeaveSessionCommand> $mapper =
      LeaveSessionCommandMapper.ensureInitialized();
  @override
  $R call({SessionId? sessionId}) =>
      $apply(FieldCopyWithData({if (sessionId != null) #sessionId: sessionId}));
  @override
  LeaveSessionCommand $make(CopyWithData data) => LeaveSessionCommand(
    sessionId: data.get(#sessionId, or: $value.sessionId),
  );

  @override
  LeaveSessionCommandCopyWith<$R2, LeaveSessionCommand, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LeaveSessionCommandCopyWithImpl<$R2, $Out2>($value, $cast, t);
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

