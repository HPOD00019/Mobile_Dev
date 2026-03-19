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
    }
    return _instance!;
  }

  @override
  final String id = 'MakeMoveCommand';

  static String _$sessionId(MakeMoveCommand v) => v.sessionId;
  static const Field<MakeMoveCommand, String> _f$sessionId = Field(
    'sessionId',
    _$sessionId,
  );
  static String _$fen(MakeMoveCommand v) => v.fen;
  static const Field<MakeMoveCommand, String> _f$fen = Field('fen', _$fen);

  @override
  final MappableFields<MakeMoveCommand> fields = const {
    #sessionId: _f$sessionId,
    #fen: _f$fen,
  };

  static MakeMoveCommand _instantiate(DecodingData data) {
    return MakeMoveCommand(
      sessionId: data.dec(_f$sessionId),
      fen: data.dec(_f$fen),
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
  $R call({String? sessionId, String? fen});
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
  $R call({String? sessionId, String? fen}) => $apply(
    FieldCopyWithData({
      if (sessionId != null) #sessionId: sessionId,
      if (fen != null) #fen: fen,
    }),
  );
  @override
  MakeMoveCommand $make(CopyWithData data) => MakeMoveCommand(
    sessionId: data.get(#sessionId, or: $value.sessionId),
    fen: data.get(#fen, or: $value.fen),
  );

  @override
  MakeMoveCommandCopyWith<$R2, MakeMoveCommand, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MakeMoveCommandCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

