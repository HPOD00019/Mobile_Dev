// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'get_session_by_id_queary.dart';

class GetSessionByIdQuearyMapper extends ClassMapperBase<GetSessionByIdQueary> {
  GetSessionByIdQuearyMapper._();

  static GetSessionByIdQuearyMapper? _instance;
  static GetSessionByIdQuearyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GetSessionByIdQuearyMapper._());
      _t$_R0Mapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GetSessionByIdQueary';

  static SessionId _$id(GetSessionByIdQueary v) => v.id;
  static const Field<GetSessionByIdQueary, SessionId> _f$id = Field('id', _$id);

  @override
  final MappableFields<GetSessionByIdQueary> fields = const {#id: _f$id};

  static GetSessionByIdQueary _instantiate(DecodingData data) {
    return GetSessionByIdQueary(id: data.dec(_f$id));
  }

  @override
  final Function instantiate = _instantiate;

  static GetSessionByIdQueary fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GetSessionByIdQueary>(map);
  }

  static GetSessionByIdQueary fromJson(String json) {
    return ensureInitialized().decodeJson<GetSessionByIdQueary>(json);
  }
}

mixin GetSessionByIdQuearyMappable {
  String toJson() {
    return GetSessionByIdQuearyMapper.ensureInitialized()
        .encodeJson<GetSessionByIdQueary>(this as GetSessionByIdQueary);
  }

  Map<String, dynamic> toMap() {
    return GetSessionByIdQuearyMapper.ensureInitialized()
        .encodeMap<GetSessionByIdQueary>(this as GetSessionByIdQueary);
  }

  GetSessionByIdQuearyCopyWith<
    GetSessionByIdQueary,
    GetSessionByIdQueary,
    GetSessionByIdQueary
  >
  get copyWith =>
      _GetSessionByIdQuearyCopyWithImpl<
        GetSessionByIdQueary,
        GetSessionByIdQueary
      >(this as GetSessionByIdQueary, $identity, $identity);
  @override
  String toString() {
    return GetSessionByIdQuearyMapper.ensureInitialized().stringifyValue(
      this as GetSessionByIdQueary,
    );
  }

  @override
  bool operator ==(Object other) {
    return GetSessionByIdQuearyMapper.ensureInitialized().equalsValue(
      this as GetSessionByIdQueary,
      other,
    );
  }

  @override
  int get hashCode {
    return GetSessionByIdQuearyMapper.ensureInitialized().hashValue(
      this as GetSessionByIdQueary,
    );
  }
}

extension GetSessionByIdQuearyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GetSessionByIdQueary, $Out> {
  GetSessionByIdQuearyCopyWith<$R, GetSessionByIdQueary, $Out>
  get $asGetSessionByIdQueary => $base.as(
    (v, t, t2) => _GetSessionByIdQuearyCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class GetSessionByIdQuearyCopyWith<
  $R,
  $In extends GetSessionByIdQueary,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({SessionId? id});
  GetSessionByIdQuearyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _GetSessionByIdQuearyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GetSessionByIdQueary, $Out>
    implements GetSessionByIdQuearyCopyWith<$R, GetSessionByIdQueary, $Out> {
  _GetSessionByIdQuearyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GetSessionByIdQueary> $mapper =
      GetSessionByIdQuearyMapper.ensureInitialized();
  @override
  $R call({SessionId? id}) =>
      $apply(FieldCopyWithData({if (id != null) #id: id}));
  @override
  GetSessionByIdQueary $make(CopyWithData data) =>
      GetSessionByIdQueary(id: data.get(#id, or: $value.id));

  @override
  GetSessionByIdQuearyCopyWith<$R2, GetSessionByIdQueary, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _GetSessionByIdQuearyCopyWithImpl<$R2, $Out2>($value, $cast, t);
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

