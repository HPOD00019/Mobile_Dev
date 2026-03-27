// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'get_opponent_query.dart';

class GetOpponentQueryMapper extends ClassMapperBase<GetOpponentQuery> {
  GetOpponentQueryMapper._();

  static GetOpponentQueryMapper? _instance;
  static GetOpponentQueryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GetOpponentQueryMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'GetOpponentQuery';

  @override
  final MappableFields<GetOpponentQuery> fields = const {};

  static GetOpponentQuery _instantiate(DecodingData data) {
    return GetOpponentQuery();
  }

  @override
  final Function instantiate = _instantiate;

  static GetOpponentQuery fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GetOpponentQuery>(map);
  }

  static GetOpponentQuery fromJson(String json) {
    return ensureInitialized().decodeJson<GetOpponentQuery>(json);
  }
}

mixin GetOpponentQueryMappable {
  String toJson() {
    return GetOpponentQueryMapper.ensureInitialized()
        .encodeJson<GetOpponentQuery>(this as GetOpponentQuery);
  }

  Map<String, dynamic> toMap() {
    return GetOpponentQueryMapper.ensureInitialized()
        .encodeMap<GetOpponentQuery>(this as GetOpponentQuery);
  }

  GetOpponentQueryCopyWith<GetOpponentQuery, GetOpponentQuery, GetOpponentQuery>
  get copyWith =>
      _GetOpponentQueryCopyWithImpl<GetOpponentQuery, GetOpponentQuery>(
        this as GetOpponentQuery,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return GetOpponentQueryMapper.ensureInitialized().stringifyValue(
      this as GetOpponentQuery,
    );
  }

  @override
  bool operator ==(Object other) {
    return GetOpponentQueryMapper.ensureInitialized().equalsValue(
      this as GetOpponentQuery,
      other,
    );
  }

  @override
  int get hashCode {
    return GetOpponentQueryMapper.ensureInitialized().hashValue(
      this as GetOpponentQuery,
    );
  }
}

extension GetOpponentQueryValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GetOpponentQuery, $Out> {
  GetOpponentQueryCopyWith<$R, GetOpponentQuery, $Out>
  get $asGetOpponentQuery =>
      $base.as((v, t, t2) => _GetOpponentQueryCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class GetOpponentQueryCopyWith<$R, $In extends GetOpponentQuery, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  GetOpponentQueryCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _GetOpponentQueryCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GetOpponentQuery, $Out>
    implements GetOpponentQueryCopyWith<$R, GetOpponentQuery, $Out> {
  _GetOpponentQueryCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GetOpponentQuery> $mapper =
      GetOpponentQueryMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  GetOpponentQuery $make(CopyWithData data) => GetOpponentQuery();

  @override
  GetOpponentQueryCopyWith<$R2, GetOpponentQuery, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _GetOpponentQueryCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

