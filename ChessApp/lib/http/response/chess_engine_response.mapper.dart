// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'chess_engine_response.dart';

class ChessEngineResponseMapper extends ClassMapperBase<ChessEngineResponse> {
  ChessEngineResponseMapper._();

  static ChessEngineResponseMapper? _instance;
  static ChessEngineResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ChessEngineResponseMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ChessEngineResponse';

  static String _$uci(ChessEngineResponse v) => v.uci;
  static const Field<ChessEngineResponse, String> _f$uci = Field(
    'uci',
    _$uci,
    key: r'move',
  );

  @override
  final MappableFields<ChessEngineResponse> fields = const {#uci: _f$uci};

  static ChessEngineResponse _instantiate(DecodingData data) {
    return ChessEngineResponse(uci: data.dec(_f$uci));
  }

  @override
  final Function instantiate = _instantiate;

  static ChessEngineResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ChessEngineResponse>(map);
  }

  static ChessEngineResponse fromJson(String json) {
    return ensureInitialized().decodeJson<ChessEngineResponse>(json);
  }
}

mixin ChessEngineResponseMappable {
  String toJson() {
    return ChessEngineResponseMapper.ensureInitialized()
        .encodeJson<ChessEngineResponse>(this as ChessEngineResponse);
  }

  Map<String, dynamic> toMap() {
    return ChessEngineResponseMapper.ensureInitialized()
        .encodeMap<ChessEngineResponse>(this as ChessEngineResponse);
  }

  ChessEngineResponseCopyWith<
    ChessEngineResponse,
    ChessEngineResponse,
    ChessEngineResponse
  >
  get copyWith =>
      _ChessEngineResponseCopyWithImpl<
        ChessEngineResponse,
        ChessEngineResponse
      >(this as ChessEngineResponse, $identity, $identity);
  @override
  String toString() {
    return ChessEngineResponseMapper.ensureInitialized().stringifyValue(
      this as ChessEngineResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return ChessEngineResponseMapper.ensureInitialized().equalsValue(
      this as ChessEngineResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return ChessEngineResponseMapper.ensureInitialized().hashValue(
      this as ChessEngineResponse,
    );
  }
}

extension ChessEngineResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ChessEngineResponse, $Out> {
  ChessEngineResponseCopyWith<$R, ChessEngineResponse, $Out>
  get $asChessEngineResponse => $base.as(
    (v, t, t2) => _ChessEngineResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ChessEngineResponseCopyWith<
  $R,
  $In extends ChessEngineResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? uci});
  ChessEngineResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ChessEngineResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ChessEngineResponse, $Out>
    implements ChessEngineResponseCopyWith<$R, ChessEngineResponse, $Out> {
  _ChessEngineResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ChessEngineResponse> $mapper =
      ChessEngineResponseMapper.ensureInitialized();
  @override
  $R call({String? uci}) =>
      $apply(FieldCopyWithData({if (uci != null) #uci: uci}));
  @override
  ChessEngineResponse $make(CopyWithData data) =>
      ChessEngineResponse(uci: data.get(#uci, or: $value.uci));

  @override
  ChessEngineResponseCopyWith<$R2, ChessEngineResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ChessEngineResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

