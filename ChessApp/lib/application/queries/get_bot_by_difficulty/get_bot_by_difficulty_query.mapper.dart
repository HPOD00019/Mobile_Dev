// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'get_bot_by_difficulty_query.dart';

class GetBotByDifficultyQueryMapper
    extends ClassMapperBase<GetBotByDifficultyQuery> {
  GetBotByDifficultyQueryMapper._();

  static GetBotByDifficultyQueryMapper? _instance;
  static GetBotByDifficultyQueryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = GetBotByDifficultyQueryMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'GetBotByDifficultyQuery';

  static int _$difficulty(GetBotByDifficultyQuery v) => v.difficulty;
  static const Field<GetBotByDifficultyQuery, int> _f$difficulty = Field(
    'difficulty',
    _$difficulty,
  );

  @override
  final MappableFields<GetBotByDifficultyQuery> fields = const {
    #difficulty: _f$difficulty,
  };

  static GetBotByDifficultyQuery _instantiate(DecodingData data) {
    return GetBotByDifficultyQuery(difficulty: data.dec(_f$difficulty));
  }

  @override
  final Function instantiate = _instantiate;

  static GetBotByDifficultyQuery fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GetBotByDifficultyQuery>(map);
  }

  static GetBotByDifficultyQuery fromJson(String json) {
    return ensureInitialized().decodeJson<GetBotByDifficultyQuery>(json);
  }
}

mixin GetBotByDifficultyQueryMappable {
  String toJson() {
    return GetBotByDifficultyQueryMapper.ensureInitialized()
        .encodeJson<GetBotByDifficultyQuery>(this as GetBotByDifficultyQuery);
  }

  Map<String, dynamic> toMap() {
    return GetBotByDifficultyQueryMapper.ensureInitialized()
        .encodeMap<GetBotByDifficultyQuery>(this as GetBotByDifficultyQuery);
  }

  GetBotByDifficultyQueryCopyWith<
    GetBotByDifficultyQuery,
    GetBotByDifficultyQuery,
    GetBotByDifficultyQuery
  >
  get copyWith =>
      _GetBotByDifficultyQueryCopyWithImpl<
        GetBotByDifficultyQuery,
        GetBotByDifficultyQuery
      >(this as GetBotByDifficultyQuery, $identity, $identity);
  @override
  String toString() {
    return GetBotByDifficultyQueryMapper.ensureInitialized().stringifyValue(
      this as GetBotByDifficultyQuery,
    );
  }

  @override
  bool operator ==(Object other) {
    return GetBotByDifficultyQueryMapper.ensureInitialized().equalsValue(
      this as GetBotByDifficultyQuery,
      other,
    );
  }

  @override
  int get hashCode {
    return GetBotByDifficultyQueryMapper.ensureInitialized().hashValue(
      this as GetBotByDifficultyQuery,
    );
  }
}

extension GetBotByDifficultyQueryValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GetBotByDifficultyQuery, $Out> {
  GetBotByDifficultyQueryCopyWith<$R, GetBotByDifficultyQuery, $Out>
  get $asGetBotByDifficultyQuery => $base.as(
    (v, t, t2) => _GetBotByDifficultyQueryCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class GetBotByDifficultyQueryCopyWith<
  $R,
  $In extends GetBotByDifficultyQuery,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? difficulty});
  GetBotByDifficultyQueryCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _GetBotByDifficultyQueryCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GetBotByDifficultyQuery, $Out>
    implements
        GetBotByDifficultyQueryCopyWith<$R, GetBotByDifficultyQuery, $Out> {
  _GetBotByDifficultyQueryCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GetBotByDifficultyQuery> $mapper =
      GetBotByDifficultyQueryMapper.ensureInitialized();
  @override
  $R call({int? difficulty}) => $apply(
    FieldCopyWithData({if (difficulty != null) #difficulty: difficulty}),
  );
  @override
  GetBotByDifficultyQuery $make(CopyWithData data) => GetBotByDifficultyQuery(
    difficulty: data.get(#difficulty, or: $value.difficulty),
  );

  @override
  GetBotByDifficultyQueryCopyWith<$R2, GetBotByDifficultyQuery, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _GetBotByDifficultyQueryCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

