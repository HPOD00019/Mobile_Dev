// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'get_session_queary.dart';

class GetSessionQuearyMapper extends ClassMapperBase<GetSessionQueary> {
  GetSessionQuearyMapper._();

  static GetSessionQuearyMapper? _instance;
  static GetSessionQuearyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GetSessionQuearyMapper._());
      _t$_R0Mapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GetSessionQueary';

  static SessionId _$sessionId(GetSessionQueary v) => v.sessionId;
  static const Field<GetSessionQueary, SessionId> _f$sessionId = Field(
    'sessionId',
    _$sessionId,
  );

  @override
  final MappableFields<GetSessionQueary> fields = const {
    #sessionId: _f$sessionId,
  };

  static GetSessionQueary _instantiate(DecodingData data) {
    return GetSessionQueary(sessionId: data.dec(_f$sessionId));
  }

  @override
  final Function instantiate = _instantiate;

  static GetSessionQueary fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GetSessionQueary>(map);
  }

  static GetSessionQueary fromJson(String json) {
    return ensureInitialized().decodeJson<GetSessionQueary>(json);
  }
}

mixin GetSessionQuearyMappable {
  String toJson() {
    return GetSessionQuearyMapper.ensureInitialized()
        .encodeJson<GetSessionQueary>(this as GetSessionQueary);
  }

  Map<String, dynamic> toMap() {
    return GetSessionQuearyMapper.ensureInitialized()
        .encodeMap<GetSessionQueary>(this as GetSessionQueary);
  }

  GetSessionQuearyCopyWith<GetSessionQueary, GetSessionQueary, GetSessionQueary>
  get copyWith =>
      _GetSessionQuearyCopyWithImpl<GetSessionQueary, GetSessionQueary>(
        this as GetSessionQueary,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return GetSessionQuearyMapper.ensureInitialized().stringifyValue(
      this as GetSessionQueary,
    );
  }

  @override
  bool operator ==(Object other) {
    return GetSessionQuearyMapper.ensureInitialized().equalsValue(
      this as GetSessionQueary,
      other,
    );
  }

  @override
  int get hashCode {
    return GetSessionQuearyMapper.ensureInitialized().hashValue(
      this as GetSessionQueary,
    );
  }
}

extension GetSessionQuearyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GetSessionQueary, $Out> {
  GetSessionQuearyCopyWith<$R, GetSessionQueary, $Out>
  get $asGetSessionQueary =>
      $base.as((v, t, t2) => _GetSessionQuearyCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class GetSessionQuearyCopyWith<$R, $In extends GetSessionQueary, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({SessionId? sessionId});
  GetSessionQuearyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _GetSessionQuearyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GetSessionQueary, $Out>
    implements GetSessionQuearyCopyWith<$R, GetSessionQueary, $Out> {
  _GetSessionQuearyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GetSessionQueary> $mapper =
      GetSessionQuearyMapper.ensureInitialized();
  @override
  $R call({SessionId? sessionId}) =>
      $apply(FieldCopyWithData({if (sessionId != null) #sessionId: sessionId}));
  @override
  GetSessionQueary $make(CopyWithData data) =>
      GetSessionQueary(sessionId: data.get(#sessionId, or: $value.sessionId));

  @override
  GetSessionQuearyCopyWith<$R2, GetSessionQueary, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _GetSessionQuearyCopyWithImpl<$R2, $Out2>($value, $cast, t);
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

