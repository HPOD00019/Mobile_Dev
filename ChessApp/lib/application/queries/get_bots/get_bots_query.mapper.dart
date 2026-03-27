// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'get_bots_query.dart';

class GetBotsQueryMapper extends ClassMapperBase<GetBotsQuery> {
  GetBotsQueryMapper._();

  static GetBotsQueryMapper? _instance;
  static GetBotsQueryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GetBotsQueryMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'GetBotsQuery';

  @override
  final MappableFields<GetBotsQuery> fields = const {};

  static GetBotsQuery _instantiate(DecodingData data) {
    return GetBotsQuery();
  }

  @override
  final Function instantiate = _instantiate;

  static GetBotsQuery fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GetBotsQuery>(map);
  }

  static GetBotsQuery fromJson(String json) {
    return ensureInitialized().decodeJson<GetBotsQuery>(json);
  }
}

mixin GetBotsQueryMappable {
  String toJson() {
    return GetBotsQueryMapper.ensureInitialized().encodeJson<GetBotsQuery>(
      this as GetBotsQuery,
    );
  }

  Map<String, dynamic> toMap() {
    return GetBotsQueryMapper.ensureInitialized().encodeMap<GetBotsQuery>(
      this as GetBotsQuery,
    );
  }

  GetBotsQueryCopyWith<GetBotsQuery, GetBotsQuery, GetBotsQuery> get copyWith =>
      _GetBotsQueryCopyWithImpl<GetBotsQuery, GetBotsQuery>(
        this as GetBotsQuery,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return GetBotsQueryMapper.ensureInitialized().stringifyValue(
      this as GetBotsQuery,
    );
  }

  @override
  bool operator ==(Object other) {
    return GetBotsQueryMapper.ensureInitialized().equalsValue(
      this as GetBotsQuery,
      other,
    );
  }

  @override
  int get hashCode {
    return GetBotsQueryMapper.ensureInitialized().hashValue(
      this as GetBotsQuery,
    );
  }
}

extension GetBotsQueryValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GetBotsQuery, $Out> {
  GetBotsQueryCopyWith<$R, GetBotsQuery, $Out> get $asGetBotsQuery =>
      $base.as((v, t, t2) => _GetBotsQueryCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class GetBotsQueryCopyWith<$R, $In extends GetBotsQuery, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  GetBotsQueryCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GetBotsQueryCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GetBotsQuery, $Out>
    implements GetBotsQueryCopyWith<$R, GetBotsQuery, $Out> {
  _GetBotsQueryCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GetBotsQuery> $mapper =
      GetBotsQueryMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  GetBotsQuery $make(CopyWithData data) => GetBotsQuery();

  @override
  GetBotsQueryCopyWith<$R2, GetBotsQuery, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _GetBotsQueryCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

