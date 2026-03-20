// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'get_current_fen_queary.dart';

class GetCurrentFenQuearyMapper extends ClassMapperBase<GetCurrentFenQueary> {
  GetCurrentFenQuearyMapper._();

  static GetCurrentFenQuearyMapper? _instance;
  static GetCurrentFenQuearyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GetCurrentFenQuearyMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'GetCurrentFenQueary';

  static String _$sessionId(GetCurrentFenQueary v) => v.sessionId;
  static const Field<GetCurrentFenQueary, String> _f$sessionId = Field(
    'sessionId',
    _$sessionId,
  );

  @override
  final MappableFields<GetCurrentFenQueary> fields = const {
    #sessionId: _f$sessionId,
  };

  static GetCurrentFenQueary _instantiate(DecodingData data) {
    return GetCurrentFenQueary(sessionId: data.dec(_f$sessionId));
  }

  @override
  final Function instantiate = _instantiate;

  static GetCurrentFenQueary fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GetCurrentFenQueary>(map);
  }

  static GetCurrentFenQueary fromJson(String json) {
    return ensureInitialized().decodeJson<GetCurrentFenQueary>(json);
  }
}

mixin GetCurrentFenQuearyMappable {
  String toJson() {
    return GetCurrentFenQuearyMapper.ensureInitialized()
        .encodeJson<GetCurrentFenQueary>(this as GetCurrentFenQueary);
  }

  Map<String, dynamic> toMap() {
    return GetCurrentFenQuearyMapper.ensureInitialized()
        .encodeMap<GetCurrentFenQueary>(this as GetCurrentFenQueary);
  }

  GetCurrentFenQuearyCopyWith<
    GetCurrentFenQueary,
    GetCurrentFenQueary,
    GetCurrentFenQueary
  >
  get copyWith =>
      _GetCurrentFenQuearyCopyWithImpl<
        GetCurrentFenQueary,
        GetCurrentFenQueary
      >(this as GetCurrentFenQueary, $identity, $identity);
  @override
  String toString() {
    return GetCurrentFenQuearyMapper.ensureInitialized().stringifyValue(
      this as GetCurrentFenQueary,
    );
  }

  @override
  bool operator ==(Object other) {
    return GetCurrentFenQuearyMapper.ensureInitialized().equalsValue(
      this as GetCurrentFenQueary,
      other,
    );
  }

  @override
  int get hashCode {
    return GetCurrentFenQuearyMapper.ensureInitialized().hashValue(
      this as GetCurrentFenQueary,
    );
  }
}

extension GetCurrentFenQuearyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GetCurrentFenQueary, $Out> {
  GetCurrentFenQuearyCopyWith<$R, GetCurrentFenQueary, $Out>
  get $asGetCurrentFenQueary => $base.as(
    (v, t, t2) => _GetCurrentFenQuearyCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class GetCurrentFenQuearyCopyWith<
  $R,
  $In extends GetCurrentFenQueary,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? sessionId});
  GetCurrentFenQuearyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _GetCurrentFenQuearyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GetCurrentFenQueary, $Out>
    implements GetCurrentFenQuearyCopyWith<$R, GetCurrentFenQueary, $Out> {
  _GetCurrentFenQuearyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GetCurrentFenQueary> $mapper =
      GetCurrentFenQuearyMapper.ensureInitialized();
  @override
  $R call({String? sessionId}) =>
      $apply(FieldCopyWithData({if (sessionId != null) #sessionId: sessionId}));
  @override
  GetCurrentFenQueary $make(CopyWithData data) => GetCurrentFenQueary(
    sessionId: data.get(#sessionId, or: $value.sessionId),
  );

  @override
  GetCurrentFenQuearyCopyWith<$R2, GetCurrentFenQueary, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _GetCurrentFenQuearyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

