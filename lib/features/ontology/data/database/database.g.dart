// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $MuscleRegionsTable extends MuscleRegions
    with TableInfo<$MuscleRegionsTable, MuscleRegionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MuscleRegionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _muscleGroupMeta = const VerificationMeta(
    'muscleGroup',
  );
  @override
  late final GeneratedColumn<String> muscleGroup = GeneratedColumn<String>(
    'muscle_group',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayOrderMeta = const VerificationMeta(
    'displayOrder',
  );
  @override
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
    'display_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, muscleGroup, displayOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'muscle_regions';
  @override
  VerificationContext validateIntegrity(
    Insertable<MuscleRegionData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('muscle_group')) {
      context.handle(
        _muscleGroupMeta,
        muscleGroup.isAcceptableOrUnknown(
          data['muscle_group']!,
          _muscleGroupMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_muscleGroupMeta);
    }
    if (data.containsKey('display_order')) {
      context.handle(
        _displayOrderMeta,
        displayOrder.isAcceptableOrUnknown(
          data['display_order']!,
          _displayOrderMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MuscleRegionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MuscleRegionData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      muscleGroup: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}muscle_group'],
      )!,
      displayOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}display_order'],
      )!,
    );
  }

  @override
  $MuscleRegionsTable createAlias(String alias) {
    return $MuscleRegionsTable(attachedDatabase, alias);
  }
}

class MuscleRegionData extends DataClass
    implements Insertable<MuscleRegionData> {
  final String id;
  final String name;
  final String muscleGroup;
  final int displayOrder;
  const MuscleRegionData({
    required this.id,
    required this.name,
    required this.muscleGroup,
    required this.displayOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['muscle_group'] = Variable<String>(muscleGroup);
    map['display_order'] = Variable<int>(displayOrder);
    return map;
  }

  MuscleRegionsCompanion toCompanion(bool nullToAbsent) {
    return MuscleRegionsCompanion(
      id: Value(id),
      name: Value(name),
      muscleGroup: Value(muscleGroup),
      displayOrder: Value(displayOrder),
    );
  }

  factory MuscleRegionData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MuscleRegionData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      muscleGroup: serializer.fromJson<String>(json['muscleGroup']),
      displayOrder: serializer.fromJson<int>(json['displayOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'muscleGroup': serializer.toJson<String>(muscleGroup),
      'displayOrder': serializer.toJson<int>(displayOrder),
    };
  }

  MuscleRegionData copyWith({
    String? id,
    String? name,
    String? muscleGroup,
    int? displayOrder,
  }) => MuscleRegionData(
    id: id ?? this.id,
    name: name ?? this.name,
    muscleGroup: muscleGroup ?? this.muscleGroup,
    displayOrder: displayOrder ?? this.displayOrder,
  );
  MuscleRegionData copyWithCompanion(MuscleRegionsCompanion data) {
    return MuscleRegionData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      muscleGroup: data.muscleGroup.present
          ? data.muscleGroup.value
          : this.muscleGroup,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MuscleRegionData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('muscleGroup: $muscleGroup, ')
          ..write('displayOrder: $displayOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, muscleGroup, displayOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MuscleRegionData &&
          other.id == this.id &&
          other.name == this.name &&
          other.muscleGroup == this.muscleGroup &&
          other.displayOrder == this.displayOrder);
}

class MuscleRegionsCompanion extends UpdateCompanion<MuscleRegionData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> muscleGroup;
  final Value<int> displayOrder;
  final Value<int> rowid;
  const MuscleRegionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.muscleGroup = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MuscleRegionsCompanion.insert({
    required String id,
    required String name,
    required String muscleGroup,
    this.displayOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       muscleGroup = Value(muscleGroup);
  static Insertable<MuscleRegionData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? muscleGroup,
    Expression<int>? displayOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (muscleGroup != null) 'muscle_group': muscleGroup,
      if (displayOrder != null) 'display_order': displayOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MuscleRegionsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? muscleGroup,
    Value<int>? displayOrder,
    Value<int>? rowid,
  }) {
    return MuscleRegionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      displayOrder: displayOrder ?? this.displayOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (muscleGroup.present) {
      map['muscle_group'] = Variable<String>(muscleGroup.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MuscleRegionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('muscleGroup: $muscleGroup, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EquipmentTable extends Equipment
    with TableInfo<$EquipmentTable, EquipmentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EquipmentTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, icon];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'equipment';
  @override
  VerificationContext validateIntegrity(
    Insertable<EquipmentData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EquipmentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EquipmentData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      ),
    );
  }

  @override
  $EquipmentTable createAlias(String alias) {
    return $EquipmentTable(attachedDatabase, alias);
  }
}

class EquipmentData extends DataClass implements Insertable<EquipmentData> {
  final String id;
  final String name;
  final String? icon;
  const EquipmentData({required this.id, required this.name, this.icon});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    return map;
  }

  EquipmentCompanion toCompanion(bool nullToAbsent) {
    return EquipmentCompanion(
      id: Value(id),
      name: Value(name),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
    );
  }

  factory EquipmentData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EquipmentData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String?>(json['icon']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String?>(icon),
    };
  }

  EquipmentData copyWith({
    String? id,
    String? name,
    Value<String?> icon = const Value.absent(),
  }) => EquipmentData(
    id: id ?? this.id,
    name: name ?? this.name,
    icon: icon.present ? icon.value : this.icon,
  );
  EquipmentData copyWithCompanion(EquipmentCompanion data) {
    return EquipmentData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EquipmentData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, icon);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EquipmentData &&
          other.id == this.id &&
          other.name == this.name &&
          other.icon == this.icon);
}

class EquipmentCompanion extends UpdateCompanion<EquipmentData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> icon;
  final Value<int> rowid;
  const EquipmentCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EquipmentCompanion.insert({
    required String id,
    required String name,
    this.icon = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<EquipmentData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EquipmentCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? icon,
    Value<int>? rowid,
  }) {
    return EquipmentCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EquipmentCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExercisesTable extends Exercises
    with TableInfo<$ExercisesTable, ExerciseData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _equipmentIdMeta = const VerificationMeta(
    'equipmentId',
  );
  @override
  late final GeneratedColumn<String> equipmentId = GeneratedColumn<String>(
    'equipment_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES equipment (id)',
    ),
  );
  static const VerificationMeta _primaryMuscleIdMeta = const VerificationMeta(
    'primaryMuscleId',
  );
  @override
  late final GeneratedColumn<String> primaryMuscleId = GeneratedColumn<String>(
    'primary_muscle',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES muscle_regions (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<MovementPattern, String>
  movementPattern = GeneratedColumn<String>(
    'movement_pattern',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<MovementPattern>($ExercisesTable.$convertermovementPattern);
  @override
  late final GeneratedColumnWithTypeConverter<PlaneOfMotion?, String>
  planeOfMotion = GeneratedColumn<String>(
    'plane_of_motion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<PlaneOfMotion?>($ExercisesTable.$converterplaneOfMotionn);
  @override
  late final GeneratedColumnWithTypeConverter<ExerciseAngle, String> angle =
      GeneratedColumn<String>(
        'angle',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ExerciseAngle>($ExercisesTable.$converterangle);
  @override
  late final GeneratedColumnWithTypeConverter<Laterality, String> laterality =
      GeneratedColumn<String>(
        'laterality',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Laterality>($ExercisesTable.$converterlaterality);
  @override
  late final GeneratedColumnWithTypeConverter<LoadingType, String> loadingType =
      GeneratedColumn<String>(
        'loading_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<LoadingType>($ExercisesTable.$converterloadingType);
  @override
  late final GeneratedColumnWithTypeConverter<CnsCost, String> cnsCost =
      GeneratedColumn<String>(
        'cns_cost',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<CnsCost>($ExercisesTable.$convertercnsCost);
  @override
  late final GeneratedColumnWithTypeConverter<SkillLevel, String> skillLevel =
      GeneratedColumn<String>(
        'skill_level',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<SkillLevel>($ExercisesTable.$converterskillLevel);
  @override
  late final GeneratedColumnWithTypeConverter<Mechanics, String> mechanics =
      GeneratedColumn<String>(
        'mechanics',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Mechanics>($ExercisesTable.$convertermechanics);
  static const VerificationMeta _lottieUrlMeta = const VerificationMeta(
    'lottieUrl',
  );
  @override
  late final GeneratedColumn<String> lottieUrl = GeneratedColumn<String>(
    'lottie_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _instructionsMeta = const VerificationMeta(
    'instructions',
  );
  @override
  late final GeneratedColumn<String> instructions = GeneratedColumn<String>(
    'instructions',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ExerciseTier, int> tier =
      GeneratedColumn<int>(
        'tier',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(1),
      ).withConverter<ExerciseTier>($ExercisesTable.$convertertier);
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _canonicalHashMeta = const VerificationMeta(
    'canonicalHash',
  );
  @override
  late final GeneratedColumn<String> canonicalHash = GeneratedColumn<String>(
    'canonical_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    equipmentId,
    primaryMuscleId,
    movementPattern,
    planeOfMotion,
    angle,
    laterality,
    loadingType,
    cnsCost,
    skillLevel,
    mechanics,
    lottieUrl,
    instructions,
    tier,
    confidence,
    canonicalHash,
    createdBy,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('equipment_id')) {
      context.handle(
        _equipmentIdMeta,
        equipmentId.isAcceptableOrUnknown(
          data['equipment_id']!,
          _equipmentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_equipmentIdMeta);
    }
    if (data.containsKey('primary_muscle')) {
      context.handle(
        _primaryMuscleIdMeta,
        primaryMuscleId.isAcceptableOrUnknown(
          data['primary_muscle']!,
          _primaryMuscleIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_primaryMuscleIdMeta);
    }
    if (data.containsKey('lottie_url')) {
      context.handle(
        _lottieUrlMeta,
        lottieUrl.isAcceptableOrUnknown(data['lottie_url']!, _lottieUrlMeta),
      );
    }
    if (data.containsKey('instructions')) {
      context.handle(
        _instructionsMeta,
        instructions.isAcceptableOrUnknown(
          data['instructions']!,
          _instructionsMeta,
        ),
      );
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    if (data.containsKey('canonical_hash')) {
      context.handle(
        _canonicalHashMeta,
        canonicalHash.isAcceptableOrUnknown(
          data['canonical_hash']!,
          _canonicalHashMeta,
        ),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      equipmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}equipment_id'],
      )!,
      primaryMuscleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primary_muscle'],
      )!,
      movementPattern: $ExercisesTable.$convertermovementPattern.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}movement_pattern'],
        )!,
      ),
      planeOfMotion: $ExercisesTable.$converterplaneOfMotionn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}plane_of_motion'],
        ),
      ),
      angle: $ExercisesTable.$converterangle.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}angle'],
        )!,
      ),
      laterality: $ExercisesTable.$converterlaterality.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}laterality'],
        )!,
      ),
      loadingType: $ExercisesTable.$converterloadingType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}loading_type'],
        )!,
      ),
      cnsCost: $ExercisesTable.$convertercnsCost.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}cns_cost'],
        )!,
      ),
      skillLevel: $ExercisesTable.$converterskillLevel.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}skill_level'],
        )!,
      ),
      mechanics: $ExercisesTable.$convertermechanics.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}mechanics'],
        )!,
      ),
      lottieUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lottie_url'],
      ),
      instructions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}instructions'],
      ),
      tier: $ExercisesTable.$convertertier.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}tier'],
        )!,
      ),
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      canonicalHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}canonical_hash'],
      ),
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ExercisesTable createAlias(String alias) {
    return $ExercisesTable(attachedDatabase, alias);
  }

  static TypeConverter<MovementPattern, String> $convertermovementPattern =
      const MovementPatternConverter();
  static TypeConverter<PlaneOfMotion, String> $converterplaneOfMotion =
      const PlaneOfMotionConverter();
  static TypeConverter<PlaneOfMotion?, String?> $converterplaneOfMotionn =
      NullAwareTypeConverter.wrap($converterplaneOfMotion);
  static TypeConverter<ExerciseAngle, String> $converterangle =
      const ExerciseAngleConverter();
  static TypeConverter<Laterality, String> $converterlaterality =
      const LateralityConverter();
  static TypeConverter<LoadingType, String> $converterloadingType =
      const LoadingTypeConverter();
  static TypeConverter<CnsCost, String> $convertercnsCost =
      const CnsCostConverter();
  static TypeConverter<SkillLevel, String> $converterskillLevel =
      const SkillLevelConverter();
  static TypeConverter<Mechanics, String> $convertermechanics =
      const MechanicsConverter();
  static TypeConverter<ExerciseTier, int> $convertertier =
      const ExerciseTierConverter();
}

class ExerciseData extends DataClass implements Insertable<ExerciseData> {
  final String id;
  final String name;
  final String equipmentId;
  final String primaryMuscleId;
  final MovementPattern movementPattern;
  final PlaneOfMotion? planeOfMotion;
  final ExerciseAngle angle;
  final Laterality laterality;
  final LoadingType loadingType;
  final CnsCost cnsCost;
  final SkillLevel skillLevel;
  final Mechanics mechanics;
  final String? lottieUrl;
  final String? instructions;
  final ExerciseTier tier;
  final double confidence;
  final String? canonicalHash;
  final String? createdBy;
  final String createdAt;
  final String updatedAt;
  const ExerciseData({
    required this.id,
    required this.name,
    required this.equipmentId,
    required this.primaryMuscleId,
    required this.movementPattern,
    this.planeOfMotion,
    required this.angle,
    required this.laterality,
    required this.loadingType,
    required this.cnsCost,
    required this.skillLevel,
    required this.mechanics,
    this.lottieUrl,
    this.instructions,
    required this.tier,
    required this.confidence,
    this.canonicalHash,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['equipment_id'] = Variable<String>(equipmentId);
    map['primary_muscle'] = Variable<String>(primaryMuscleId);
    {
      map['movement_pattern'] = Variable<String>(
        $ExercisesTable.$convertermovementPattern.toSql(movementPattern),
      );
    }
    if (!nullToAbsent || planeOfMotion != null) {
      map['plane_of_motion'] = Variable<String>(
        $ExercisesTable.$converterplaneOfMotionn.toSql(planeOfMotion),
      );
    }
    {
      map['angle'] = Variable<String>(
        $ExercisesTable.$converterangle.toSql(angle),
      );
    }
    {
      map['laterality'] = Variable<String>(
        $ExercisesTable.$converterlaterality.toSql(laterality),
      );
    }
    {
      map['loading_type'] = Variable<String>(
        $ExercisesTable.$converterloadingType.toSql(loadingType),
      );
    }
    {
      map['cns_cost'] = Variable<String>(
        $ExercisesTable.$convertercnsCost.toSql(cnsCost),
      );
    }
    {
      map['skill_level'] = Variable<String>(
        $ExercisesTable.$converterskillLevel.toSql(skillLevel),
      );
    }
    {
      map['mechanics'] = Variable<String>(
        $ExercisesTable.$convertermechanics.toSql(mechanics),
      );
    }
    if (!nullToAbsent || lottieUrl != null) {
      map['lottie_url'] = Variable<String>(lottieUrl);
    }
    if (!nullToAbsent || instructions != null) {
      map['instructions'] = Variable<String>(instructions);
    }
    {
      map['tier'] = Variable<int>($ExercisesTable.$convertertier.toSql(tier));
    }
    map['confidence'] = Variable<double>(confidence);
    if (!nullToAbsent || canonicalHash != null) {
      map['canonical_hash'] = Variable<String>(canonicalHash);
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  ExercisesCompanion toCompanion(bool nullToAbsent) {
    return ExercisesCompanion(
      id: Value(id),
      name: Value(name),
      equipmentId: Value(equipmentId),
      primaryMuscleId: Value(primaryMuscleId),
      movementPattern: Value(movementPattern),
      planeOfMotion: planeOfMotion == null && nullToAbsent
          ? const Value.absent()
          : Value(planeOfMotion),
      angle: Value(angle),
      laterality: Value(laterality),
      loadingType: Value(loadingType),
      cnsCost: Value(cnsCost),
      skillLevel: Value(skillLevel),
      mechanics: Value(mechanics),
      lottieUrl: lottieUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(lottieUrl),
      instructions: instructions == null && nullToAbsent
          ? const Value.absent()
          : Value(instructions),
      tier: Value(tier),
      confidence: Value(confidence),
      canonicalHash: canonicalHash == null && nullToAbsent
          ? const Value.absent()
          : Value(canonicalHash),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ExerciseData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      equipmentId: serializer.fromJson<String>(json['equipmentId']),
      primaryMuscleId: serializer.fromJson<String>(json['primaryMuscleId']),
      movementPattern: serializer.fromJson<MovementPattern>(
        json['movementPattern'],
      ),
      planeOfMotion: serializer.fromJson<PlaneOfMotion?>(json['planeOfMotion']),
      angle: serializer.fromJson<ExerciseAngle>(json['angle']),
      laterality: serializer.fromJson<Laterality>(json['laterality']),
      loadingType: serializer.fromJson<LoadingType>(json['loadingType']),
      cnsCost: serializer.fromJson<CnsCost>(json['cnsCost']),
      skillLevel: serializer.fromJson<SkillLevel>(json['skillLevel']),
      mechanics: serializer.fromJson<Mechanics>(json['mechanics']),
      lottieUrl: serializer.fromJson<String?>(json['lottieUrl']),
      instructions: serializer.fromJson<String?>(json['instructions']),
      tier: serializer.fromJson<ExerciseTier>(json['tier']),
      confidence: serializer.fromJson<double>(json['confidence']),
      canonicalHash: serializer.fromJson<String?>(json['canonicalHash']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'equipmentId': serializer.toJson<String>(equipmentId),
      'primaryMuscleId': serializer.toJson<String>(primaryMuscleId),
      'movementPattern': serializer.toJson<MovementPattern>(movementPattern),
      'planeOfMotion': serializer.toJson<PlaneOfMotion?>(planeOfMotion),
      'angle': serializer.toJson<ExerciseAngle>(angle),
      'laterality': serializer.toJson<Laterality>(laterality),
      'loadingType': serializer.toJson<LoadingType>(loadingType),
      'cnsCost': serializer.toJson<CnsCost>(cnsCost),
      'skillLevel': serializer.toJson<SkillLevel>(skillLevel),
      'mechanics': serializer.toJson<Mechanics>(mechanics),
      'lottieUrl': serializer.toJson<String?>(lottieUrl),
      'instructions': serializer.toJson<String?>(instructions),
      'tier': serializer.toJson<ExerciseTier>(tier),
      'confidence': serializer.toJson<double>(confidence),
      'canonicalHash': serializer.toJson<String?>(canonicalHash),
      'createdBy': serializer.toJson<String?>(createdBy),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  ExerciseData copyWith({
    String? id,
    String? name,
    String? equipmentId,
    String? primaryMuscleId,
    MovementPattern? movementPattern,
    Value<PlaneOfMotion?> planeOfMotion = const Value.absent(),
    ExerciseAngle? angle,
    Laterality? laterality,
    LoadingType? loadingType,
    CnsCost? cnsCost,
    SkillLevel? skillLevel,
    Mechanics? mechanics,
    Value<String?> lottieUrl = const Value.absent(),
    Value<String?> instructions = const Value.absent(),
    ExerciseTier? tier,
    double? confidence,
    Value<String?> canonicalHash = const Value.absent(),
    Value<String?> createdBy = const Value.absent(),
    String? createdAt,
    String? updatedAt,
  }) => ExerciseData(
    id: id ?? this.id,
    name: name ?? this.name,
    equipmentId: equipmentId ?? this.equipmentId,
    primaryMuscleId: primaryMuscleId ?? this.primaryMuscleId,
    movementPattern: movementPattern ?? this.movementPattern,
    planeOfMotion: planeOfMotion.present
        ? planeOfMotion.value
        : this.planeOfMotion,
    angle: angle ?? this.angle,
    laterality: laterality ?? this.laterality,
    loadingType: loadingType ?? this.loadingType,
    cnsCost: cnsCost ?? this.cnsCost,
    skillLevel: skillLevel ?? this.skillLevel,
    mechanics: mechanics ?? this.mechanics,
    lottieUrl: lottieUrl.present ? lottieUrl.value : this.lottieUrl,
    instructions: instructions.present ? instructions.value : this.instructions,
    tier: tier ?? this.tier,
    confidence: confidence ?? this.confidence,
    canonicalHash: canonicalHash.present
        ? canonicalHash.value
        : this.canonicalHash,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ExerciseData copyWithCompanion(ExercisesCompanion data) {
    return ExerciseData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      equipmentId: data.equipmentId.present
          ? data.equipmentId.value
          : this.equipmentId,
      primaryMuscleId: data.primaryMuscleId.present
          ? data.primaryMuscleId.value
          : this.primaryMuscleId,
      movementPattern: data.movementPattern.present
          ? data.movementPattern.value
          : this.movementPattern,
      planeOfMotion: data.planeOfMotion.present
          ? data.planeOfMotion.value
          : this.planeOfMotion,
      angle: data.angle.present ? data.angle.value : this.angle,
      laterality: data.laterality.present
          ? data.laterality.value
          : this.laterality,
      loadingType: data.loadingType.present
          ? data.loadingType.value
          : this.loadingType,
      cnsCost: data.cnsCost.present ? data.cnsCost.value : this.cnsCost,
      skillLevel: data.skillLevel.present
          ? data.skillLevel.value
          : this.skillLevel,
      mechanics: data.mechanics.present ? data.mechanics.value : this.mechanics,
      lottieUrl: data.lottieUrl.present ? data.lottieUrl.value : this.lottieUrl,
      instructions: data.instructions.present
          ? data.instructions.value
          : this.instructions,
      tier: data.tier.present ? data.tier.value : this.tier,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      canonicalHash: data.canonicalHash.present
          ? data.canonicalHash.value
          : this.canonicalHash,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('equipmentId: $equipmentId, ')
          ..write('primaryMuscleId: $primaryMuscleId, ')
          ..write('movementPattern: $movementPattern, ')
          ..write('planeOfMotion: $planeOfMotion, ')
          ..write('angle: $angle, ')
          ..write('laterality: $laterality, ')
          ..write('loadingType: $loadingType, ')
          ..write('cnsCost: $cnsCost, ')
          ..write('skillLevel: $skillLevel, ')
          ..write('mechanics: $mechanics, ')
          ..write('lottieUrl: $lottieUrl, ')
          ..write('instructions: $instructions, ')
          ..write('tier: $tier, ')
          ..write('confidence: $confidence, ')
          ..write('canonicalHash: $canonicalHash, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    equipmentId,
    primaryMuscleId,
    movementPattern,
    planeOfMotion,
    angle,
    laterality,
    loadingType,
    cnsCost,
    skillLevel,
    mechanics,
    lottieUrl,
    instructions,
    tier,
    confidence,
    canonicalHash,
    createdBy,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseData &&
          other.id == this.id &&
          other.name == this.name &&
          other.equipmentId == this.equipmentId &&
          other.primaryMuscleId == this.primaryMuscleId &&
          other.movementPattern == this.movementPattern &&
          other.planeOfMotion == this.planeOfMotion &&
          other.angle == this.angle &&
          other.laterality == this.laterality &&
          other.loadingType == this.loadingType &&
          other.cnsCost == this.cnsCost &&
          other.skillLevel == this.skillLevel &&
          other.mechanics == this.mechanics &&
          other.lottieUrl == this.lottieUrl &&
          other.instructions == this.instructions &&
          other.tier == this.tier &&
          other.confidence == this.confidence &&
          other.canonicalHash == this.canonicalHash &&
          other.createdBy == this.createdBy &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ExercisesCompanion extends UpdateCompanion<ExerciseData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> equipmentId;
  final Value<String> primaryMuscleId;
  final Value<MovementPattern> movementPattern;
  final Value<PlaneOfMotion?> planeOfMotion;
  final Value<ExerciseAngle> angle;
  final Value<Laterality> laterality;
  final Value<LoadingType> loadingType;
  final Value<CnsCost> cnsCost;
  final Value<SkillLevel> skillLevel;
  final Value<Mechanics> mechanics;
  final Value<String?> lottieUrl;
  final Value<String?> instructions;
  final Value<ExerciseTier> tier;
  final Value<double> confidence;
  final Value<String?> canonicalHash;
  final Value<String?> createdBy;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<int> rowid;
  const ExercisesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.equipmentId = const Value.absent(),
    this.primaryMuscleId = const Value.absent(),
    this.movementPattern = const Value.absent(),
    this.planeOfMotion = const Value.absent(),
    this.angle = const Value.absent(),
    this.laterality = const Value.absent(),
    this.loadingType = const Value.absent(),
    this.cnsCost = const Value.absent(),
    this.skillLevel = const Value.absent(),
    this.mechanics = const Value.absent(),
    this.lottieUrl = const Value.absent(),
    this.instructions = const Value.absent(),
    this.tier = const Value.absent(),
    this.confidence = const Value.absent(),
    this.canonicalHash = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExercisesCompanion.insert({
    required String id,
    required String name,
    required String equipmentId,
    required String primaryMuscleId,
    required MovementPattern movementPattern,
    this.planeOfMotion = const Value.absent(),
    required ExerciseAngle angle,
    required Laterality laterality,
    required LoadingType loadingType,
    required CnsCost cnsCost,
    required SkillLevel skillLevel,
    required Mechanics mechanics,
    this.lottieUrl = const Value.absent(),
    this.instructions = const Value.absent(),
    this.tier = const Value.absent(),
    this.confidence = const Value.absent(),
    this.canonicalHash = const Value.absent(),
    this.createdBy = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       equipmentId = Value(equipmentId),
       primaryMuscleId = Value(primaryMuscleId),
       movementPattern = Value(movementPattern),
       angle = Value(angle),
       laterality = Value(laterality),
       loadingType = Value(loadingType),
       cnsCost = Value(cnsCost),
       skillLevel = Value(skillLevel),
       mechanics = Value(mechanics),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ExerciseData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? equipmentId,
    Expression<String>? primaryMuscleId,
    Expression<String>? movementPattern,
    Expression<String>? planeOfMotion,
    Expression<String>? angle,
    Expression<String>? laterality,
    Expression<String>? loadingType,
    Expression<String>? cnsCost,
    Expression<String>? skillLevel,
    Expression<String>? mechanics,
    Expression<String>? lottieUrl,
    Expression<String>? instructions,
    Expression<int>? tier,
    Expression<double>? confidence,
    Expression<String>? canonicalHash,
    Expression<String>? createdBy,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (equipmentId != null) 'equipment_id': equipmentId,
      if (primaryMuscleId != null) 'primary_muscle': primaryMuscleId,
      if (movementPattern != null) 'movement_pattern': movementPattern,
      if (planeOfMotion != null) 'plane_of_motion': planeOfMotion,
      if (angle != null) 'angle': angle,
      if (laterality != null) 'laterality': laterality,
      if (loadingType != null) 'loading_type': loadingType,
      if (cnsCost != null) 'cns_cost': cnsCost,
      if (skillLevel != null) 'skill_level': skillLevel,
      if (mechanics != null) 'mechanics': mechanics,
      if (lottieUrl != null) 'lottie_url': lottieUrl,
      if (instructions != null) 'instructions': instructions,
      if (tier != null) 'tier': tier,
      if (confidence != null) 'confidence': confidence,
      if (canonicalHash != null) 'canonical_hash': canonicalHash,
      if (createdBy != null) 'created_by': createdBy,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExercisesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? equipmentId,
    Value<String>? primaryMuscleId,
    Value<MovementPattern>? movementPattern,
    Value<PlaneOfMotion?>? planeOfMotion,
    Value<ExerciseAngle>? angle,
    Value<Laterality>? laterality,
    Value<LoadingType>? loadingType,
    Value<CnsCost>? cnsCost,
    Value<SkillLevel>? skillLevel,
    Value<Mechanics>? mechanics,
    Value<String?>? lottieUrl,
    Value<String?>? instructions,
    Value<ExerciseTier>? tier,
    Value<double>? confidence,
    Value<String?>? canonicalHash,
    Value<String?>? createdBy,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<int>? rowid,
  }) {
    return ExercisesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      equipmentId: equipmentId ?? this.equipmentId,
      primaryMuscleId: primaryMuscleId ?? this.primaryMuscleId,
      movementPattern: movementPattern ?? this.movementPattern,
      planeOfMotion: planeOfMotion ?? this.planeOfMotion,
      angle: angle ?? this.angle,
      laterality: laterality ?? this.laterality,
      loadingType: loadingType ?? this.loadingType,
      cnsCost: cnsCost ?? this.cnsCost,
      skillLevel: skillLevel ?? this.skillLevel,
      mechanics: mechanics ?? this.mechanics,
      lottieUrl: lottieUrl ?? this.lottieUrl,
      instructions: instructions ?? this.instructions,
      tier: tier ?? this.tier,
      confidence: confidence ?? this.confidence,
      canonicalHash: canonicalHash ?? this.canonicalHash,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (equipmentId.present) {
      map['equipment_id'] = Variable<String>(equipmentId.value);
    }
    if (primaryMuscleId.present) {
      map['primary_muscle'] = Variable<String>(primaryMuscleId.value);
    }
    if (movementPattern.present) {
      map['movement_pattern'] = Variable<String>(
        $ExercisesTable.$convertermovementPattern.toSql(movementPattern.value),
      );
    }
    if (planeOfMotion.present) {
      map['plane_of_motion'] = Variable<String>(
        $ExercisesTable.$converterplaneOfMotionn.toSql(planeOfMotion.value),
      );
    }
    if (angle.present) {
      map['angle'] = Variable<String>(
        $ExercisesTable.$converterangle.toSql(angle.value),
      );
    }
    if (laterality.present) {
      map['laterality'] = Variable<String>(
        $ExercisesTable.$converterlaterality.toSql(laterality.value),
      );
    }
    if (loadingType.present) {
      map['loading_type'] = Variable<String>(
        $ExercisesTable.$converterloadingType.toSql(loadingType.value),
      );
    }
    if (cnsCost.present) {
      map['cns_cost'] = Variable<String>(
        $ExercisesTable.$convertercnsCost.toSql(cnsCost.value),
      );
    }
    if (skillLevel.present) {
      map['skill_level'] = Variable<String>(
        $ExercisesTable.$converterskillLevel.toSql(skillLevel.value),
      );
    }
    if (mechanics.present) {
      map['mechanics'] = Variable<String>(
        $ExercisesTable.$convertermechanics.toSql(mechanics.value),
      );
    }
    if (lottieUrl.present) {
      map['lottie_url'] = Variable<String>(lottieUrl.value);
    }
    if (instructions.present) {
      map['instructions'] = Variable<String>(instructions.value);
    }
    if (tier.present) {
      map['tier'] = Variable<int>(
        $ExercisesTable.$convertertier.toSql(tier.value),
      );
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (canonicalHash.present) {
      map['canonical_hash'] = Variable<String>(canonicalHash.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExercisesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('equipmentId: $equipmentId, ')
          ..write('primaryMuscleId: $primaryMuscleId, ')
          ..write('movementPattern: $movementPattern, ')
          ..write('planeOfMotion: $planeOfMotion, ')
          ..write('angle: $angle, ')
          ..write('laterality: $laterality, ')
          ..write('loadingType: $loadingType, ')
          ..write('cnsCost: $cnsCost, ')
          ..write('skillLevel: $skillLevel, ')
          ..write('mechanics: $mechanics, ')
          ..write('lottieUrl: $lottieUrl, ')
          ..write('instructions: $instructions, ')
          ..write('tier: $tier, ')
          ..write('confidence: $confidence, ')
          ..write('canonicalHash: $canonicalHash, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExerciseMusclesTable extends ExerciseMuscles
    with TableInfo<$ExerciseMusclesTable, ExerciseMuscleData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseMusclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercises (id)',
    ),
  );
  static const VerificationMeta _muscleIdMeta = const VerificationMeta(
    'muscleId',
  );
  @override
  late final GeneratedColumn<String> muscleId = GeneratedColumn<String>(
    'muscle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES muscle_regions (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<MuscleRole, String> role =
      GeneratedColumn<String>(
        'role',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<MuscleRole>($ExerciseMusclesTable.$converterrole);
  @override
  List<GeneratedColumn> get $columns => [exerciseId, muscleId, role];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_muscles';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseMuscleData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('muscle_id')) {
      context.handle(
        _muscleIdMeta,
        muscleId.isAcceptableOrUnknown(data['muscle_id']!, _muscleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_muscleIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {exerciseId, muscleId};
  @override
  ExerciseMuscleData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseMuscleData(
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      muscleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}muscle_id'],
      )!,
      role: $ExerciseMusclesTable.$converterrole.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}role'],
        )!,
      ),
    );
  }

  @override
  $ExerciseMusclesTable createAlias(String alias) {
    return $ExerciseMusclesTable(attachedDatabase, alias);
  }

  static TypeConverter<MuscleRole, String> $converterrole =
      const MuscleRoleConverter();
}

class ExerciseMuscleData extends DataClass
    implements Insertable<ExerciseMuscleData> {
  final String exerciseId;
  final String muscleId;
  final MuscleRole role;
  const ExerciseMuscleData({
    required this.exerciseId,
    required this.muscleId,
    required this.role,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['exercise_id'] = Variable<String>(exerciseId);
    map['muscle_id'] = Variable<String>(muscleId);
    {
      map['role'] = Variable<String>(
        $ExerciseMusclesTable.$converterrole.toSql(role),
      );
    }
    return map;
  }

  ExerciseMusclesCompanion toCompanion(bool nullToAbsent) {
    return ExerciseMusclesCompanion(
      exerciseId: Value(exerciseId),
      muscleId: Value(muscleId),
      role: Value(role),
    );
  }

  factory ExerciseMuscleData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseMuscleData(
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      muscleId: serializer.fromJson<String>(json['muscleId']),
      role: serializer.fromJson<MuscleRole>(json['role']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'exerciseId': serializer.toJson<String>(exerciseId),
      'muscleId': serializer.toJson<String>(muscleId),
      'role': serializer.toJson<MuscleRole>(role),
    };
  }

  ExerciseMuscleData copyWith({
    String? exerciseId,
    String? muscleId,
    MuscleRole? role,
  }) => ExerciseMuscleData(
    exerciseId: exerciseId ?? this.exerciseId,
    muscleId: muscleId ?? this.muscleId,
    role: role ?? this.role,
  );
  ExerciseMuscleData copyWithCompanion(ExerciseMusclesCompanion data) {
    return ExerciseMuscleData(
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      muscleId: data.muscleId.present ? data.muscleId.value : this.muscleId,
      role: data.role.present ? data.role.value : this.role,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseMuscleData(')
          ..write('exerciseId: $exerciseId, ')
          ..write('muscleId: $muscleId, ')
          ..write('role: $role')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(exerciseId, muscleId, role);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseMuscleData &&
          other.exerciseId == this.exerciseId &&
          other.muscleId == this.muscleId &&
          other.role == this.role);
}

class ExerciseMusclesCompanion extends UpdateCompanion<ExerciseMuscleData> {
  final Value<String> exerciseId;
  final Value<String> muscleId;
  final Value<MuscleRole> role;
  final Value<int> rowid;
  const ExerciseMusclesCompanion({
    this.exerciseId = const Value.absent(),
    this.muscleId = const Value.absent(),
    this.role = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExerciseMusclesCompanion.insert({
    required String exerciseId,
    required String muscleId,
    required MuscleRole role,
    this.rowid = const Value.absent(),
  }) : exerciseId = Value(exerciseId),
       muscleId = Value(muscleId),
       role = Value(role);
  static Insertable<ExerciseMuscleData> custom({
    Expression<String>? exerciseId,
    Expression<String>? muscleId,
    Expression<String>? role,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (muscleId != null) 'muscle_id': muscleId,
      if (role != null) 'role': role,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExerciseMusclesCompanion copyWith({
    Value<String>? exerciseId,
    Value<String>? muscleId,
    Value<MuscleRole>? role,
    Value<int>? rowid,
  }) {
    return ExerciseMusclesCompanion(
      exerciseId: exerciseId ?? this.exerciseId,
      muscleId: muscleId ?? this.muscleId,
      role: role ?? this.role,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (muscleId.present) {
      map['muscle_id'] = Variable<String>(muscleId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(
        $ExerciseMusclesTable.$converterrole.toSql(role.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseMusclesCompanion(')
          ..write('exerciseId: $exerciseId, ')
          ..write('muscleId: $muscleId, ')
          ..write('role: $role, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExerciseAliasesTable extends ExerciseAliases
    with TableInfo<$ExerciseAliasesTable, ExerciseAliasData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseAliasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercises (id)',
    ),
  );
  static const VerificationMeta _aliasNameMeta = const VerificationMeta(
    'aliasName',
  );
  @override
  late final GeneratedColumn<String> aliasName = GeneratedColumn<String>(
    'alias_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isPrimaryMeta = const VerificationMeta(
    'isPrimary',
  );
  @override
  late final GeneratedColumn<bool> isPrimary = GeneratedColumn<bool>(
    'is_primary',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_primary" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, exerciseId, aliasName, isPrimary];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_aliases';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseAliasData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('alias_name')) {
      context.handle(
        _aliasNameMeta,
        aliasName.isAcceptableOrUnknown(data['alias_name']!, _aliasNameMeta),
      );
    } else if (isInserting) {
      context.missing(_aliasNameMeta);
    }
    if (data.containsKey('is_primary')) {
      context.handle(
        _isPrimaryMeta,
        isPrimary.isAcceptableOrUnknown(data['is_primary']!, _isPrimaryMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseAliasData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseAliasData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      aliasName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alias_name'],
      )!,
      isPrimary: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_primary'],
      )!,
    );
  }

  @override
  $ExerciseAliasesTable createAlias(String alias) {
    return $ExerciseAliasesTable(attachedDatabase, alias);
  }
}

class ExerciseAliasData extends DataClass
    implements Insertable<ExerciseAliasData> {
  final String id;
  final String exerciseId;
  final String aliasName;
  final bool isPrimary;
  const ExerciseAliasData({
    required this.id,
    required this.exerciseId,
    required this.aliasName,
    required this.isPrimary,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['alias_name'] = Variable<String>(aliasName);
    map['is_primary'] = Variable<bool>(isPrimary);
    return map;
  }

  ExerciseAliasesCompanion toCompanion(bool nullToAbsent) {
    return ExerciseAliasesCompanion(
      id: Value(id),
      exerciseId: Value(exerciseId),
      aliasName: Value(aliasName),
      isPrimary: Value(isPrimary),
    );
  }

  factory ExerciseAliasData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseAliasData(
      id: serializer.fromJson<String>(json['id']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      aliasName: serializer.fromJson<String>(json['aliasName']),
      isPrimary: serializer.fromJson<bool>(json['isPrimary']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'aliasName': serializer.toJson<String>(aliasName),
      'isPrimary': serializer.toJson<bool>(isPrimary),
    };
  }

  ExerciseAliasData copyWith({
    String? id,
    String? exerciseId,
    String? aliasName,
    bool? isPrimary,
  }) => ExerciseAliasData(
    id: id ?? this.id,
    exerciseId: exerciseId ?? this.exerciseId,
    aliasName: aliasName ?? this.aliasName,
    isPrimary: isPrimary ?? this.isPrimary,
  );
  ExerciseAliasData copyWithCompanion(ExerciseAliasesCompanion data) {
    return ExerciseAliasData(
      id: data.id.present ? data.id.value : this.id,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      aliasName: data.aliasName.present ? data.aliasName.value : this.aliasName,
      isPrimary: data.isPrimary.present ? data.isPrimary.value : this.isPrimary,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseAliasData(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('aliasName: $aliasName, ')
          ..write('isPrimary: $isPrimary')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, exerciseId, aliasName, isPrimary);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseAliasData &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.aliasName == this.aliasName &&
          other.isPrimary == this.isPrimary);
}

class ExerciseAliasesCompanion extends UpdateCompanion<ExerciseAliasData> {
  final Value<String> id;
  final Value<String> exerciseId;
  final Value<String> aliasName;
  final Value<bool> isPrimary;
  final Value<int> rowid;
  const ExerciseAliasesCompanion({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.aliasName = const Value.absent(),
    this.isPrimary = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExerciseAliasesCompanion.insert({
    required String id,
    required String exerciseId,
    required String aliasName,
    this.isPrimary = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       exerciseId = Value(exerciseId),
       aliasName = Value(aliasName);
  static Insertable<ExerciseAliasData> custom({
    Expression<String>? id,
    Expression<String>? exerciseId,
    Expression<String>? aliasName,
    Expression<bool>? isPrimary,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (aliasName != null) 'alias_name': aliasName,
      if (isPrimary != null) 'is_primary': isPrimary,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExerciseAliasesCompanion copyWith({
    Value<String>? id,
    Value<String>? exerciseId,
    Value<String>? aliasName,
    Value<bool>? isPrimary,
    Value<int>? rowid,
  }) {
    return ExerciseAliasesCompanion(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      aliasName: aliasName ?? this.aliasName,
      isPrimary: isPrimary ?? this.isPrimary,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (aliasName.present) {
      map['alias_name'] = Variable<String>(aliasName.value);
    }
    if (isPrimary.present) {
      map['is_primary'] = Variable<bool>(isPrimary.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseAliasesCompanion(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('aliasName: $aliasName, ')
          ..write('isPrimary: $isPrimary, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SubstitutionFeedbackTable extends SubstitutionFeedback
    with TableInfo<$SubstitutionFeedbackTable, SubstitutionFeedbackData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubstitutionFeedbackTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceExerciseIdMeta = const VerificationMeta(
    'sourceExerciseId',
  );
  @override
  late final GeneratedColumn<String> sourceExerciseId = GeneratedColumn<String>(
    'source_exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercises (id)',
    ),
  );
  static const VerificationMeta _rejectedExerciseIdMeta =
      const VerificationMeta('rejectedExerciseId');
  @override
  late final GeneratedColumn<String> rejectedExerciseId =
      GeneratedColumn<String>(
        'rejected_exercise_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES exercises (id)',
        ),
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    sourceExerciseId,
    rejectedExerciseId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'substitution_feedback';
  @override
  VerificationContext validateIntegrity(
    Insertable<SubstitutionFeedbackData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('source_exercise_id')) {
      context.handle(
        _sourceExerciseIdMeta,
        sourceExerciseId.isAcceptableOrUnknown(
          data['source_exercise_id']!,
          _sourceExerciseIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceExerciseIdMeta);
    }
    if (data.containsKey('rejected_exercise_id')) {
      context.handle(
        _rejectedExerciseIdMeta,
        rejectedExerciseId.isAcceptableOrUnknown(
          data['rejected_exercise_id']!,
          _rejectedExerciseIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rejectedExerciseIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {userId, sourceExerciseId, rejectedExerciseId},
  ];
  @override
  SubstitutionFeedbackData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SubstitutionFeedbackData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      sourceExerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_exercise_id'],
      )!,
      rejectedExerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rejected_exercise_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SubstitutionFeedbackTable createAlias(String alias) {
    return $SubstitutionFeedbackTable(attachedDatabase, alias);
  }
}

class SubstitutionFeedbackData extends DataClass
    implements Insertable<SubstitutionFeedbackData> {
  final String id;
  final String userId;
  final String sourceExerciseId;
  final String rejectedExerciseId;
  final String createdAt;
  const SubstitutionFeedbackData({
    required this.id,
    required this.userId,
    required this.sourceExerciseId,
    required this.rejectedExerciseId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['source_exercise_id'] = Variable<String>(sourceExerciseId);
    map['rejected_exercise_id'] = Variable<String>(rejectedExerciseId);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  SubstitutionFeedbackCompanion toCompanion(bool nullToAbsent) {
    return SubstitutionFeedbackCompanion(
      id: Value(id),
      userId: Value(userId),
      sourceExerciseId: Value(sourceExerciseId),
      rejectedExerciseId: Value(rejectedExerciseId),
      createdAt: Value(createdAt),
    );
  }

  factory SubstitutionFeedbackData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SubstitutionFeedbackData(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      sourceExerciseId: serializer.fromJson<String>(json['sourceExerciseId']),
      rejectedExerciseId: serializer.fromJson<String>(
        json['rejectedExerciseId'],
      ),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'sourceExerciseId': serializer.toJson<String>(sourceExerciseId),
      'rejectedExerciseId': serializer.toJson<String>(rejectedExerciseId),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  SubstitutionFeedbackData copyWith({
    String? id,
    String? userId,
    String? sourceExerciseId,
    String? rejectedExerciseId,
    String? createdAt,
  }) => SubstitutionFeedbackData(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    sourceExerciseId: sourceExerciseId ?? this.sourceExerciseId,
    rejectedExerciseId: rejectedExerciseId ?? this.rejectedExerciseId,
    createdAt: createdAt ?? this.createdAt,
  );
  SubstitutionFeedbackData copyWithCompanion(
    SubstitutionFeedbackCompanion data,
  ) {
    return SubstitutionFeedbackData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      sourceExerciseId: data.sourceExerciseId.present
          ? data.sourceExerciseId.value
          : this.sourceExerciseId,
      rejectedExerciseId: data.rejectedExerciseId.present
          ? data.rejectedExerciseId.value
          : this.rejectedExerciseId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SubstitutionFeedbackData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('sourceExerciseId: $sourceExerciseId, ')
          ..write('rejectedExerciseId: $rejectedExerciseId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, sourceExerciseId, rejectedExerciseId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SubstitutionFeedbackData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.sourceExerciseId == this.sourceExerciseId &&
          other.rejectedExerciseId == this.rejectedExerciseId &&
          other.createdAt == this.createdAt);
}

class SubstitutionFeedbackCompanion
    extends UpdateCompanion<SubstitutionFeedbackData> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> sourceExerciseId;
  final Value<String> rejectedExerciseId;
  final Value<String> createdAt;
  final Value<int> rowid;
  const SubstitutionFeedbackCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.sourceExerciseId = const Value.absent(),
    this.rejectedExerciseId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SubstitutionFeedbackCompanion.insert({
    required String id,
    required String userId,
    required String sourceExerciseId,
    required String rejectedExerciseId,
    required String createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       sourceExerciseId = Value(sourceExerciseId),
       rejectedExerciseId = Value(rejectedExerciseId),
       createdAt = Value(createdAt);
  static Insertable<SubstitutionFeedbackData> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? sourceExerciseId,
    Expression<String>? rejectedExerciseId,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (sourceExerciseId != null) 'source_exercise_id': sourceExerciseId,
      if (rejectedExerciseId != null)
        'rejected_exercise_id': rejectedExerciseId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SubstitutionFeedbackCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? sourceExerciseId,
    Value<String>? rejectedExerciseId,
    Value<String>? createdAt,
    Value<int>? rowid,
  }) {
    return SubstitutionFeedbackCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      sourceExerciseId: sourceExerciseId ?? this.sourceExerciseId,
      rejectedExerciseId: rejectedExerciseId ?? this.rejectedExerciseId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (sourceExerciseId.present) {
      map['source_exercise_id'] = Variable<String>(sourceExerciseId.value);
    }
    if (rejectedExerciseId.present) {
      map['rejected_exercise_id'] = Variable<String>(rejectedExerciseId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubstitutionFeedbackCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('sourceExerciseId: $sourceExerciseId, ')
          ..write('rejectedExerciseId: $rejectedExerciseId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncAction, String> action =
      GeneratedColumn<String>(
        'action',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<SyncAction>($SyncQueueTable.$converteraction);
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('pending'),
      ).withConverter<SyncStatus>($SyncQueueTable.$converterstatus);
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _processedAtMeta = const VerificationMeta(
    'processedAt',
  );
  @override
  late final GeneratedColumn<String> processedAt = GeneratedColumn<String>(
    'processed_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    action,
    payload,
    status,
    retryCount,
    lastError,
    createdAt,
    processedAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('processed_at')) {
      context.handle(
        _processedAtMeta,
        processedAt.isAcceptableOrUnknown(
          data['processed_at']!,
          _processedAtMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      action: $SyncQueueTable.$converteraction.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}action'],
        )!,
      ),
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      status: $SyncQueueTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      processedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}processed_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }

  static TypeConverter<SyncAction, String> $converteraction =
      const SyncActionConverter();
  static TypeConverter<SyncStatus, String> $converterstatus =
      const SyncStatusConverter();
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final String id;
  final SyncAction action;
  final String payload;
  final SyncStatus status;
  final int retryCount;
  final String? lastError;
  final String createdAt;
  final String? processedAt;
  final String? updatedAt;
  const SyncQueueData({
    required this.id,
    required this.action,
    required this.payload,
    required this.status,
    required this.retryCount,
    this.lastError,
    required this.createdAt,
    this.processedAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['action'] = Variable<String>(
        $SyncQueueTable.$converteraction.toSql(action),
      );
    }
    map['payload'] = Variable<String>(payload);
    {
      map['status'] = Variable<String>(
        $SyncQueueTable.$converterstatus.toSql(status),
      );
    }
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    map['created_at'] = Variable<String>(createdAt);
    if (!nullToAbsent || processedAt != null) {
      map['processed_at'] = Variable<String>(processedAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      action: Value(action),
      payload: Value(payload),
      status: Value(status),
      retryCount: Value(retryCount),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      createdAt: Value(createdAt),
      processedAt: processedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(processedAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory SyncQueueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<String>(json['id']),
      action: serializer.fromJson<SyncAction>(json['action']),
      payload: serializer.fromJson<String>(json['payload']),
      status: serializer.fromJson<SyncStatus>(json['status']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      processedAt: serializer.fromJson<String?>(json['processedAt']),
      updatedAt: serializer.fromJson<String?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'action': serializer.toJson<SyncAction>(action),
      'payload': serializer.toJson<String>(payload),
      'status': serializer.toJson<SyncStatus>(status),
      'retryCount': serializer.toJson<int>(retryCount),
      'lastError': serializer.toJson<String?>(lastError),
      'createdAt': serializer.toJson<String>(createdAt),
      'processedAt': serializer.toJson<String?>(processedAt),
      'updatedAt': serializer.toJson<String?>(updatedAt),
    };
  }

  SyncQueueData copyWith({
    String? id,
    SyncAction? action,
    String? payload,
    SyncStatus? status,
    int? retryCount,
    Value<String?> lastError = const Value.absent(),
    String? createdAt,
    Value<String?> processedAt = const Value.absent(),
    Value<String?> updatedAt = const Value.absent(),
  }) => SyncQueueData(
    id: id ?? this.id,
    action: action ?? this.action,
    payload: payload ?? this.payload,
    status: status ?? this.status,
    retryCount: retryCount ?? this.retryCount,
    lastError: lastError.present ? lastError.value : this.lastError,
    createdAt: createdAt ?? this.createdAt,
    processedAt: processedAt.present ? processedAt.value : this.processedAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      action: data.action.present ? data.action.value : this.action,
      payload: data.payload.present ? data.payload.value : this.payload,
      status: data.status.present ? data.status.value : this.status,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      processedAt: data.processedAt.present
          ? data.processedAt.value
          : this.processedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('action: $action, ')
          ..write('payload: $payload, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('processedAt: $processedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    action,
    payload,
    status,
    retryCount,
    lastError,
    createdAt,
    processedAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.action == this.action &&
          other.payload == this.payload &&
          other.status == this.status &&
          other.retryCount == this.retryCount &&
          other.lastError == this.lastError &&
          other.createdAt == this.createdAt &&
          other.processedAt == this.processedAt &&
          other.updatedAt == this.updatedAt);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<String> id;
  final Value<SyncAction> action;
  final Value<String> payload;
  final Value<SyncStatus> status;
  final Value<int> retryCount;
  final Value<String?> lastError;
  final Value<String> createdAt;
  final Value<String?> processedAt;
  final Value<String?> updatedAt;
  final Value<int> rowid;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.action = const Value.absent(),
    this.payload = const Value.absent(),
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.processedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    required String id,
    required SyncAction action,
    required String payload,
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
    required String createdAt,
    this.processedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       action = Value(action),
       payload = Value(payload),
       createdAt = Value(createdAt);
  static Insertable<SyncQueueData> custom({
    Expression<String>? id,
    Expression<String>? action,
    Expression<String>? payload,
    Expression<String>? status,
    Expression<int>? retryCount,
    Expression<String>? lastError,
    Expression<String>? createdAt,
    Expression<String>? processedAt,
    Expression<String>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (action != null) 'action': action,
      if (payload != null) 'payload': payload,
      if (status != null) 'status': status,
      if (retryCount != null) 'retry_count': retryCount,
      if (lastError != null) 'last_error': lastError,
      if (createdAt != null) 'created_at': createdAt,
      if (processedAt != null) 'processed_at': processedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncQueueCompanion copyWith({
    Value<String>? id,
    Value<SyncAction>? action,
    Value<String>? payload,
    Value<SyncStatus>? status,
    Value<int>? retryCount,
    Value<String?>? lastError,
    Value<String>? createdAt,
    Value<String?>? processedAt,
    Value<String?>? updatedAt,
    Value<int>? rowid,
  }) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      action: action ?? this.action,
      payload: payload ?? this.payload,
      status: status ?? this.status,
      retryCount: retryCount ?? this.retryCount,
      lastError: lastError ?? this.lastError,
      createdAt: createdAt ?? this.createdAt,
      processedAt: processedAt ?? this.processedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(
        $SyncQueueTable.$converteraction.toSql(action.value),
      );
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $SyncQueueTable.$converterstatus.toSql(status.value),
      );
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (processedAt.present) {
      map['processed_at'] = Variable<String>(processedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('action: $action, ')
          ..write('payload: $payload, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('processedAt: $processedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserPreferencesTable extends UserPreferences
    with TableInfo<$UserPreferencesTable, UserPreferenceData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercises (id)',
    ),
  );
  static const VerificationMeta _preferenceScoreMeta = const VerificationMeta(
    'preferenceScore',
  );
  @override
  late final GeneratedColumn<double> preferenceScore = GeneratedColumn<double>(
    'preference_score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _isBlacklistedMeta = const VerificationMeta(
    'isBlacklisted',
  );
  @override
  late final GeneratedColumn<bool> isBlacklisted = GeneratedColumn<bool>(
    'is_blacklisted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_blacklisted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    userId,
    exerciseId,
    preferenceScore,
    isBlacklisted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserPreferenceData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('preference_score')) {
      context.handle(
        _preferenceScoreMeta,
        preferenceScore.isAcceptableOrUnknown(
          data['preference_score']!,
          _preferenceScoreMeta,
        ),
      );
    }
    if (data.containsKey('is_blacklisted')) {
      context.handle(
        _isBlacklistedMeta,
        isBlacklisted.isAcceptableOrUnknown(
          data['is_blacklisted']!,
          _isBlacklistedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId, exerciseId};
  @override
  UserPreferenceData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserPreferenceData(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      preferenceScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}preference_score'],
      )!,
      isBlacklisted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_blacklisted'],
      )!,
    );
  }

  @override
  $UserPreferencesTable createAlias(String alias) {
    return $UserPreferencesTable(attachedDatabase, alias);
  }
}

class UserPreferenceData extends DataClass
    implements Insertable<UserPreferenceData> {
  final String userId;
  final String exerciseId;
  final double preferenceScore;
  final bool isBlacklisted;
  const UserPreferenceData({
    required this.userId,
    required this.exerciseId,
    required this.preferenceScore,
    required this.isBlacklisted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['preference_score'] = Variable<double>(preferenceScore);
    map['is_blacklisted'] = Variable<bool>(isBlacklisted);
    return map;
  }

  UserPreferencesCompanion toCompanion(bool nullToAbsent) {
    return UserPreferencesCompanion(
      userId: Value(userId),
      exerciseId: Value(exerciseId),
      preferenceScore: Value(preferenceScore),
      isBlacklisted: Value(isBlacklisted),
    );
  }

  factory UserPreferenceData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserPreferenceData(
      userId: serializer.fromJson<String>(json['userId']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      preferenceScore: serializer.fromJson<double>(json['preferenceScore']),
      isBlacklisted: serializer.fromJson<bool>(json['isBlacklisted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'preferenceScore': serializer.toJson<double>(preferenceScore),
      'isBlacklisted': serializer.toJson<bool>(isBlacklisted),
    };
  }

  UserPreferenceData copyWith({
    String? userId,
    String? exerciseId,
    double? preferenceScore,
    bool? isBlacklisted,
  }) => UserPreferenceData(
    userId: userId ?? this.userId,
    exerciseId: exerciseId ?? this.exerciseId,
    preferenceScore: preferenceScore ?? this.preferenceScore,
    isBlacklisted: isBlacklisted ?? this.isBlacklisted,
  );
  UserPreferenceData copyWithCompanion(UserPreferencesCompanion data) {
    return UserPreferenceData(
      userId: data.userId.present ? data.userId.value : this.userId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      preferenceScore: data.preferenceScore.present
          ? data.preferenceScore.value
          : this.preferenceScore,
      isBlacklisted: data.isBlacklisted.present
          ? data.isBlacklisted.value
          : this.isBlacklisted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserPreferenceData(')
          ..write('userId: $userId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('preferenceScore: $preferenceScore, ')
          ..write('isBlacklisted: $isBlacklisted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(userId, exerciseId, preferenceScore, isBlacklisted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserPreferenceData &&
          other.userId == this.userId &&
          other.exerciseId == this.exerciseId &&
          other.preferenceScore == this.preferenceScore &&
          other.isBlacklisted == this.isBlacklisted);
}

class UserPreferencesCompanion extends UpdateCompanion<UserPreferenceData> {
  final Value<String> userId;
  final Value<String> exerciseId;
  final Value<double> preferenceScore;
  final Value<bool> isBlacklisted;
  final Value<int> rowid;
  const UserPreferencesCompanion({
    this.userId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.preferenceScore = const Value.absent(),
    this.isBlacklisted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserPreferencesCompanion.insert({
    required String userId,
    required String exerciseId,
    this.preferenceScore = const Value.absent(),
    this.isBlacklisted = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       exerciseId = Value(exerciseId);
  static Insertable<UserPreferenceData> custom({
    Expression<String>? userId,
    Expression<String>? exerciseId,
    Expression<double>? preferenceScore,
    Expression<bool>? isBlacklisted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (preferenceScore != null) 'preference_score': preferenceScore,
      if (isBlacklisted != null) 'is_blacklisted': isBlacklisted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserPreferencesCompanion copyWith({
    Value<String>? userId,
    Value<String>? exerciseId,
    Value<double>? preferenceScore,
    Value<bool>? isBlacklisted,
    Value<int>? rowid,
  }) {
    return UserPreferencesCompanion(
      userId: userId ?? this.userId,
      exerciseId: exerciseId ?? this.exerciseId,
      preferenceScore: preferenceScore ?? this.preferenceScore,
      isBlacklisted: isBlacklisted ?? this.isBlacklisted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (preferenceScore.present) {
      map['preference_score'] = Variable<double>(preferenceScore.value);
    }
    if (isBlacklisted.present) {
      map['is_blacklisted'] = Variable<bool>(isBlacklisted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserPreferencesCompanion(')
          ..write('userId: $userId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('preferenceScore: $preferenceScore, ')
          ..write('isBlacklisted: $isBlacklisted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserMuscleConstraintsTable extends UserMuscleConstraints
    with TableInfo<$UserMuscleConstraintsTable, UserMuscleConstraintData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserMuscleConstraintsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _muscleIdMeta = const VerificationMeta(
    'muscleId',
  );
  @override
  late final GeneratedColumn<String> muscleId = GeneratedColumn<String>(
    'muscle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES muscle_regions (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<MuscleConstraintStatus, String>
  status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<MuscleConstraintStatus>(
        $UserMuscleConstraintsTable.$converterstatus,
      );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<String> expiresAt = GeneratedColumn<String>(
    'expires_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [userId, muscleId, status, expiresAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_muscle_constraints';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserMuscleConstraintData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('muscle_id')) {
      context.handle(
        _muscleIdMeta,
        muscleId.isAcceptableOrUnknown(data['muscle_id']!, _muscleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_muscleIdMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId, muscleId};
  @override
  UserMuscleConstraintData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserMuscleConstraintData(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      muscleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}muscle_id'],
      )!,
      status: $UserMuscleConstraintsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}expires_at'],
      ),
    );
  }

  @override
  $UserMuscleConstraintsTable createAlias(String alias) {
    return $UserMuscleConstraintsTable(attachedDatabase, alias);
  }

  static TypeConverter<MuscleConstraintStatus, String> $converterstatus =
      const MuscleConstraintStatusConverter();
}

class UserMuscleConstraintData extends DataClass
    implements Insertable<UserMuscleConstraintData> {
  final String userId;
  final String muscleId;
  final MuscleConstraintStatus status;
  final String? expiresAt;
  const UserMuscleConstraintData({
    required this.userId,
    required this.muscleId,
    required this.status,
    this.expiresAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['muscle_id'] = Variable<String>(muscleId);
    {
      map['status'] = Variable<String>(
        $UserMuscleConstraintsTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || expiresAt != null) {
      map['expires_at'] = Variable<String>(expiresAt);
    }
    return map;
  }

  UserMuscleConstraintsCompanion toCompanion(bool nullToAbsent) {
    return UserMuscleConstraintsCompanion(
      userId: Value(userId),
      muscleId: Value(muscleId),
      status: Value(status),
      expiresAt: expiresAt == null && nullToAbsent
          ? const Value.absent()
          : Value(expiresAt),
    );
  }

  factory UserMuscleConstraintData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserMuscleConstraintData(
      userId: serializer.fromJson<String>(json['userId']),
      muscleId: serializer.fromJson<String>(json['muscleId']),
      status: serializer.fromJson<MuscleConstraintStatus>(json['status']),
      expiresAt: serializer.fromJson<String?>(json['expiresAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'muscleId': serializer.toJson<String>(muscleId),
      'status': serializer.toJson<MuscleConstraintStatus>(status),
      'expiresAt': serializer.toJson<String?>(expiresAt),
    };
  }

  UserMuscleConstraintData copyWith({
    String? userId,
    String? muscleId,
    MuscleConstraintStatus? status,
    Value<String?> expiresAt = const Value.absent(),
  }) => UserMuscleConstraintData(
    userId: userId ?? this.userId,
    muscleId: muscleId ?? this.muscleId,
    status: status ?? this.status,
    expiresAt: expiresAt.present ? expiresAt.value : this.expiresAt,
  );
  UserMuscleConstraintData copyWithCompanion(
    UserMuscleConstraintsCompanion data,
  ) {
    return UserMuscleConstraintData(
      userId: data.userId.present ? data.userId.value : this.userId,
      muscleId: data.muscleId.present ? data.muscleId.value : this.muscleId,
      status: data.status.present ? data.status.value : this.status,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserMuscleConstraintData(')
          ..write('userId: $userId, ')
          ..write('muscleId: $muscleId, ')
          ..write('status: $status, ')
          ..write('expiresAt: $expiresAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userId, muscleId, status, expiresAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserMuscleConstraintData &&
          other.userId == this.userId &&
          other.muscleId == this.muscleId &&
          other.status == this.status &&
          other.expiresAt == this.expiresAt);
}

class UserMuscleConstraintsCompanion
    extends UpdateCompanion<UserMuscleConstraintData> {
  final Value<String> userId;
  final Value<String> muscleId;
  final Value<MuscleConstraintStatus> status;
  final Value<String?> expiresAt;
  final Value<int> rowid;
  const UserMuscleConstraintsCompanion({
    this.userId = const Value.absent(),
    this.muscleId = const Value.absent(),
    this.status = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserMuscleConstraintsCompanion.insert({
    required String userId,
    required String muscleId,
    required MuscleConstraintStatus status,
    this.expiresAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       muscleId = Value(muscleId),
       status = Value(status);
  static Insertable<UserMuscleConstraintData> custom({
    Expression<String>? userId,
    Expression<String>? muscleId,
    Expression<String>? status,
    Expression<String>? expiresAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (muscleId != null) 'muscle_id': muscleId,
      if (status != null) 'status': status,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserMuscleConstraintsCompanion copyWith({
    Value<String>? userId,
    Value<String>? muscleId,
    Value<MuscleConstraintStatus>? status,
    Value<String?>? expiresAt,
    Value<int>? rowid,
  }) {
    return UserMuscleConstraintsCompanion(
      userId: userId ?? this.userId,
      muscleId: muscleId ?? this.muscleId,
      status: status ?? this.status,
      expiresAt: expiresAt ?? this.expiresAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (muscleId.present) {
      map['muscle_id'] = Variable<String>(muscleId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $UserMuscleConstraintsTable.$converterstatus.toSql(status.value),
      );
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<String>(expiresAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserMuscleConstraintsCompanion(')
          ..write('userId: $userId, ')
          ..write('muscleId: $muscleId, ')
          ..write('status: $status, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutsTable extends Workouts with TableInfo<$WorkoutsTable, Workout> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<WorkoutStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<WorkoutStatus>($WorkoutsTable.$converterstatus);
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _volumeLoadMeta = const VerificationMeta(
    'volumeLoad',
  );
  @override
  late final GeneratedColumn<double> volumeLoad = GeneratedColumn<double>(
    'volume_load',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    name,
    status,
    startedAt,
    completedAt,
    volumeLoad,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workouts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Workout> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('volume_load')) {
      context.handle(
        _volumeLoadMeta,
        volumeLoad.isAcceptableOrUnknown(data['volume_load']!, _volumeLoadMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Workout map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Workout(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      status: $WorkoutsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      volumeLoad: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}volume_load'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $WorkoutsTable createAlias(String alias) {
    return $WorkoutsTable(attachedDatabase, alias);
  }

  static TypeConverter<WorkoutStatus, String> $converterstatus =
      const WorkoutStatusConverter();
}

class Workout extends DataClass implements Insertable<Workout> {
  final String id;
  final String userId;
  final String? name;
  final WorkoutStatus status;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final double volumeLoad;
  final DateTime createdAt;
  const Workout({
    required this.id,
    required this.userId,
    this.name,
    required this.status,
    this.startedAt,
    this.completedAt,
    required this.volumeLoad,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    {
      map['status'] = Variable<String>(
        $WorkoutsTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<DateTime>(startedAt);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['volume_load'] = Variable<double>(volumeLoad);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WorkoutsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutsCompanion(
      id: Value(id),
      userId: Value(userId),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      status: Value(status),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      volumeLoad: Value(volumeLoad),
      createdAt: Value(createdAt),
    );
  }

  factory Workout.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Workout(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      name: serializer.fromJson<String?>(json['name']),
      status: serializer.fromJson<WorkoutStatus>(json['status']),
      startedAt: serializer.fromJson<DateTime?>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      volumeLoad: serializer.fromJson<double>(json['volumeLoad']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'name': serializer.toJson<String?>(name),
      'status': serializer.toJson<WorkoutStatus>(status),
      'startedAt': serializer.toJson<DateTime?>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'volumeLoad': serializer.toJson<double>(volumeLoad),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Workout copyWith({
    String? id,
    String? userId,
    Value<String?> name = const Value.absent(),
    WorkoutStatus? status,
    Value<DateTime?> startedAt = const Value.absent(),
    Value<DateTime?> completedAt = const Value.absent(),
    double? volumeLoad,
    DateTime? createdAt,
  }) => Workout(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    name: name.present ? name.value : this.name,
    status: status ?? this.status,
    startedAt: startedAt.present ? startedAt.value : this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    volumeLoad: volumeLoad ?? this.volumeLoad,
    createdAt: createdAt ?? this.createdAt,
  );
  Workout copyWithCompanion(WorkoutsCompanion data) {
    return Workout(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      status: data.status.present ? data.status.value : this.status,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      volumeLoad: data.volumeLoad.present
          ? data.volumeLoad.value
          : this.volumeLoad,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Workout(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('status: $status, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('volumeLoad: $volumeLoad, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    name,
    status,
    startedAt,
    completedAt,
    volumeLoad,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Workout &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.status == this.status &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.volumeLoad == this.volumeLoad &&
          other.createdAt == this.createdAt);
}

class WorkoutsCompanion extends UpdateCompanion<Workout> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String?> name;
  final Value<WorkoutStatus> status;
  final Value<DateTime?> startedAt;
  final Value<DateTime?> completedAt;
  final Value<double> volumeLoad;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const WorkoutsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.status = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.volumeLoad = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutsCompanion.insert({
    required String id,
    required String userId,
    this.name = const Value.absent(),
    required WorkoutStatus status,
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.volumeLoad = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       status = Value(status);
  static Insertable<Workout> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<String>? status,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<double>? volumeLoad,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (status != null) 'status': status,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (volumeLoad != null) 'volume_load': volumeLoad,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutsCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String?>? name,
    Value<WorkoutStatus>? status,
    Value<DateTime?>? startedAt,
    Value<DateTime?>? completedAt,
    Value<double>? volumeLoad,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return WorkoutsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      status: status ?? this.status,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      volumeLoad: volumeLoad ?? this.volumeLoad,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $WorkoutsTable.$converterstatus.toSql(status.value),
      );
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (volumeLoad.present) {
      map['volume_load'] = Variable<double>(volumeLoad.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('status: $status, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('volumeLoad: $volumeLoad, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutExercisesTable extends WorkoutExercises
    with TableInfo<$WorkoutExercisesTable, WorkoutExercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workoutIdMeta = const VerificationMeta(
    'workoutId',
  );
  @override
  late final GeneratedColumn<String> workoutId = GeneratedColumn<String>(
    'workout_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workouts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercises (id)',
    ),
  );
  static const VerificationMeta _orderIndexMeta = const VerificationMeta(
    'orderIndex',
  );
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    workoutId,
    exerciseId,
    orderIndex,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutExercise> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workout_id')) {
      context.handle(
        _workoutIdMeta,
        workoutId.isAcceptableOrUnknown(data['workout_id']!, _workoutIdMeta),
      );
    } else if (isInserting) {
      context.missing(_workoutIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutExercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutExercise(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      workoutId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workout_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      orderIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_index'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $WorkoutExercisesTable createAlias(String alias) {
    return $WorkoutExercisesTable(attachedDatabase, alias);
  }
}

class WorkoutExercise extends DataClass implements Insertable<WorkoutExercise> {
  final String id;
  final String workoutId;
  final String exerciseId;
  final int orderIndex;
  final String? notes;
  final DateTime createdAt;
  const WorkoutExercise({
    required this.id,
    required this.workoutId,
    required this.exerciseId,
    required this.orderIndex,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workout_id'] = Variable<String>(workoutId);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['order_index'] = Variable<int>(orderIndex);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WorkoutExercisesCompanion toCompanion(bool nullToAbsent) {
    return WorkoutExercisesCompanion(
      id: Value(id),
      workoutId: Value(workoutId),
      exerciseId: Value(exerciseId),
      orderIndex: Value(orderIndex),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory WorkoutExercise.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutExercise(
      id: serializer.fromJson<String>(json['id']),
      workoutId: serializer.fromJson<String>(json['workoutId']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workoutId': serializer.toJson<String>(workoutId),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  WorkoutExercise copyWith({
    String? id,
    String? workoutId,
    String? exerciseId,
    int? orderIndex,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => WorkoutExercise(
    id: id ?? this.id,
    workoutId: workoutId ?? this.workoutId,
    exerciseId: exerciseId ?? this.exerciseId,
    orderIndex: orderIndex ?? this.orderIndex,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  WorkoutExercise copyWithCompanion(WorkoutExercisesCompanion data) {
    return WorkoutExercise(
      id: data.id.present ? data.id.value : this.id,
      workoutId: data.workoutId.present ? data.workoutId.value : this.workoutId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      orderIndex: data.orderIndex.present
          ? data.orderIndex.value
          : this.orderIndex,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutExercise(')
          ..write('id: $id, ')
          ..write('workoutId: $workoutId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, workoutId, exerciseId, orderIndex, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutExercise &&
          other.id == this.id &&
          other.workoutId == this.workoutId &&
          other.exerciseId == this.exerciseId &&
          other.orderIndex == this.orderIndex &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class WorkoutExercisesCompanion extends UpdateCompanion<WorkoutExercise> {
  final Value<String> id;
  final Value<String> workoutId;
  final Value<String> exerciseId;
  final Value<int> orderIndex;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const WorkoutExercisesCompanion({
    this.id = const Value.absent(),
    this.workoutId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutExercisesCompanion.insert({
    required String id,
    required String workoutId,
    required String exerciseId,
    required int orderIndex,
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       workoutId = Value(workoutId),
       exerciseId = Value(exerciseId),
       orderIndex = Value(orderIndex);
  static Insertable<WorkoutExercise> custom({
    Expression<String>? id,
    Expression<String>? workoutId,
    Expression<String>? exerciseId,
    Expression<int>? orderIndex,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workoutId != null) 'workout_id': workoutId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (orderIndex != null) 'order_index': orderIndex,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutExercisesCompanion copyWith({
    Value<String>? id,
    Value<String>? workoutId,
    Value<String>? exerciseId,
    Value<int>? orderIndex,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return WorkoutExercisesCompanion(
      id: id ?? this.id,
      workoutId: workoutId ?? this.workoutId,
      exerciseId: exerciseId ?? this.exerciseId,
      orderIndex: orderIndex ?? this.orderIndex,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workoutId.present) {
      map['workout_id'] = Variable<String>(workoutId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutExercisesCompanion(')
          ..write('id: $id, ')
          ..write('workoutId: $workoutId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutSetsTable extends WorkoutSets
    with TableInfo<$WorkoutSetsTable, WorkoutSet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutSetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workoutExerciseIdMeta = const VerificationMeta(
    'workoutExerciseId',
  );
  @override
  late final GeneratedColumn<String> workoutExerciseId =
      GeneratedColumn<String>(
        'workout_exercise_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES workout_exercises (id) ON DELETE CASCADE',
        ),
      );
  @override
  late final GeneratedColumnWithTypeConverter<SetType, String> setType =
      GeneratedColumn<String>(
        'set_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<SetType>($WorkoutSetsTable.$convertersetType);
  @override
  late final GeneratedColumnWithTypeConverter<TrackingType, String>
  trackingType = GeneratedColumn<String>(
    'tracking_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('strength'),
  ).withConverter<TrackingType>($WorkoutSetsTable.$convertertrackingType);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
    'weight',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rpeMeta = const VerificationMeta('rpe');
  @override
  late final GeneratedColumn<double> rpe = GeneratedColumn<double>(
    'rpe',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _distanceMeta = const VerificationMeta(
    'distance',
  );
  @override
  late final GeneratedColumn<double> distance = GeneratedColumn<double>(
    'distance',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationMeta = const VerificationMeta(
    'duration',
  );
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
    'duration',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heartRateMeta = const VerificationMeta(
    'heartRate',
  );
  @override
  late final GeneratedColumn<int> heartRate = GeneratedColumn<int>(
    'heart_rate',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isPrMeta = const VerificationMeta('isPr');
  @override
  late final GeneratedColumn<bool> isPr = GeneratedColumn<bool>(
    'is_pr',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_pr" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _restSecondsMeta = const VerificationMeta(
    'restSeconds',
  );
  @override
  late final GeneratedColumn<int> restSeconds = GeneratedColumn<int>(
    'rest_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    workoutExerciseId,
    setType,
    trackingType,
    weight,
    reps,
    rpe,
    distance,
    duration,
    heartRate,
    isPr,
    restSeconds,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_sets';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutSet> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workout_exercise_id')) {
      context.handle(
        _workoutExerciseIdMeta,
        workoutExerciseId.isAcceptableOrUnknown(
          data['workout_exercise_id']!,
          _workoutExerciseIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workoutExerciseIdMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    }
    if (data.containsKey('rpe')) {
      context.handle(
        _rpeMeta,
        rpe.isAcceptableOrUnknown(data['rpe']!, _rpeMeta),
      );
    }
    if (data.containsKey('distance')) {
      context.handle(
        _distanceMeta,
        distance.isAcceptableOrUnknown(data['distance']!, _distanceMeta),
      );
    }
    if (data.containsKey('duration')) {
      context.handle(
        _durationMeta,
        duration.isAcceptableOrUnknown(data['duration']!, _durationMeta),
      );
    }
    if (data.containsKey('heart_rate')) {
      context.handle(
        _heartRateMeta,
        heartRate.isAcceptableOrUnknown(data['heart_rate']!, _heartRateMeta),
      );
    }
    if (data.containsKey('is_pr')) {
      context.handle(
        _isPrMeta,
        isPr.isAcceptableOrUnknown(data['is_pr']!, _isPrMeta),
      );
    }
    if (data.containsKey('rest_seconds')) {
      context.handle(
        _restSecondsMeta,
        restSeconds.isAcceptableOrUnknown(
          data['rest_seconds']!,
          _restSecondsMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutSet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutSet(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      workoutExerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workout_exercise_id'],
      )!,
      setType: $WorkoutSetsTable.$convertersetType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}set_type'],
        )!,
      ),
      trackingType: $WorkoutSetsTable.$convertertrackingType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}tracking_type'],
        )!,
      ),
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight'],
      ),
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      ),
      rpe: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rpe'],
      ),
      distance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}distance'],
      ),
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration'],
      ),
      heartRate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}heart_rate'],
      ),
      isPr: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_pr'],
      )!,
      restSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rest_seconds'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $WorkoutSetsTable createAlias(String alias) {
    return $WorkoutSetsTable(attachedDatabase, alias);
  }

  static TypeConverter<SetType, String> $convertersetType =
      const SetTypeConverter();
  static TypeConverter<TrackingType, String> $convertertrackingType =
      const TrackingTypeConverter();
}

class WorkoutSet extends DataClass implements Insertable<WorkoutSet> {
  final String id;
  final String workoutExerciseId;
  final SetType setType;
  final TrackingType trackingType;
  final double? weight;
  final int? reps;
  final double? rpe;
  final double? distance;
  final int? duration;
  final int? heartRate;
  final bool isPr;
  final int? restSeconds;
  final DateTime createdAt;
  const WorkoutSet({
    required this.id,
    required this.workoutExerciseId,
    required this.setType,
    required this.trackingType,
    this.weight,
    this.reps,
    this.rpe,
    this.distance,
    this.duration,
    this.heartRate,
    required this.isPr,
    this.restSeconds,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workout_exercise_id'] = Variable<String>(workoutExerciseId);
    {
      map['set_type'] = Variable<String>(
        $WorkoutSetsTable.$convertersetType.toSql(setType),
      );
    }
    {
      map['tracking_type'] = Variable<String>(
        $WorkoutSetsTable.$convertertrackingType.toSql(trackingType),
      );
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    if (!nullToAbsent || reps != null) {
      map['reps'] = Variable<int>(reps);
    }
    if (!nullToAbsent || rpe != null) {
      map['rpe'] = Variable<double>(rpe);
    }
    if (!nullToAbsent || distance != null) {
      map['distance'] = Variable<double>(distance);
    }
    if (!nullToAbsent || duration != null) {
      map['duration'] = Variable<int>(duration);
    }
    if (!nullToAbsent || heartRate != null) {
      map['heart_rate'] = Variable<int>(heartRate);
    }
    map['is_pr'] = Variable<bool>(isPr);
    if (!nullToAbsent || restSeconds != null) {
      map['rest_seconds'] = Variable<int>(restSeconds);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WorkoutSetsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutSetsCompanion(
      id: Value(id),
      workoutExerciseId: Value(workoutExerciseId),
      setType: Value(setType),
      trackingType: Value(trackingType),
      weight: weight == null && nullToAbsent
          ? const Value.absent()
          : Value(weight),
      reps: reps == null && nullToAbsent ? const Value.absent() : Value(reps),
      rpe: rpe == null && nullToAbsent ? const Value.absent() : Value(rpe),
      distance: distance == null && nullToAbsent
          ? const Value.absent()
          : Value(distance),
      duration: duration == null && nullToAbsent
          ? const Value.absent()
          : Value(duration),
      heartRate: heartRate == null && nullToAbsent
          ? const Value.absent()
          : Value(heartRate),
      isPr: Value(isPr),
      restSeconds: restSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(restSeconds),
      createdAt: Value(createdAt),
    );
  }

  factory WorkoutSet.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutSet(
      id: serializer.fromJson<String>(json['id']),
      workoutExerciseId: serializer.fromJson<String>(json['workoutExerciseId']),
      setType: serializer.fromJson<SetType>(json['setType']),
      trackingType: serializer.fromJson<TrackingType>(json['trackingType']),
      weight: serializer.fromJson<double?>(json['weight']),
      reps: serializer.fromJson<int?>(json['reps']),
      rpe: serializer.fromJson<double?>(json['rpe']),
      distance: serializer.fromJson<double?>(json['distance']),
      duration: serializer.fromJson<int?>(json['duration']),
      heartRate: serializer.fromJson<int?>(json['heartRate']),
      isPr: serializer.fromJson<bool>(json['isPr']),
      restSeconds: serializer.fromJson<int?>(json['restSeconds']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workoutExerciseId': serializer.toJson<String>(workoutExerciseId),
      'setType': serializer.toJson<SetType>(setType),
      'trackingType': serializer.toJson<TrackingType>(trackingType),
      'weight': serializer.toJson<double?>(weight),
      'reps': serializer.toJson<int?>(reps),
      'rpe': serializer.toJson<double?>(rpe),
      'distance': serializer.toJson<double?>(distance),
      'duration': serializer.toJson<int?>(duration),
      'heartRate': serializer.toJson<int?>(heartRate),
      'isPr': serializer.toJson<bool>(isPr),
      'restSeconds': serializer.toJson<int?>(restSeconds),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  WorkoutSet copyWith({
    String? id,
    String? workoutExerciseId,
    SetType? setType,
    TrackingType? trackingType,
    Value<double?> weight = const Value.absent(),
    Value<int?> reps = const Value.absent(),
    Value<double?> rpe = const Value.absent(),
    Value<double?> distance = const Value.absent(),
    Value<int?> duration = const Value.absent(),
    Value<int?> heartRate = const Value.absent(),
    bool? isPr,
    Value<int?> restSeconds = const Value.absent(),
    DateTime? createdAt,
  }) => WorkoutSet(
    id: id ?? this.id,
    workoutExerciseId: workoutExerciseId ?? this.workoutExerciseId,
    setType: setType ?? this.setType,
    trackingType: trackingType ?? this.trackingType,
    weight: weight.present ? weight.value : this.weight,
    reps: reps.present ? reps.value : this.reps,
    rpe: rpe.present ? rpe.value : this.rpe,
    distance: distance.present ? distance.value : this.distance,
    duration: duration.present ? duration.value : this.duration,
    heartRate: heartRate.present ? heartRate.value : this.heartRate,
    isPr: isPr ?? this.isPr,
    restSeconds: restSeconds.present ? restSeconds.value : this.restSeconds,
    createdAt: createdAt ?? this.createdAt,
  );
  WorkoutSet copyWithCompanion(WorkoutSetsCompanion data) {
    return WorkoutSet(
      id: data.id.present ? data.id.value : this.id,
      workoutExerciseId: data.workoutExerciseId.present
          ? data.workoutExerciseId.value
          : this.workoutExerciseId,
      setType: data.setType.present ? data.setType.value : this.setType,
      trackingType: data.trackingType.present
          ? data.trackingType.value
          : this.trackingType,
      weight: data.weight.present ? data.weight.value : this.weight,
      reps: data.reps.present ? data.reps.value : this.reps,
      rpe: data.rpe.present ? data.rpe.value : this.rpe,
      distance: data.distance.present ? data.distance.value : this.distance,
      duration: data.duration.present ? data.duration.value : this.duration,
      heartRate: data.heartRate.present ? data.heartRate.value : this.heartRate,
      isPr: data.isPr.present ? data.isPr.value : this.isPr,
      restSeconds: data.restSeconds.present
          ? data.restSeconds.value
          : this.restSeconds,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSet(')
          ..write('id: $id, ')
          ..write('workoutExerciseId: $workoutExerciseId, ')
          ..write('setType: $setType, ')
          ..write('trackingType: $trackingType, ')
          ..write('weight: $weight, ')
          ..write('reps: $reps, ')
          ..write('rpe: $rpe, ')
          ..write('distance: $distance, ')
          ..write('duration: $duration, ')
          ..write('heartRate: $heartRate, ')
          ..write('isPr: $isPr, ')
          ..write('restSeconds: $restSeconds, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    workoutExerciseId,
    setType,
    trackingType,
    weight,
    reps,
    rpe,
    distance,
    duration,
    heartRate,
    isPr,
    restSeconds,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutSet &&
          other.id == this.id &&
          other.workoutExerciseId == this.workoutExerciseId &&
          other.setType == this.setType &&
          other.trackingType == this.trackingType &&
          other.weight == this.weight &&
          other.reps == this.reps &&
          other.rpe == this.rpe &&
          other.distance == this.distance &&
          other.duration == this.duration &&
          other.heartRate == this.heartRate &&
          other.isPr == this.isPr &&
          other.restSeconds == this.restSeconds &&
          other.createdAt == this.createdAt);
}

class WorkoutSetsCompanion extends UpdateCompanion<WorkoutSet> {
  final Value<String> id;
  final Value<String> workoutExerciseId;
  final Value<SetType> setType;
  final Value<TrackingType> trackingType;
  final Value<double?> weight;
  final Value<int?> reps;
  final Value<double?> rpe;
  final Value<double?> distance;
  final Value<int?> duration;
  final Value<int?> heartRate;
  final Value<bool> isPr;
  final Value<int?> restSeconds;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const WorkoutSetsCompanion({
    this.id = const Value.absent(),
    this.workoutExerciseId = const Value.absent(),
    this.setType = const Value.absent(),
    this.trackingType = const Value.absent(),
    this.weight = const Value.absent(),
    this.reps = const Value.absent(),
    this.rpe = const Value.absent(),
    this.distance = const Value.absent(),
    this.duration = const Value.absent(),
    this.heartRate = const Value.absent(),
    this.isPr = const Value.absent(),
    this.restSeconds = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutSetsCompanion.insert({
    required String id,
    required String workoutExerciseId,
    required SetType setType,
    this.trackingType = const Value.absent(),
    this.weight = const Value.absent(),
    this.reps = const Value.absent(),
    this.rpe = const Value.absent(),
    this.distance = const Value.absent(),
    this.duration = const Value.absent(),
    this.heartRate = const Value.absent(),
    this.isPr = const Value.absent(),
    this.restSeconds = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       workoutExerciseId = Value(workoutExerciseId),
       setType = Value(setType);
  static Insertable<WorkoutSet> custom({
    Expression<String>? id,
    Expression<String>? workoutExerciseId,
    Expression<String>? setType,
    Expression<String>? trackingType,
    Expression<double>? weight,
    Expression<int>? reps,
    Expression<double>? rpe,
    Expression<double>? distance,
    Expression<int>? duration,
    Expression<int>? heartRate,
    Expression<bool>? isPr,
    Expression<int>? restSeconds,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workoutExerciseId != null) 'workout_exercise_id': workoutExerciseId,
      if (setType != null) 'set_type': setType,
      if (trackingType != null) 'tracking_type': trackingType,
      if (weight != null) 'weight': weight,
      if (reps != null) 'reps': reps,
      if (rpe != null) 'rpe': rpe,
      if (distance != null) 'distance': distance,
      if (duration != null) 'duration': duration,
      if (heartRate != null) 'heart_rate': heartRate,
      if (isPr != null) 'is_pr': isPr,
      if (restSeconds != null) 'rest_seconds': restSeconds,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutSetsCompanion copyWith({
    Value<String>? id,
    Value<String>? workoutExerciseId,
    Value<SetType>? setType,
    Value<TrackingType>? trackingType,
    Value<double?>? weight,
    Value<int?>? reps,
    Value<double?>? rpe,
    Value<double?>? distance,
    Value<int?>? duration,
    Value<int?>? heartRate,
    Value<bool>? isPr,
    Value<int?>? restSeconds,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return WorkoutSetsCompanion(
      id: id ?? this.id,
      workoutExerciseId: workoutExerciseId ?? this.workoutExerciseId,
      setType: setType ?? this.setType,
      trackingType: trackingType ?? this.trackingType,
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
      rpe: rpe ?? this.rpe,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      heartRate: heartRate ?? this.heartRate,
      isPr: isPr ?? this.isPr,
      restSeconds: restSeconds ?? this.restSeconds,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workoutExerciseId.present) {
      map['workout_exercise_id'] = Variable<String>(workoutExerciseId.value);
    }
    if (setType.present) {
      map['set_type'] = Variable<String>(
        $WorkoutSetsTable.$convertersetType.toSql(setType.value),
      );
    }
    if (trackingType.present) {
      map['tracking_type'] = Variable<String>(
        $WorkoutSetsTable.$convertertrackingType.toSql(trackingType.value),
      );
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (rpe.present) {
      map['rpe'] = Variable<double>(rpe.value);
    }
    if (distance.present) {
      map['distance'] = Variable<double>(distance.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (heartRate.present) {
      map['heart_rate'] = Variable<int>(heartRate.value);
    }
    if (isPr.present) {
      map['is_pr'] = Variable<bool>(isPr.value);
    }
    if (restSeconds.present) {
      map['rest_seconds'] = Variable<int>(restSeconds.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSetsCompanion(')
          ..write('id: $id, ')
          ..write('workoutExerciseId: $workoutExerciseId, ')
          ..write('setType: $setType, ')
          ..write('trackingType: $trackingType, ')
          ..write('weight: $weight, ')
          ..write('reps: $reps, ')
          ..write('rpe: $rpe, ')
          ..write('distance: $distance, ')
          ..write('duration: $duration, ')
          ..write('heartRate: $heartRate, ')
          ..write('isPr: $isPr, ')
          ..write('restSeconds: $restSeconds, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserStatsTable extends UserStats
    with TableInfo<$UserStatsTable, UserStat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserStatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local-user'),
  );
  static const VerificationMeta _currentStreakMeta = const VerificationMeta(
    'currentStreak',
  );
  @override
  late final GeneratedColumn<int> currentStreak = GeneratedColumn<int>(
    'current_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _longestStreakMeta = const VerificationMeta(
    'longestStreak',
  );
  @override
  late final GeneratedColumn<int> longestStreak = GeneratedColumn<int>(
    'longest_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _streakShieldsMeta = const VerificationMeta(
    'streakShields',
  );
  @override
  late final GeneratedColumn<int> streakShields = GeneratedColumn<int>(
    'streak_shields',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _lastWorkoutDateMeta = const VerificationMeta(
    'lastWorkoutDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastWorkoutDate =
      GeneratedColumn<DateTime>(
        'last_workout_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _totalXpMeta = const VerificationMeta(
    'totalXp',
  );
  @override
  late final GeneratedColumn<int> totalXp = GeneratedColumn<int>(
    'total_xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    userId,
    currentStreak,
    longestStreak,
    streakShields,
    lastWorkoutDate,
    totalXp,
    level,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_stats';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserStat> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('current_streak')) {
      context.handle(
        _currentStreakMeta,
        currentStreak.isAcceptableOrUnknown(
          data['current_streak']!,
          _currentStreakMeta,
        ),
      );
    }
    if (data.containsKey('longest_streak')) {
      context.handle(
        _longestStreakMeta,
        longestStreak.isAcceptableOrUnknown(
          data['longest_streak']!,
          _longestStreakMeta,
        ),
      );
    }
    if (data.containsKey('streak_shields')) {
      context.handle(
        _streakShieldsMeta,
        streakShields.isAcceptableOrUnknown(
          data['streak_shields']!,
          _streakShieldsMeta,
        ),
      );
    }
    if (data.containsKey('last_workout_date')) {
      context.handle(
        _lastWorkoutDateMeta,
        lastWorkoutDate.isAcceptableOrUnknown(
          data['last_workout_date']!,
          _lastWorkoutDateMeta,
        ),
      );
    }
    if (data.containsKey('total_xp')) {
      context.handle(
        _totalXpMeta,
        totalXp.isAcceptableOrUnknown(data['total_xp']!, _totalXpMeta),
      );
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  UserStat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserStat(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      currentStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_streak'],
      )!,
      longestStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}longest_streak'],
      )!,
      streakShields: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}streak_shields'],
      )!,
      lastWorkoutDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_workout_date'],
      ),
      totalXp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_xp'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
    );
  }

  @override
  $UserStatsTable createAlias(String alias) {
    return $UserStatsTable(attachedDatabase, alias);
  }
}

class UserStat extends DataClass implements Insertable<UserStat> {
  final String userId;
  final int currentStreak;
  final int longestStreak;
  final int streakShields;
  final DateTime? lastWorkoutDate;
  final int totalXp;
  final int level;
  const UserStat({
    required this.userId,
    required this.currentStreak,
    required this.longestStreak,
    required this.streakShields,
    this.lastWorkoutDate,
    required this.totalXp,
    required this.level,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['current_streak'] = Variable<int>(currentStreak);
    map['longest_streak'] = Variable<int>(longestStreak);
    map['streak_shields'] = Variable<int>(streakShields);
    if (!nullToAbsent || lastWorkoutDate != null) {
      map['last_workout_date'] = Variable<DateTime>(lastWorkoutDate);
    }
    map['total_xp'] = Variable<int>(totalXp);
    map['level'] = Variable<int>(level);
    return map;
  }

  UserStatsCompanion toCompanion(bool nullToAbsent) {
    return UserStatsCompanion(
      userId: Value(userId),
      currentStreak: Value(currentStreak),
      longestStreak: Value(longestStreak),
      streakShields: Value(streakShields),
      lastWorkoutDate: lastWorkoutDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastWorkoutDate),
      totalXp: Value(totalXp),
      level: Value(level),
    );
  }

  factory UserStat.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserStat(
      userId: serializer.fromJson<String>(json['userId']),
      currentStreak: serializer.fromJson<int>(json['currentStreak']),
      longestStreak: serializer.fromJson<int>(json['longestStreak']),
      streakShields: serializer.fromJson<int>(json['streakShields']),
      lastWorkoutDate: serializer.fromJson<DateTime?>(json['lastWorkoutDate']),
      totalXp: serializer.fromJson<int>(json['totalXp']),
      level: serializer.fromJson<int>(json['level']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'currentStreak': serializer.toJson<int>(currentStreak),
      'longestStreak': serializer.toJson<int>(longestStreak),
      'streakShields': serializer.toJson<int>(streakShields),
      'lastWorkoutDate': serializer.toJson<DateTime?>(lastWorkoutDate),
      'totalXp': serializer.toJson<int>(totalXp),
      'level': serializer.toJson<int>(level),
    };
  }

  UserStat copyWith({
    String? userId,
    int? currentStreak,
    int? longestStreak,
    int? streakShields,
    Value<DateTime?> lastWorkoutDate = const Value.absent(),
    int? totalXp,
    int? level,
  }) => UserStat(
    userId: userId ?? this.userId,
    currentStreak: currentStreak ?? this.currentStreak,
    longestStreak: longestStreak ?? this.longestStreak,
    streakShields: streakShields ?? this.streakShields,
    lastWorkoutDate: lastWorkoutDate.present
        ? lastWorkoutDate.value
        : this.lastWorkoutDate,
    totalXp: totalXp ?? this.totalXp,
    level: level ?? this.level,
  );
  UserStat copyWithCompanion(UserStatsCompanion data) {
    return UserStat(
      userId: data.userId.present ? data.userId.value : this.userId,
      currentStreak: data.currentStreak.present
          ? data.currentStreak.value
          : this.currentStreak,
      longestStreak: data.longestStreak.present
          ? data.longestStreak.value
          : this.longestStreak,
      streakShields: data.streakShields.present
          ? data.streakShields.value
          : this.streakShields,
      lastWorkoutDate: data.lastWorkoutDate.present
          ? data.lastWorkoutDate.value
          : this.lastWorkoutDate,
      totalXp: data.totalXp.present ? data.totalXp.value : this.totalXp,
      level: data.level.present ? data.level.value : this.level,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserStat(')
          ..write('userId: $userId, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('streakShields: $streakShields, ')
          ..write('lastWorkoutDate: $lastWorkoutDate, ')
          ..write('totalXp: $totalXp, ')
          ..write('level: $level')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    userId,
    currentStreak,
    longestStreak,
    streakShields,
    lastWorkoutDate,
    totalXp,
    level,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserStat &&
          other.userId == this.userId &&
          other.currentStreak == this.currentStreak &&
          other.longestStreak == this.longestStreak &&
          other.streakShields == this.streakShields &&
          other.lastWorkoutDate == this.lastWorkoutDate &&
          other.totalXp == this.totalXp &&
          other.level == this.level);
}

class UserStatsCompanion extends UpdateCompanion<UserStat> {
  final Value<String> userId;
  final Value<int> currentStreak;
  final Value<int> longestStreak;
  final Value<int> streakShields;
  final Value<DateTime?> lastWorkoutDate;
  final Value<int> totalXp;
  final Value<int> level;
  final Value<int> rowid;
  const UserStatsCompanion({
    this.userId = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.streakShields = const Value.absent(),
    this.lastWorkoutDate = const Value.absent(),
    this.totalXp = const Value.absent(),
    this.level = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserStatsCompanion.insert({
    this.userId = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.streakShields = const Value.absent(),
    this.lastWorkoutDate = const Value.absent(),
    this.totalXp = const Value.absent(),
    this.level = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<UserStat> custom({
    Expression<String>? userId,
    Expression<int>? currentStreak,
    Expression<int>? longestStreak,
    Expression<int>? streakShields,
    Expression<DateTime>? lastWorkoutDate,
    Expression<int>? totalXp,
    Expression<int>? level,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (currentStreak != null) 'current_streak': currentStreak,
      if (longestStreak != null) 'longest_streak': longestStreak,
      if (streakShields != null) 'streak_shields': streakShields,
      if (lastWorkoutDate != null) 'last_workout_date': lastWorkoutDate,
      if (totalXp != null) 'total_xp': totalXp,
      if (level != null) 'level': level,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserStatsCompanion copyWith({
    Value<String>? userId,
    Value<int>? currentStreak,
    Value<int>? longestStreak,
    Value<int>? streakShields,
    Value<DateTime?>? lastWorkoutDate,
    Value<int>? totalXp,
    Value<int>? level,
    Value<int>? rowid,
  }) {
    return UserStatsCompanion(
      userId: userId ?? this.userId,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      streakShields: streakShields ?? this.streakShields,
      lastWorkoutDate: lastWorkoutDate ?? this.lastWorkoutDate,
      totalXp: totalXp ?? this.totalXp,
      level: level ?? this.level,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (currentStreak.present) {
      map['current_streak'] = Variable<int>(currentStreak.value);
    }
    if (longestStreak.present) {
      map['longest_streak'] = Variable<int>(longestStreak.value);
    }
    if (streakShields.present) {
      map['streak_shields'] = Variable<int>(streakShields.value);
    }
    if (lastWorkoutDate.present) {
      map['last_workout_date'] = Variable<DateTime>(lastWorkoutDate.value);
    }
    if (totalXp.present) {
      map['total_xp'] = Variable<int>(totalXp.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserStatsCompanion(')
          ..write('userId: $userId, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('streakShields: $streakShields, ')
          ..write('lastWorkoutDate: $lastWorkoutDate, ')
          ..write('totalXp: $totalXp, ')
          ..write('level: $level, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MuscleExperienceTable extends MuscleExperience
    with TableInfo<$MuscleExperienceTable, MuscleExperienceData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MuscleExperienceTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local-user'),
  );
  static const VerificationMeta _muscleRegionIdMeta = const VerificationMeta(
    'muscleRegionId',
  );
  @override
  late final GeneratedColumn<String> muscleRegionId = GeneratedColumn<String>(
    'muscle_region_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _xpMeta = const VerificationMeta('xp');
  @override
  late final GeneratedColumn<int> xp = GeneratedColumn<int>(
    'xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [userId, muscleRegionId, xp, level];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'muscle_experience';
  @override
  VerificationContext validateIntegrity(
    Insertable<MuscleExperienceData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('muscle_region_id')) {
      context.handle(
        _muscleRegionIdMeta,
        muscleRegionId.isAcceptableOrUnknown(
          data['muscle_region_id']!,
          _muscleRegionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_muscleRegionIdMeta);
    }
    if (data.containsKey('xp')) {
      context.handle(_xpMeta, xp.isAcceptableOrUnknown(data['xp']!, _xpMeta));
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId, muscleRegionId};
  @override
  MuscleExperienceData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MuscleExperienceData(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      muscleRegionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}muscle_region_id'],
      )!,
      xp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
    );
  }

  @override
  $MuscleExperienceTable createAlias(String alias) {
    return $MuscleExperienceTable(attachedDatabase, alias);
  }
}

class MuscleExperienceData extends DataClass
    implements Insertable<MuscleExperienceData> {
  final String userId;
  final String muscleRegionId;
  final int xp;
  final int level;
  const MuscleExperienceData({
    required this.userId,
    required this.muscleRegionId,
    required this.xp,
    required this.level,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['muscle_region_id'] = Variable<String>(muscleRegionId);
    map['xp'] = Variable<int>(xp);
    map['level'] = Variable<int>(level);
    return map;
  }

  MuscleExperienceCompanion toCompanion(bool nullToAbsent) {
    return MuscleExperienceCompanion(
      userId: Value(userId),
      muscleRegionId: Value(muscleRegionId),
      xp: Value(xp),
      level: Value(level),
    );
  }

  factory MuscleExperienceData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MuscleExperienceData(
      userId: serializer.fromJson<String>(json['userId']),
      muscleRegionId: serializer.fromJson<String>(json['muscleRegionId']),
      xp: serializer.fromJson<int>(json['xp']),
      level: serializer.fromJson<int>(json['level']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'muscleRegionId': serializer.toJson<String>(muscleRegionId),
      'xp': serializer.toJson<int>(xp),
      'level': serializer.toJson<int>(level),
    };
  }

  MuscleExperienceData copyWith({
    String? userId,
    String? muscleRegionId,
    int? xp,
    int? level,
  }) => MuscleExperienceData(
    userId: userId ?? this.userId,
    muscleRegionId: muscleRegionId ?? this.muscleRegionId,
    xp: xp ?? this.xp,
    level: level ?? this.level,
  );
  MuscleExperienceData copyWithCompanion(MuscleExperienceCompanion data) {
    return MuscleExperienceData(
      userId: data.userId.present ? data.userId.value : this.userId,
      muscleRegionId: data.muscleRegionId.present
          ? data.muscleRegionId.value
          : this.muscleRegionId,
      xp: data.xp.present ? data.xp.value : this.xp,
      level: data.level.present ? data.level.value : this.level,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MuscleExperienceData(')
          ..write('userId: $userId, ')
          ..write('muscleRegionId: $muscleRegionId, ')
          ..write('xp: $xp, ')
          ..write('level: $level')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userId, muscleRegionId, xp, level);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MuscleExperienceData &&
          other.userId == this.userId &&
          other.muscleRegionId == this.muscleRegionId &&
          other.xp == this.xp &&
          other.level == this.level);
}

class MuscleExperienceCompanion extends UpdateCompanion<MuscleExperienceData> {
  final Value<String> userId;
  final Value<String> muscleRegionId;
  final Value<int> xp;
  final Value<int> level;
  final Value<int> rowid;
  const MuscleExperienceCompanion({
    this.userId = const Value.absent(),
    this.muscleRegionId = const Value.absent(),
    this.xp = const Value.absent(),
    this.level = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MuscleExperienceCompanion.insert({
    this.userId = const Value.absent(),
    required String muscleRegionId,
    this.xp = const Value.absent(),
    this.level = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : muscleRegionId = Value(muscleRegionId);
  static Insertable<MuscleExperienceData> custom({
    Expression<String>? userId,
    Expression<String>? muscleRegionId,
    Expression<int>? xp,
    Expression<int>? level,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (muscleRegionId != null) 'muscle_region_id': muscleRegionId,
      if (xp != null) 'xp': xp,
      if (level != null) 'level': level,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MuscleExperienceCompanion copyWith({
    Value<String>? userId,
    Value<String>? muscleRegionId,
    Value<int>? xp,
    Value<int>? level,
    Value<int>? rowid,
  }) {
    return MuscleExperienceCompanion(
      userId: userId ?? this.userId,
      muscleRegionId: muscleRegionId ?? this.muscleRegionId,
      xp: xp ?? this.xp,
      level: level ?? this.level,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (muscleRegionId.present) {
      map['muscle_region_id'] = Variable<String>(muscleRegionId.value);
    }
    if (xp.present) {
      map['xp'] = Variable<int>(xp.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MuscleExperienceCompanion(')
          ..write('userId: $userId, ')
          ..write('muscleRegionId: $muscleRegionId, ')
          ..write('xp: $xp, ')
          ..write('level: $level, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MigrationStatusTable extends MigrationStatus
    with TableInfo<$MigrationStatusTable, MigrationStatusData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MigrationStatusTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fromUserIdMeta = const VerificationMeta(
    'fromUserId',
  );
  @override
  late final GeneratedColumn<String> fromUserId = GeneratedColumn<String>(
    'from_user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toUserIdMeta = const VerificationMeta(
    'toUserId',
  );
  @override
  late final GeneratedColumn<String> toUserId = GeneratedColumn<String>(
    'to_user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    state,
    fromUserId,
    toUserId,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'migration_status';
  @override
  VerificationContext validateIntegrity(
    Insertable<MigrationStatusData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('from_user_id')) {
      context.handle(
        _fromUserIdMeta,
        fromUserId.isAcceptableOrUnknown(
          data['from_user_id']!,
          _fromUserIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fromUserIdMeta);
    }
    if (data.containsKey('to_user_id')) {
      context.handle(
        _toUserIdMeta,
        toUserId.isAcceptableOrUnknown(data['to_user_id']!, _toUserIdMeta),
      );
    } else if (isInserting) {
      context.missing(_toUserIdMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MigrationStatusData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MigrationStatusData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      )!,
      fromUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from_user_id'],
      )!,
      toUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}to_user_id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MigrationStatusTable createAlias(String alias) {
    return $MigrationStatusTable(attachedDatabase, alias);
  }
}

class MigrationStatusData extends DataClass
    implements Insertable<MigrationStatusData> {
  final String id;
  final String state;
  final String fromUserId;
  final String toUserId;
  final String updatedAt;
  const MigrationStatusData({
    required this.id,
    required this.state,
    required this.fromUserId,
    required this.toUserId,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['state'] = Variable<String>(state);
    map['from_user_id'] = Variable<String>(fromUserId);
    map['to_user_id'] = Variable<String>(toUserId);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  MigrationStatusCompanion toCompanion(bool nullToAbsent) {
    return MigrationStatusCompanion(
      id: Value(id),
      state: Value(state),
      fromUserId: Value(fromUserId),
      toUserId: Value(toUserId),
      updatedAt: Value(updatedAt),
    );
  }

  factory MigrationStatusData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MigrationStatusData(
      id: serializer.fromJson<String>(json['id']),
      state: serializer.fromJson<String>(json['state']),
      fromUserId: serializer.fromJson<String>(json['fromUserId']),
      toUserId: serializer.fromJson<String>(json['toUserId']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'state': serializer.toJson<String>(state),
      'fromUserId': serializer.toJson<String>(fromUserId),
      'toUserId': serializer.toJson<String>(toUserId),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  MigrationStatusData copyWith({
    String? id,
    String? state,
    String? fromUserId,
    String? toUserId,
    String? updatedAt,
  }) => MigrationStatusData(
    id: id ?? this.id,
    state: state ?? this.state,
    fromUserId: fromUserId ?? this.fromUserId,
    toUserId: toUserId ?? this.toUserId,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MigrationStatusData copyWithCompanion(MigrationStatusCompanion data) {
    return MigrationStatusData(
      id: data.id.present ? data.id.value : this.id,
      state: data.state.present ? data.state.value : this.state,
      fromUserId: data.fromUserId.present
          ? data.fromUserId.value
          : this.fromUserId,
      toUserId: data.toUserId.present ? data.toUserId.value : this.toUserId,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MigrationStatusData(')
          ..write('id: $id, ')
          ..write('state: $state, ')
          ..write('fromUserId: $fromUserId, ')
          ..write('toUserId: $toUserId, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, state, fromUserId, toUserId, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MigrationStatusData &&
          other.id == this.id &&
          other.state == this.state &&
          other.fromUserId == this.fromUserId &&
          other.toUserId == this.toUserId &&
          other.updatedAt == this.updatedAt);
}

class MigrationStatusCompanion extends UpdateCompanion<MigrationStatusData> {
  final Value<String> id;
  final Value<String> state;
  final Value<String> fromUserId;
  final Value<String> toUserId;
  final Value<String> updatedAt;
  final Value<int> rowid;
  const MigrationStatusCompanion({
    this.id = const Value.absent(),
    this.state = const Value.absent(),
    this.fromUserId = const Value.absent(),
    this.toUserId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MigrationStatusCompanion.insert({
    required String id,
    required String state,
    required String fromUserId,
    required String toUserId,
    required String updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       state = Value(state),
       fromUserId = Value(fromUserId),
       toUserId = Value(toUserId),
       updatedAt = Value(updatedAt);
  static Insertable<MigrationStatusData> custom({
    Expression<String>? id,
    Expression<String>? state,
    Expression<String>? fromUserId,
    Expression<String>? toUserId,
    Expression<String>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (state != null) 'state': state,
      if (fromUserId != null) 'from_user_id': fromUserId,
      if (toUserId != null) 'to_user_id': toUserId,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MigrationStatusCompanion copyWith({
    Value<String>? id,
    Value<String>? state,
    Value<String>? fromUserId,
    Value<String>? toUserId,
    Value<String>? updatedAt,
    Value<int>? rowid,
  }) {
    return MigrationStatusCompanion(
      id: id ?? this.id,
      state: state ?? this.state,
      fromUserId: fromUserId ?? this.fromUserId,
      toUserId: toUserId ?? this.toUserId,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (fromUserId.present) {
      map['from_user_id'] = Variable<String>(fromUserId.value);
    }
    if (toUserId.present) {
      map['to_user_id'] = Variable<String>(toUserId.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MigrationStatusCompanion(')
          ..write('id: $id, ')
          ..write('state: $state, ')
          ..write('fromUserId: $fromUserId, ')
          ..write('toUserId: $toUserId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserBiometricsTable extends UserBiometrics
    with TableInfo<$UserBiometricsTable, UserBiometricData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserBiometricsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _experienceLevelMeta = const VerificationMeta(
    'experienceLevel',
  );
  @override
  late final GeneratedColumn<String> experienceLevel = GeneratedColumn<String>(
    'experience_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _primaryGoalMeta = const VerificationMeta(
    'primaryGoal',
  );
  @override
  late final GeneratedColumn<String> primaryGoal = GeneratedColumn<String>(
    'primary_goal',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _equipmentAvailabilityMeta =
      const VerificationMeta('equipmentAvailability');
  @override
  late final GeneratedColumn<String> equipmentAvailability =
      GeneratedColumn<String>(
        'equipment_availability',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
    'weight',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
    'height',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
    'age',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    userId,
    experienceLevel,
    primaryGoal,
    equipmentAvailability,
    weight,
    height,
    age,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_biometrics';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserBiometricData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('experience_level')) {
      context.handle(
        _experienceLevelMeta,
        experienceLevel.isAcceptableOrUnknown(
          data['experience_level']!,
          _experienceLevelMeta,
        ),
      );
    }
    if (data.containsKey('primary_goal')) {
      context.handle(
        _primaryGoalMeta,
        primaryGoal.isAcceptableOrUnknown(
          data['primary_goal']!,
          _primaryGoalMeta,
        ),
      );
    }
    if (data.containsKey('equipment_availability')) {
      context.handle(
        _equipmentAvailabilityMeta,
        equipmentAvailability.isAcceptableOrUnknown(
          data['equipment_availability']!,
          _equipmentAvailabilityMeta,
        ),
      );
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    }
    if (data.containsKey('age')) {
      context.handle(
        _ageMeta,
        age.isAcceptableOrUnknown(data['age']!, _ageMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  UserBiometricData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserBiometricData(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      experienceLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}experience_level'],
      ),
      primaryGoal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primary_goal'],
      ),
      equipmentAvailability: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}equipment_availability'],
      ),
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight'],
      ),
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height'],
      ),
      age: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}age'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserBiometricsTable createAlias(String alias) {
    return $UserBiometricsTable(attachedDatabase, alias);
  }
}

class UserBiometricData extends DataClass
    implements Insertable<UserBiometricData> {
  final String userId;
  final String? experienceLevel;
  final String? primaryGoal;
  final String? equipmentAvailability;
  final double? weight;
  final double? height;
  final int? age;
  final String updatedAt;
  const UserBiometricData({
    required this.userId,
    this.experienceLevel,
    this.primaryGoal,
    this.equipmentAvailability,
    this.weight,
    this.height,
    this.age,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || experienceLevel != null) {
      map['experience_level'] = Variable<String>(experienceLevel);
    }
    if (!nullToAbsent || primaryGoal != null) {
      map['primary_goal'] = Variable<String>(primaryGoal);
    }
    if (!nullToAbsent || equipmentAvailability != null) {
      map['equipment_availability'] = Variable<String>(equipmentAvailability);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<double>(height);
    }
    if (!nullToAbsent || age != null) {
      map['age'] = Variable<int>(age);
    }
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  UserBiometricsCompanion toCompanion(bool nullToAbsent) {
    return UserBiometricsCompanion(
      userId: Value(userId),
      experienceLevel: experienceLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(experienceLevel),
      primaryGoal: primaryGoal == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryGoal),
      equipmentAvailability: equipmentAvailability == null && nullToAbsent
          ? const Value.absent()
          : Value(equipmentAvailability),
      weight: weight == null && nullToAbsent
          ? const Value.absent()
          : Value(weight),
      height: height == null && nullToAbsent
          ? const Value.absent()
          : Value(height),
      age: age == null && nullToAbsent ? const Value.absent() : Value(age),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserBiometricData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserBiometricData(
      userId: serializer.fromJson<String>(json['userId']),
      experienceLevel: serializer.fromJson<String?>(json['experienceLevel']),
      primaryGoal: serializer.fromJson<String?>(json['primaryGoal']),
      equipmentAvailability: serializer.fromJson<String?>(
        json['equipmentAvailability'],
      ),
      weight: serializer.fromJson<double?>(json['weight']),
      height: serializer.fromJson<double?>(json['height']),
      age: serializer.fromJson<int?>(json['age']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'experienceLevel': serializer.toJson<String?>(experienceLevel),
      'primaryGoal': serializer.toJson<String?>(primaryGoal),
      'equipmentAvailability': serializer.toJson<String?>(
        equipmentAvailability,
      ),
      'weight': serializer.toJson<double?>(weight),
      'height': serializer.toJson<double?>(height),
      'age': serializer.toJson<int?>(age),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  UserBiometricData copyWith({
    String? userId,
    Value<String?> experienceLevel = const Value.absent(),
    Value<String?> primaryGoal = const Value.absent(),
    Value<String?> equipmentAvailability = const Value.absent(),
    Value<double?> weight = const Value.absent(),
    Value<double?> height = const Value.absent(),
    Value<int?> age = const Value.absent(),
    String? updatedAt,
  }) => UserBiometricData(
    userId: userId ?? this.userId,
    experienceLevel: experienceLevel.present
        ? experienceLevel.value
        : this.experienceLevel,
    primaryGoal: primaryGoal.present ? primaryGoal.value : this.primaryGoal,
    equipmentAvailability: equipmentAvailability.present
        ? equipmentAvailability.value
        : this.equipmentAvailability,
    weight: weight.present ? weight.value : this.weight,
    height: height.present ? height.value : this.height,
    age: age.present ? age.value : this.age,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserBiometricData copyWithCompanion(UserBiometricsCompanion data) {
    return UserBiometricData(
      userId: data.userId.present ? data.userId.value : this.userId,
      experienceLevel: data.experienceLevel.present
          ? data.experienceLevel.value
          : this.experienceLevel,
      primaryGoal: data.primaryGoal.present
          ? data.primaryGoal.value
          : this.primaryGoal,
      equipmentAvailability: data.equipmentAvailability.present
          ? data.equipmentAvailability.value
          : this.equipmentAvailability,
      weight: data.weight.present ? data.weight.value : this.weight,
      height: data.height.present ? data.height.value : this.height,
      age: data.age.present ? data.age.value : this.age,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserBiometricData(')
          ..write('userId: $userId, ')
          ..write('experienceLevel: $experienceLevel, ')
          ..write('primaryGoal: $primaryGoal, ')
          ..write('equipmentAvailability: $equipmentAvailability, ')
          ..write('weight: $weight, ')
          ..write('height: $height, ')
          ..write('age: $age, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    userId,
    experienceLevel,
    primaryGoal,
    equipmentAvailability,
    weight,
    height,
    age,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserBiometricData &&
          other.userId == this.userId &&
          other.experienceLevel == this.experienceLevel &&
          other.primaryGoal == this.primaryGoal &&
          other.equipmentAvailability == this.equipmentAvailability &&
          other.weight == this.weight &&
          other.height == this.height &&
          other.age == this.age &&
          other.updatedAt == this.updatedAt);
}

class UserBiometricsCompanion extends UpdateCompanion<UserBiometricData> {
  final Value<String> userId;
  final Value<String?> experienceLevel;
  final Value<String?> primaryGoal;
  final Value<String?> equipmentAvailability;
  final Value<double?> weight;
  final Value<double?> height;
  final Value<int?> age;
  final Value<String> updatedAt;
  final Value<int> rowid;
  const UserBiometricsCompanion({
    this.userId = const Value.absent(),
    this.experienceLevel = const Value.absent(),
    this.primaryGoal = const Value.absent(),
    this.equipmentAvailability = const Value.absent(),
    this.weight = const Value.absent(),
    this.height = const Value.absent(),
    this.age = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserBiometricsCompanion.insert({
    required String userId,
    this.experienceLevel = const Value.absent(),
    this.primaryGoal = const Value.absent(),
    this.equipmentAvailability = const Value.absent(),
    this.weight = const Value.absent(),
    this.height = const Value.absent(),
    this.age = const Value.absent(),
    required String updatedAt,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       updatedAt = Value(updatedAt);
  static Insertable<UserBiometricData> custom({
    Expression<String>? userId,
    Expression<String>? experienceLevel,
    Expression<String>? primaryGoal,
    Expression<String>? equipmentAvailability,
    Expression<double>? weight,
    Expression<double>? height,
    Expression<int>? age,
    Expression<String>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (experienceLevel != null) 'experience_level': experienceLevel,
      if (primaryGoal != null) 'primary_goal': primaryGoal,
      if (equipmentAvailability != null)
        'equipment_availability': equipmentAvailability,
      if (weight != null) 'weight': weight,
      if (height != null) 'height': height,
      if (age != null) 'age': age,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserBiometricsCompanion copyWith({
    Value<String>? userId,
    Value<String?>? experienceLevel,
    Value<String?>? primaryGoal,
    Value<String?>? equipmentAvailability,
    Value<double?>? weight,
    Value<double?>? height,
    Value<int?>? age,
    Value<String>? updatedAt,
    Value<int>? rowid,
  }) {
    return UserBiometricsCompanion(
      userId: userId ?? this.userId,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      primaryGoal: primaryGoal ?? this.primaryGoal,
      equipmentAvailability:
          equipmentAvailability ?? this.equipmentAvailability,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      age: age ?? this.age,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (experienceLevel.present) {
      map['experience_level'] = Variable<String>(experienceLevel.value);
    }
    if (primaryGoal.present) {
      map['primary_goal'] = Variable<String>(primaryGoal.value);
    }
    if (equipmentAvailability.present) {
      map['equipment_availability'] = Variable<String>(
        equipmentAvailability.value,
      );
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserBiometricsCompanion(')
          ..write('userId: $userId, ')
          ..write('experienceLevel: $experienceLevel, ')
          ..write('primaryGoal: $primaryGoal, ')
          ..write('equipmentAvailability: $equipmentAvailability, ')
          ..write('weight: $weight, ')
          ..write('height: $height, ')
          ..write('age: $age, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HealthSnapshotsTable extends HealthSnapshots
    with TableInfo<$HealthSnapshotsTable, HealthSnapshotRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HealthSnapshotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hrvMsMeta = const VerificationMeta('hrvMs');
  @override
  late final GeneratedColumn<double> hrvMs = GeneratedColumn<double>(
    'hrv_ms',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _restingHrMeta = const VerificationMeta(
    'restingHr',
  );
  @override
  late final GeneratedColumn<int> restingHr = GeneratedColumn<int>(
    'resting_hr',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sleepScoreMeta = const VerificationMeta(
    'sleepScore',
  );
  @override
  late final GeneratedColumn<double> sleepScore = GeneratedColumn<double>(
    'sleep_score',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sleepDurationMinutesMeta =
      const VerificationMeta('sleepDurationMinutes');
  @override
  late final GeneratedColumn<int> sleepDurationMinutes = GeneratedColumn<int>(
    'sleep_duration_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncSourceMeta = const VerificationMeta(
    'syncSource',
  );
  @override
  late final GeneratedColumn<String> syncSource = GeneratedColumn<String>(
    'sync_source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    hrvMs,
    restingHr,
    sleepScore,
    sleepDurationMinutes,
    syncSource,
    syncedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'health_snapshots';
  @override
  VerificationContext validateIntegrity(
    Insertable<HealthSnapshotRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('hrv_ms')) {
      context.handle(
        _hrvMsMeta,
        hrvMs.isAcceptableOrUnknown(data['hrv_ms']!, _hrvMsMeta),
      );
    }
    if (data.containsKey('resting_hr')) {
      context.handle(
        _restingHrMeta,
        restingHr.isAcceptableOrUnknown(data['resting_hr']!, _restingHrMeta),
      );
    }
    if (data.containsKey('sleep_score')) {
      context.handle(
        _sleepScoreMeta,
        sleepScore.isAcceptableOrUnknown(data['sleep_score']!, _sleepScoreMeta),
      );
    }
    if (data.containsKey('sleep_duration_minutes')) {
      context.handle(
        _sleepDurationMinutesMeta,
        sleepDurationMinutes.isAcceptableOrUnknown(
          data['sleep_duration_minutes']!,
          _sleepDurationMinutesMeta,
        ),
      );
    }
    if (data.containsKey('sync_source')) {
      context.handle(
        _syncSourceMeta,
        syncSource.isAcceptableOrUnknown(data['sync_source']!, _syncSourceMeta),
      );
    } else if (isInserting) {
      context.missing(_syncSourceMeta);
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_syncedAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HealthSnapshotRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HealthSnapshotRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      hrvMs: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hrv_ms'],
      ),
      restingHr: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}resting_hr'],
      ),
      sleepScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sleep_score'],
      ),
      sleepDurationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sleep_duration_minutes'],
      ),
      syncSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_source'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $HealthSnapshotsTable createAlias(String alias) {
    return $HealthSnapshotsTable(attachedDatabase, alias);
  }
}

class HealthSnapshotRow extends DataClass
    implements Insertable<HealthSnapshotRow> {
  /// UUID primary key.
  final String id;

  /// The user this snapshot belongs to.
  final String userId;

  /// Heart Rate Variability (SDNN) in milliseconds.
  final double? hrvMs;

  /// Resting Heart Rate in BPM.
  final int? restingHr;

  /// Normalized sleep quality (0.0–1.0).
  final double? sleepScore;

  /// Total sleep duration in minutes.
  final int? sleepDurationMinutes;

  /// Data source: 'apple', 'google', or 'manual'.
  final String syncSource;

  /// When the platform reported this data point.
  final DateTime syncedAt;

  /// Row insertion timestamp.
  final DateTime createdAt;
  const HealthSnapshotRow({
    required this.id,
    required this.userId,
    this.hrvMs,
    this.restingHr,
    this.sleepScore,
    this.sleepDurationMinutes,
    required this.syncSource,
    required this.syncedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || hrvMs != null) {
      map['hrv_ms'] = Variable<double>(hrvMs);
    }
    if (!nullToAbsent || restingHr != null) {
      map['resting_hr'] = Variable<int>(restingHr);
    }
    if (!nullToAbsent || sleepScore != null) {
      map['sleep_score'] = Variable<double>(sleepScore);
    }
    if (!nullToAbsent || sleepDurationMinutes != null) {
      map['sleep_duration_minutes'] = Variable<int>(sleepDurationMinutes);
    }
    map['sync_source'] = Variable<String>(syncSource);
    map['synced_at'] = Variable<DateTime>(syncedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HealthSnapshotsCompanion toCompanion(bool nullToAbsent) {
    return HealthSnapshotsCompanion(
      id: Value(id),
      userId: Value(userId),
      hrvMs: hrvMs == null && nullToAbsent
          ? const Value.absent()
          : Value(hrvMs),
      restingHr: restingHr == null && nullToAbsent
          ? const Value.absent()
          : Value(restingHr),
      sleepScore: sleepScore == null && nullToAbsent
          ? const Value.absent()
          : Value(sleepScore),
      sleepDurationMinutes: sleepDurationMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(sleepDurationMinutes),
      syncSource: Value(syncSource),
      syncedAt: Value(syncedAt),
      createdAt: Value(createdAt),
    );
  }

  factory HealthSnapshotRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HealthSnapshotRow(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      hrvMs: serializer.fromJson<double?>(json['hrvMs']),
      restingHr: serializer.fromJson<int?>(json['restingHr']),
      sleepScore: serializer.fromJson<double?>(json['sleepScore']),
      sleepDurationMinutes: serializer.fromJson<int?>(
        json['sleepDurationMinutes'],
      ),
      syncSource: serializer.fromJson<String>(json['syncSource']),
      syncedAt: serializer.fromJson<DateTime>(json['syncedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'hrvMs': serializer.toJson<double?>(hrvMs),
      'restingHr': serializer.toJson<int?>(restingHr),
      'sleepScore': serializer.toJson<double?>(sleepScore),
      'sleepDurationMinutes': serializer.toJson<int?>(sleepDurationMinutes),
      'syncSource': serializer.toJson<String>(syncSource),
      'syncedAt': serializer.toJson<DateTime>(syncedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  HealthSnapshotRow copyWith({
    String? id,
    String? userId,
    Value<double?> hrvMs = const Value.absent(),
    Value<int?> restingHr = const Value.absent(),
    Value<double?> sleepScore = const Value.absent(),
    Value<int?> sleepDurationMinutes = const Value.absent(),
    String? syncSource,
    DateTime? syncedAt,
    DateTime? createdAt,
  }) => HealthSnapshotRow(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    hrvMs: hrvMs.present ? hrvMs.value : this.hrvMs,
    restingHr: restingHr.present ? restingHr.value : this.restingHr,
    sleepScore: sleepScore.present ? sleepScore.value : this.sleepScore,
    sleepDurationMinutes: sleepDurationMinutes.present
        ? sleepDurationMinutes.value
        : this.sleepDurationMinutes,
    syncSource: syncSource ?? this.syncSource,
    syncedAt: syncedAt ?? this.syncedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  HealthSnapshotRow copyWithCompanion(HealthSnapshotsCompanion data) {
    return HealthSnapshotRow(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      hrvMs: data.hrvMs.present ? data.hrvMs.value : this.hrvMs,
      restingHr: data.restingHr.present ? data.restingHr.value : this.restingHr,
      sleepScore: data.sleepScore.present
          ? data.sleepScore.value
          : this.sleepScore,
      sleepDurationMinutes: data.sleepDurationMinutes.present
          ? data.sleepDurationMinutes.value
          : this.sleepDurationMinutes,
      syncSource: data.syncSource.present
          ? data.syncSource.value
          : this.syncSource,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HealthSnapshotRow(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('hrvMs: $hrvMs, ')
          ..write('restingHr: $restingHr, ')
          ..write('sleepScore: $sleepScore, ')
          ..write('sleepDurationMinutes: $sleepDurationMinutes, ')
          ..write('syncSource: $syncSource, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    hrvMs,
    restingHr,
    sleepScore,
    sleepDurationMinutes,
    syncSource,
    syncedAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HealthSnapshotRow &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.hrvMs == this.hrvMs &&
          other.restingHr == this.restingHr &&
          other.sleepScore == this.sleepScore &&
          other.sleepDurationMinutes == this.sleepDurationMinutes &&
          other.syncSource == this.syncSource &&
          other.syncedAt == this.syncedAt &&
          other.createdAt == this.createdAt);
}

class HealthSnapshotsCompanion extends UpdateCompanion<HealthSnapshotRow> {
  final Value<String> id;
  final Value<String> userId;
  final Value<double?> hrvMs;
  final Value<int?> restingHr;
  final Value<double?> sleepScore;
  final Value<int?> sleepDurationMinutes;
  final Value<String> syncSource;
  final Value<DateTime> syncedAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const HealthSnapshotsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.hrvMs = const Value.absent(),
    this.restingHr = const Value.absent(),
    this.sleepScore = const Value.absent(),
    this.sleepDurationMinutes = const Value.absent(),
    this.syncSource = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HealthSnapshotsCompanion.insert({
    required String id,
    required String userId,
    this.hrvMs = const Value.absent(),
    this.restingHr = const Value.absent(),
    this.sleepScore = const Value.absent(),
    this.sleepDurationMinutes = const Value.absent(),
    required String syncSource,
    required DateTime syncedAt,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       syncSource = Value(syncSource),
       syncedAt = Value(syncedAt);
  static Insertable<HealthSnapshotRow> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<double>? hrvMs,
    Expression<int>? restingHr,
    Expression<double>? sleepScore,
    Expression<int>? sleepDurationMinutes,
    Expression<String>? syncSource,
    Expression<DateTime>? syncedAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (hrvMs != null) 'hrv_ms': hrvMs,
      if (restingHr != null) 'resting_hr': restingHr,
      if (sleepScore != null) 'sleep_score': sleepScore,
      if (sleepDurationMinutes != null)
        'sleep_duration_minutes': sleepDurationMinutes,
      if (syncSource != null) 'sync_source': syncSource,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HealthSnapshotsCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<double?>? hrvMs,
    Value<int?>? restingHr,
    Value<double?>? sleepScore,
    Value<int?>? sleepDurationMinutes,
    Value<String>? syncSource,
    Value<DateTime>? syncedAt,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return HealthSnapshotsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      hrvMs: hrvMs ?? this.hrvMs,
      restingHr: restingHr ?? this.restingHr,
      sleepScore: sleepScore ?? this.sleepScore,
      sleepDurationMinutes: sleepDurationMinutes ?? this.sleepDurationMinutes,
      syncSource: syncSource ?? this.syncSource,
      syncedAt: syncedAt ?? this.syncedAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (hrvMs.present) {
      map['hrv_ms'] = Variable<double>(hrvMs.value);
    }
    if (restingHr.present) {
      map['resting_hr'] = Variable<int>(restingHr.value);
    }
    if (sleepScore.present) {
      map['sleep_score'] = Variable<double>(sleepScore.value);
    }
    if (sleepDurationMinutes.present) {
      map['sleep_duration_minutes'] = Variable<int>(sleepDurationMinutes.value);
    }
    if (syncSource.present) {
      map['sync_source'] = Variable<String>(syncSource.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HealthSnapshotsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('hrvMs: $hrvMs, ')
          ..write('restingHr: $restingHr, ')
          ..write('sleepScore: $sleepScore, ')
          ..write('sleepDurationMinutes: $sleepDurationMinutes, ')
          ..write('syncSource: $syncSource, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MuscleRegionsTable muscleRegions = $MuscleRegionsTable(this);
  late final $EquipmentTable equipment = $EquipmentTable(this);
  late final $ExercisesTable exercises = $ExercisesTable(this);
  late final $ExerciseMusclesTable exerciseMuscles = $ExerciseMusclesTable(
    this,
  );
  late final $ExerciseAliasesTable exerciseAliases = $ExerciseAliasesTable(
    this,
  );
  late final $SubstitutionFeedbackTable substitutionFeedback =
      $SubstitutionFeedbackTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final $UserPreferencesTable userPreferences = $UserPreferencesTable(
    this,
  );
  late final $UserMuscleConstraintsTable userMuscleConstraints =
      $UserMuscleConstraintsTable(this);
  late final $WorkoutsTable workouts = $WorkoutsTable(this);
  late final $WorkoutExercisesTable workoutExercises = $WorkoutExercisesTable(
    this,
  );
  late final $WorkoutSetsTable workoutSets = $WorkoutSetsTable(this);
  late final $UserStatsTable userStats = $UserStatsTable(this);
  late final $MuscleExperienceTable muscleExperience = $MuscleExperienceTable(
    this,
  );
  late final $MigrationStatusTable migrationStatus = $MigrationStatusTable(
    this,
  );
  late final $UserBiometricsTable userBiometrics = $UserBiometricsTable(this);
  late final $HealthSnapshotsTable healthSnapshots = $HealthSnapshotsTable(
    this,
  );
  late final Index idxExerciseMusclesExerciseId = Index(
    'idx_exercise_muscles_exercise_id',
    'CREATE INDEX idx_exercise_muscles_exercise_id ON exercise_muscles (exercise_id)',
  );
  late final Index idxExerciseMusclesMuscleId = Index(
    'idx_exercise_muscles_muscle_id',
    'CREATE INDEX idx_exercise_muscles_muscle_id ON exercise_muscles (muscle_id)',
  );
  late final Index idxWorkoutsUserHistory = Index(
    'idx_workouts_user_history',
    'CREATE INDEX idx_workouts_user_history ON workouts (user_id, status, completed_at)',
  );
  late final Index idxWorkoutsUserId = Index(
    'idx_workouts_user_id',
    'CREATE INDEX idx_workouts_user_id ON workouts (user_id)',
  );
  late final Index idxWorkoutExercisesWorkoutId = Index(
    'idx_workout_exercises_workout_id',
    'CREATE INDEX idx_workout_exercises_workout_id ON workout_exercises (workout_id)',
  );
  late final Index idxWorkoutExercisesExerciseId = Index(
    'idx_workout_exercises_exercise_id',
    'CREATE INDEX idx_workout_exercises_exercise_id ON workout_exercises (exercise_id)',
  );
  late final Index idxWorkoutSetsWorkoutExerciseId = Index(
    'idx_workout_sets_workout_exercise_id',
    'CREATE INDEX idx_workout_sets_workout_exercise_id ON workout_sets (workout_exercise_id)',
  );
  late final Index idxHealthSnapshotsUserSynced = Index(
    'idx_health_snapshots_user_synced',
    'CREATE INDEX idx_health_snapshots_user_synced ON health_snapshots (user_id, synced_at)',
  );
  late final ExerciseDao exerciseDao = ExerciseDao(this as AppDatabase);
  late final CoachingDao coachingDao = CoachingDao(this as AppDatabase);
  late final WorkoutDao workoutDao = WorkoutDao(this as AppDatabase);
  late final GamificationDao gamificationDao = GamificationDao(
    this as AppDatabase,
  );
  late final SubstitutionDao substitutionDao = SubstitutionDao(
    this as AppDatabase,
  );
  late final HealthDao healthDao = HealthDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    muscleRegions,
    equipment,
    exercises,
    exerciseMuscles,
    exerciseAliases,
    substitutionFeedback,
    syncQueue,
    userPreferences,
    userMuscleConstraints,
    workouts,
    workoutExercises,
    workoutSets,
    userStats,
    muscleExperience,
    migrationStatus,
    userBiometrics,
    healthSnapshots,
    idxExerciseMusclesExerciseId,
    idxExerciseMusclesMuscleId,
    idxWorkoutsUserHistory,
    idxWorkoutsUserId,
    idxWorkoutExercisesWorkoutId,
    idxWorkoutExercisesExerciseId,
    idxWorkoutSetsWorkoutExerciseId,
    idxHealthSnapshotsUserSynced,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'workouts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('workout_exercises', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'workout_exercises',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('workout_sets', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$MuscleRegionsTableCreateCompanionBuilder =
    MuscleRegionsCompanion Function({
      required String id,
      required String name,
      required String muscleGroup,
      Value<int> displayOrder,
      Value<int> rowid,
    });
typedef $$MuscleRegionsTableUpdateCompanionBuilder =
    MuscleRegionsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> muscleGroup,
      Value<int> displayOrder,
      Value<int> rowid,
    });

final class $$MuscleRegionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $MuscleRegionsTable, MuscleRegionData> {
  $$MuscleRegionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$ExercisesTable, List<ExerciseData>>
  _exercisesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.exercises,
    aliasName: $_aliasNameGenerator(
      db.muscleRegions.id,
      db.exercises.primaryMuscleId,
    ),
  );

  $$ExercisesTableProcessedTableManager get exercisesRefs {
    final manager = $$ExercisesTableTableManager($_db, $_db.exercises).filter(
      (f) => f.primaryMuscleId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_exercisesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExerciseMusclesTable, List<ExerciseMuscleData>>
  _exerciseMusclesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.exerciseMuscles,
    aliasName: $_aliasNameGenerator(
      db.muscleRegions.id,
      db.exerciseMuscles.muscleId,
    ),
  );

  $$ExerciseMusclesTableProcessedTableManager get exerciseMusclesRefs {
    final manager = $$ExerciseMusclesTableTableManager(
      $_db,
      $_db.exerciseMuscles,
    ).filter((f) => f.muscleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _exerciseMusclesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $UserMuscleConstraintsTable,
    List<UserMuscleConstraintData>
  >
  _userMuscleConstraintsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.userMuscleConstraints,
        aliasName: $_aliasNameGenerator(
          db.muscleRegions.id,
          db.userMuscleConstraints.muscleId,
        ),
      );

  $$UserMuscleConstraintsTableProcessedTableManager
  get userMuscleConstraintsRefs {
    final manager = $$UserMuscleConstraintsTableTableManager(
      $_db,
      $_db.userMuscleConstraints,
    ).filter((f) => f.muscleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _userMuscleConstraintsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MuscleRegionsTableFilterComposer
    extends Composer<_$AppDatabase, $MuscleRegionsTable> {
  $$MuscleRegionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get muscleGroup => $composableBuilder(
    column: $table.muscleGroup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> exercisesRefs(
    Expression<bool> Function($$ExercisesTableFilterComposer f) f,
  ) {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.primaryMuscleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> exerciseMusclesRefs(
    Expression<bool> Function($$ExerciseMusclesTableFilterComposer f) f,
  ) {
    final $$ExerciseMusclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exerciseMuscles,
      getReferencedColumn: (t) => t.muscleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseMusclesTableFilterComposer(
            $db: $db,
            $table: $db.exerciseMuscles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> userMuscleConstraintsRefs(
    Expression<bool> Function($$UserMuscleConstraintsTableFilterComposer f) f,
  ) {
    final $$UserMuscleConstraintsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.userMuscleConstraints,
          getReferencedColumn: (t) => t.muscleId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UserMuscleConstraintsTableFilterComposer(
                $db: $db,
                $table: $db.userMuscleConstraints,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MuscleRegionsTableOrderingComposer
    extends Composer<_$AppDatabase, $MuscleRegionsTable> {
  $$MuscleRegionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get muscleGroup => $composableBuilder(
    column: $table.muscleGroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MuscleRegionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MuscleRegionsTable> {
  $$MuscleRegionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get muscleGroup => $composableBuilder(
    column: $table.muscleGroup,
    builder: (column) => column,
  );

  GeneratedColumn<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => column,
  );

  Expression<T> exercisesRefs<T extends Object>(
    Expression<T> Function($$ExercisesTableAnnotationComposer a) f,
  ) {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.primaryMuscleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> exerciseMusclesRefs<T extends Object>(
    Expression<T> Function($$ExerciseMusclesTableAnnotationComposer a) f,
  ) {
    final $$ExerciseMusclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exerciseMuscles,
      getReferencedColumn: (t) => t.muscleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseMusclesTableAnnotationComposer(
            $db: $db,
            $table: $db.exerciseMuscles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> userMuscleConstraintsRefs<T extends Object>(
    Expression<T> Function($$UserMuscleConstraintsTableAnnotationComposer a) f,
  ) {
    final $$UserMuscleConstraintsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.userMuscleConstraints,
          getReferencedColumn: (t) => t.muscleId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$UserMuscleConstraintsTableAnnotationComposer(
                $db: $db,
                $table: $db.userMuscleConstraints,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MuscleRegionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MuscleRegionsTable,
          MuscleRegionData,
          $$MuscleRegionsTableFilterComposer,
          $$MuscleRegionsTableOrderingComposer,
          $$MuscleRegionsTableAnnotationComposer,
          $$MuscleRegionsTableCreateCompanionBuilder,
          $$MuscleRegionsTableUpdateCompanionBuilder,
          (MuscleRegionData, $$MuscleRegionsTableReferences),
          MuscleRegionData,
          PrefetchHooks Function({
            bool exercisesRefs,
            bool exerciseMusclesRefs,
            bool userMuscleConstraintsRefs,
          })
        > {
  $$MuscleRegionsTableTableManager(_$AppDatabase db, $MuscleRegionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MuscleRegionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MuscleRegionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MuscleRegionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> muscleGroup = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MuscleRegionsCompanion(
                id: id,
                name: name,
                muscleGroup: muscleGroup,
                displayOrder: displayOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String muscleGroup,
                Value<int> displayOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MuscleRegionsCompanion.insert(
                id: id,
                name: name,
                muscleGroup: muscleGroup,
                displayOrder: displayOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MuscleRegionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                exercisesRefs = false,
                exerciseMusclesRefs = false,
                userMuscleConstraintsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (exercisesRefs) db.exercises,
                    if (exerciseMusclesRefs) db.exerciseMuscles,
                    if (userMuscleConstraintsRefs) db.userMuscleConstraints,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (exercisesRefs)
                        await $_getPrefetchedData<
                          MuscleRegionData,
                          $MuscleRegionsTable,
                          ExerciseData
                        >(
                          currentTable: table,
                          referencedTable: $$MuscleRegionsTableReferences
                              ._exercisesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MuscleRegionsTableReferences(
                                db,
                                table,
                                p0,
                              ).exercisesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.primaryMuscleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (exerciseMusclesRefs)
                        await $_getPrefetchedData<
                          MuscleRegionData,
                          $MuscleRegionsTable,
                          ExerciseMuscleData
                        >(
                          currentTable: table,
                          referencedTable: $$MuscleRegionsTableReferences
                              ._exerciseMusclesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MuscleRegionsTableReferences(
                                db,
                                table,
                                p0,
                              ).exerciseMusclesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.muscleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (userMuscleConstraintsRefs)
                        await $_getPrefetchedData<
                          MuscleRegionData,
                          $MuscleRegionsTable,
                          UserMuscleConstraintData
                        >(
                          currentTable: table,
                          referencedTable: $$MuscleRegionsTableReferences
                              ._userMuscleConstraintsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MuscleRegionsTableReferences(
                                db,
                                table,
                                p0,
                              ).userMuscleConstraintsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.muscleId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MuscleRegionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MuscleRegionsTable,
      MuscleRegionData,
      $$MuscleRegionsTableFilterComposer,
      $$MuscleRegionsTableOrderingComposer,
      $$MuscleRegionsTableAnnotationComposer,
      $$MuscleRegionsTableCreateCompanionBuilder,
      $$MuscleRegionsTableUpdateCompanionBuilder,
      (MuscleRegionData, $$MuscleRegionsTableReferences),
      MuscleRegionData,
      PrefetchHooks Function({
        bool exercisesRefs,
        bool exerciseMusclesRefs,
        bool userMuscleConstraintsRefs,
      })
    >;
typedef $$EquipmentTableCreateCompanionBuilder =
    EquipmentCompanion Function({
      required String id,
      required String name,
      Value<String?> icon,
      Value<int> rowid,
    });
typedef $$EquipmentTableUpdateCompanionBuilder =
    EquipmentCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> icon,
      Value<int> rowid,
    });

final class $$EquipmentTableReferences
    extends BaseReferences<_$AppDatabase, $EquipmentTable, EquipmentData> {
  $$EquipmentTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ExercisesTable, List<ExerciseData>>
  _exercisesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.exercises,
    aliasName: $_aliasNameGenerator(db.equipment.id, db.exercises.equipmentId),
  );

  $$ExercisesTableProcessedTableManager get exercisesRefs {
    final manager = $$ExercisesTableTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.equipmentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_exercisesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EquipmentTableFilterComposer
    extends Composer<_$AppDatabase, $EquipmentTable> {
  $$EquipmentTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> exercisesRefs(
    Expression<bool> Function($$ExercisesTableFilterComposer f) f,
  ) {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.equipmentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EquipmentTableOrderingComposer
    extends Composer<_$AppDatabase, $EquipmentTable> {
  $$EquipmentTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EquipmentTableAnnotationComposer
    extends Composer<_$AppDatabase, $EquipmentTable> {
  $$EquipmentTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  Expression<T> exercisesRefs<T extends Object>(
    Expression<T> Function($$ExercisesTableAnnotationComposer a) f,
  ) {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.equipmentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EquipmentTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EquipmentTable,
          EquipmentData,
          $$EquipmentTableFilterComposer,
          $$EquipmentTableOrderingComposer,
          $$EquipmentTableAnnotationComposer,
          $$EquipmentTableCreateCompanionBuilder,
          $$EquipmentTableUpdateCompanionBuilder,
          (EquipmentData, $$EquipmentTableReferences),
          EquipmentData,
          PrefetchHooks Function({bool exercisesRefs})
        > {
  $$EquipmentTableTableManager(_$AppDatabase db, $EquipmentTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EquipmentTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EquipmentTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EquipmentTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EquipmentCompanion(
                id: id,
                name: name,
                icon: icon,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> icon = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EquipmentCompanion.insert(
                id: id,
                name: name,
                icon: icon,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EquipmentTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({exercisesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (exercisesRefs) db.exercises],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (exercisesRefs)
                    await $_getPrefetchedData<
                      EquipmentData,
                      $EquipmentTable,
                      ExerciseData
                    >(
                      currentTable: table,
                      referencedTable: $$EquipmentTableReferences
                          ._exercisesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$EquipmentTableReferences(
                            db,
                            table,
                            p0,
                          ).exercisesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.equipmentId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$EquipmentTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EquipmentTable,
      EquipmentData,
      $$EquipmentTableFilterComposer,
      $$EquipmentTableOrderingComposer,
      $$EquipmentTableAnnotationComposer,
      $$EquipmentTableCreateCompanionBuilder,
      $$EquipmentTableUpdateCompanionBuilder,
      (EquipmentData, $$EquipmentTableReferences),
      EquipmentData,
      PrefetchHooks Function({bool exercisesRefs})
    >;
typedef $$ExercisesTableCreateCompanionBuilder =
    ExercisesCompanion Function({
      required String id,
      required String name,
      required String equipmentId,
      required String primaryMuscleId,
      required MovementPattern movementPattern,
      Value<PlaneOfMotion?> planeOfMotion,
      required ExerciseAngle angle,
      required Laterality laterality,
      required LoadingType loadingType,
      required CnsCost cnsCost,
      required SkillLevel skillLevel,
      required Mechanics mechanics,
      Value<String?> lottieUrl,
      Value<String?> instructions,
      Value<ExerciseTier> tier,
      Value<double> confidence,
      Value<String?> canonicalHash,
      Value<String?> createdBy,
      required String createdAt,
      required String updatedAt,
      Value<int> rowid,
    });
typedef $$ExercisesTableUpdateCompanionBuilder =
    ExercisesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> equipmentId,
      Value<String> primaryMuscleId,
      Value<MovementPattern> movementPattern,
      Value<PlaneOfMotion?> planeOfMotion,
      Value<ExerciseAngle> angle,
      Value<Laterality> laterality,
      Value<LoadingType> loadingType,
      Value<CnsCost> cnsCost,
      Value<SkillLevel> skillLevel,
      Value<Mechanics> mechanics,
      Value<String?> lottieUrl,
      Value<String?> instructions,
      Value<ExerciseTier> tier,
      Value<double> confidence,
      Value<String?> canonicalHash,
      Value<String?> createdBy,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<int> rowid,
    });

final class $$ExercisesTableReferences
    extends BaseReferences<_$AppDatabase, $ExercisesTable, ExerciseData> {
  $$ExercisesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EquipmentTable _equipmentIdTable(_$AppDatabase db) =>
      db.equipment.createAlias(
        $_aliasNameGenerator(db.exercises.equipmentId, db.equipment.id),
      );

  $$EquipmentTableProcessedTableManager get equipmentId {
    final $_column = $_itemColumn<String>('equipment_id')!;

    final manager = $$EquipmentTableTableManager(
      $_db,
      $_db.equipment,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_equipmentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MuscleRegionsTable _primaryMuscleIdTable(_$AppDatabase db) =>
      db.muscleRegions.createAlias(
        $_aliasNameGenerator(db.exercises.primaryMuscleId, db.muscleRegions.id),
      );

  $$MuscleRegionsTableProcessedTableManager get primaryMuscleId {
    final $_column = $_itemColumn<String>('primary_muscle')!;

    final manager = $$MuscleRegionsTableTableManager(
      $_db,
      $_db.muscleRegions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_primaryMuscleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ExerciseMusclesTable, List<ExerciseMuscleData>>
  _exerciseMusclesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.exerciseMuscles,
    aliasName: $_aliasNameGenerator(
      db.exercises.id,
      db.exerciseMuscles.exerciseId,
    ),
  );

  $$ExerciseMusclesTableProcessedTableManager get exerciseMusclesRefs {
    final manager = $$ExerciseMusclesTableTableManager(
      $_db,
      $_db.exerciseMuscles,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _exerciseMusclesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExerciseAliasesTable, List<ExerciseAliasData>>
  _exerciseAliasesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.exerciseAliases,
    aliasName: $_aliasNameGenerator(
      db.exercises.id,
      db.exerciseAliases.exerciseId,
    ),
  );

  $$ExerciseAliasesTableProcessedTableManager get exerciseAliasesRefs {
    final manager = $$ExerciseAliasesTableTableManager(
      $_db,
      $_db.exerciseAliases,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _exerciseAliasesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $SubstitutionFeedbackTable,
    List<SubstitutionFeedbackData>
  >
  _asSourceTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.substitutionFeedback,
    aliasName: $_aliasNameGenerator(
      db.exercises.id,
      db.substitutionFeedback.sourceExerciseId,
    ),
  );

  $$SubstitutionFeedbackTableProcessedTableManager get asSource {
    final manager =
        $$SubstitutionFeedbackTableTableManager(
          $_db,
          $_db.substitutionFeedback,
        ).filter(
          (f) => f.sourceExerciseId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_asSourceTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $SubstitutionFeedbackTable,
    List<SubstitutionFeedbackData>
  >
  _asRejectionTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.substitutionFeedback,
    aliasName: $_aliasNameGenerator(
      db.exercises.id,
      db.substitutionFeedback.rejectedExerciseId,
    ),
  );

  $$SubstitutionFeedbackTableProcessedTableManager get asRejection {
    final manager =
        $$SubstitutionFeedbackTableTableManager(
          $_db,
          $_db.substitutionFeedback,
        ).filter(
          (f) => f.rejectedExerciseId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_asRejectionTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$UserPreferencesTable, List<UserPreferenceData>>
  _userPreferencesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userPreferences,
    aliasName: $_aliasNameGenerator(
      db.exercises.id,
      db.userPreferences.exerciseId,
    ),
  );

  $$UserPreferencesTableProcessedTableManager get userPreferencesRefs {
    final manager = $$UserPreferencesTableTableManager(
      $_db,
      $_db.userPreferences,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _userPreferencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WorkoutExercisesTable, List<WorkoutExercise>>
  _workoutExercisesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.workoutExercises,
    aliasName: $_aliasNameGenerator(
      db.exercises.id,
      db.workoutExercises.exerciseId,
    ),
  );

  $$WorkoutExercisesTableProcessedTableManager get workoutExercisesRefs {
    final manager = $$WorkoutExercisesTableTableManager(
      $_db,
      $_db.workoutExercises,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _workoutExercisesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MovementPattern, MovementPattern, String>
  get movementPattern => $composableBuilder(
    column: $table.movementPattern,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<PlaneOfMotion?, PlaneOfMotion, String>
  get planeOfMotion => $composableBuilder(
    column: $table.planeOfMotion,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<ExerciseAngle, ExerciseAngle, String>
  get angle => $composableBuilder(
    column: $table.angle,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<Laterality, Laterality, String>
  get laterality => $composableBuilder(
    column: $table.laterality,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<LoadingType, LoadingType, String>
  get loadingType => $composableBuilder(
    column: $table.loadingType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<CnsCost, CnsCost, String> get cnsCost =>
      $composableBuilder(
        column: $table.cnsCost,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<SkillLevel, SkillLevel, String>
  get skillLevel => $composableBuilder(
    column: $table.skillLevel,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<Mechanics, Mechanics, String> get mechanics =>
      $composableBuilder(
        column: $table.mechanics,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get lottieUrl => $composableBuilder(
    column: $table.lottieUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ExerciseTier, ExerciseTier, int> get tier =>
      $composableBuilder(
        column: $table.tier,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get canonicalHash => $composableBuilder(
    column: $table.canonicalHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$EquipmentTableFilterComposer get equipmentId {
    final $$EquipmentTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.equipmentId,
      referencedTable: $db.equipment,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EquipmentTableFilterComposer(
            $db: $db,
            $table: $db.equipment,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MuscleRegionsTableFilterComposer get primaryMuscleId {
    final $$MuscleRegionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.primaryMuscleId,
      referencedTable: $db.muscleRegions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MuscleRegionsTableFilterComposer(
            $db: $db,
            $table: $db.muscleRegions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> exerciseMusclesRefs(
    Expression<bool> Function($$ExerciseMusclesTableFilterComposer f) f,
  ) {
    final $$ExerciseMusclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exerciseMuscles,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseMusclesTableFilterComposer(
            $db: $db,
            $table: $db.exerciseMuscles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> exerciseAliasesRefs(
    Expression<bool> Function($$ExerciseAliasesTableFilterComposer f) f,
  ) {
    final $$ExerciseAliasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exerciseAliases,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseAliasesTableFilterComposer(
            $db: $db,
            $table: $db.exerciseAliases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> asSource(
    Expression<bool> Function($$SubstitutionFeedbackTableFilterComposer f) f,
  ) {
    final $$SubstitutionFeedbackTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.substitutionFeedback,
      getReferencedColumn: (t) => t.sourceExerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubstitutionFeedbackTableFilterComposer(
            $db: $db,
            $table: $db.substitutionFeedback,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> asRejection(
    Expression<bool> Function($$SubstitutionFeedbackTableFilterComposer f) f,
  ) {
    final $$SubstitutionFeedbackTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.substitutionFeedback,
      getReferencedColumn: (t) => t.rejectedExerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubstitutionFeedbackTableFilterComposer(
            $db: $db,
            $table: $db.substitutionFeedback,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> userPreferencesRefs(
    Expression<bool> Function($$UserPreferencesTableFilterComposer f) f,
  ) {
    final $$UserPreferencesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userPreferences,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserPreferencesTableFilterComposer(
            $db: $db,
            $table: $db.userPreferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> workoutExercisesRefs(
    Expression<bool> Function($$WorkoutExercisesTableFilterComposer f) f,
  ) {
    final $$WorkoutExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutExercises,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutExercisesTableFilterComposer(
            $db: $db,
            $table: $db.workoutExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get movementPattern => $composableBuilder(
    column: $table.movementPattern,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get planeOfMotion => $composableBuilder(
    column: $table.planeOfMotion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get angle => $composableBuilder(
    column: $table.angle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get laterality => $composableBuilder(
    column: $table.laterality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get loadingType => $composableBuilder(
    column: $table.loadingType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cnsCost => $composableBuilder(
    column: $table.cnsCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get skillLevel => $composableBuilder(
    column: $table.skillLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mechanics => $composableBuilder(
    column: $table.mechanics,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lottieUrl => $composableBuilder(
    column: $table.lottieUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get canonicalHash => $composableBuilder(
    column: $table.canonicalHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$EquipmentTableOrderingComposer get equipmentId {
    final $$EquipmentTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.equipmentId,
      referencedTable: $db.equipment,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EquipmentTableOrderingComposer(
            $db: $db,
            $table: $db.equipment,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MuscleRegionsTableOrderingComposer get primaryMuscleId {
    final $$MuscleRegionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.primaryMuscleId,
      referencedTable: $db.muscleRegions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MuscleRegionsTableOrderingComposer(
            $db: $db,
            $table: $db.muscleRegions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MovementPattern, String>
  get movementPattern => $composableBuilder(
    column: $table.movementPattern,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<PlaneOfMotion?, String> get planeOfMotion =>
      $composableBuilder(
        column: $table.planeOfMotion,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<ExerciseAngle, String> get angle =>
      $composableBuilder(column: $table.angle, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Laterality, String> get laterality =>
      $composableBuilder(
        column: $table.laterality,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<LoadingType, String> get loadingType =>
      $composableBuilder(
        column: $table.loadingType,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<CnsCost, String> get cnsCost =>
      $composableBuilder(column: $table.cnsCost, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SkillLevel, String> get skillLevel =>
      $composableBuilder(
        column: $table.skillLevel,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<Mechanics, String> get mechanics =>
      $composableBuilder(column: $table.mechanics, builder: (column) => column);

  GeneratedColumn<String> get lottieUrl =>
      $composableBuilder(column: $table.lottieUrl, builder: (column) => column);

  GeneratedColumn<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<ExerciseTier, int> get tier =>
      $composableBuilder(column: $table.tier, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get canonicalHash => $composableBuilder(
    column: $table.canonicalHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$EquipmentTableAnnotationComposer get equipmentId {
    final $$EquipmentTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.equipmentId,
      referencedTable: $db.equipment,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EquipmentTableAnnotationComposer(
            $db: $db,
            $table: $db.equipment,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MuscleRegionsTableAnnotationComposer get primaryMuscleId {
    final $$MuscleRegionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.primaryMuscleId,
      referencedTable: $db.muscleRegions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MuscleRegionsTableAnnotationComposer(
            $db: $db,
            $table: $db.muscleRegions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> exerciseMusclesRefs<T extends Object>(
    Expression<T> Function($$ExerciseMusclesTableAnnotationComposer a) f,
  ) {
    final $$ExerciseMusclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exerciseMuscles,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseMusclesTableAnnotationComposer(
            $db: $db,
            $table: $db.exerciseMuscles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> exerciseAliasesRefs<T extends Object>(
    Expression<T> Function($$ExerciseAliasesTableAnnotationComposer a) f,
  ) {
    final $$ExerciseAliasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exerciseAliases,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseAliasesTableAnnotationComposer(
            $db: $db,
            $table: $db.exerciseAliases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> asSource<T extends Object>(
    Expression<T> Function($$SubstitutionFeedbackTableAnnotationComposer a) f,
  ) {
    final $$SubstitutionFeedbackTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.substitutionFeedback,
          getReferencedColumn: (t) => t.sourceExerciseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SubstitutionFeedbackTableAnnotationComposer(
                $db: $db,
                $table: $db.substitutionFeedback,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> asRejection<T extends Object>(
    Expression<T> Function($$SubstitutionFeedbackTableAnnotationComposer a) f,
  ) {
    final $$SubstitutionFeedbackTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.substitutionFeedback,
          getReferencedColumn: (t) => t.rejectedExerciseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SubstitutionFeedbackTableAnnotationComposer(
                $db: $db,
                $table: $db.substitutionFeedback,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> userPreferencesRefs<T extends Object>(
    Expression<T> Function($$UserPreferencesTableAnnotationComposer a) f,
  ) {
    final $$UserPreferencesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userPreferences,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserPreferencesTableAnnotationComposer(
            $db: $db,
            $table: $db.userPreferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> workoutExercisesRefs<T extends Object>(
    Expression<T> Function($$WorkoutExercisesTableAnnotationComposer a) f,
  ) {
    final $$WorkoutExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutExercises,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.workoutExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExercisesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExercisesTable,
          ExerciseData,
          $$ExercisesTableFilterComposer,
          $$ExercisesTableOrderingComposer,
          $$ExercisesTableAnnotationComposer,
          $$ExercisesTableCreateCompanionBuilder,
          $$ExercisesTableUpdateCompanionBuilder,
          (ExerciseData, $$ExercisesTableReferences),
          ExerciseData,
          PrefetchHooks Function({
            bool equipmentId,
            bool primaryMuscleId,
            bool exerciseMusclesRefs,
            bool exerciseAliasesRefs,
            bool asSource,
            bool asRejection,
            bool userPreferencesRefs,
            bool workoutExercisesRefs,
          })
        > {
  $$ExercisesTableTableManager(_$AppDatabase db, $ExercisesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> equipmentId = const Value.absent(),
                Value<String> primaryMuscleId = const Value.absent(),
                Value<MovementPattern> movementPattern = const Value.absent(),
                Value<PlaneOfMotion?> planeOfMotion = const Value.absent(),
                Value<ExerciseAngle> angle = const Value.absent(),
                Value<Laterality> laterality = const Value.absent(),
                Value<LoadingType> loadingType = const Value.absent(),
                Value<CnsCost> cnsCost = const Value.absent(),
                Value<SkillLevel> skillLevel = const Value.absent(),
                Value<Mechanics> mechanics = const Value.absent(),
                Value<String?> lottieUrl = const Value.absent(),
                Value<String?> instructions = const Value.absent(),
                Value<ExerciseTier> tier = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<String?> canonicalHash = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExercisesCompanion(
                id: id,
                name: name,
                equipmentId: equipmentId,
                primaryMuscleId: primaryMuscleId,
                movementPattern: movementPattern,
                planeOfMotion: planeOfMotion,
                angle: angle,
                laterality: laterality,
                loadingType: loadingType,
                cnsCost: cnsCost,
                skillLevel: skillLevel,
                mechanics: mechanics,
                lottieUrl: lottieUrl,
                instructions: instructions,
                tier: tier,
                confidence: confidence,
                canonicalHash: canonicalHash,
                createdBy: createdBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String equipmentId,
                required String primaryMuscleId,
                required MovementPattern movementPattern,
                Value<PlaneOfMotion?> planeOfMotion = const Value.absent(),
                required ExerciseAngle angle,
                required Laterality laterality,
                required LoadingType loadingType,
                required CnsCost cnsCost,
                required SkillLevel skillLevel,
                required Mechanics mechanics,
                Value<String?> lottieUrl = const Value.absent(),
                Value<String?> instructions = const Value.absent(),
                Value<ExerciseTier> tier = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<String?> canonicalHash = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                required String createdAt,
                required String updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ExercisesCompanion.insert(
                id: id,
                name: name,
                equipmentId: equipmentId,
                primaryMuscleId: primaryMuscleId,
                movementPattern: movementPattern,
                planeOfMotion: planeOfMotion,
                angle: angle,
                laterality: laterality,
                loadingType: loadingType,
                cnsCost: cnsCost,
                skillLevel: skillLevel,
                mechanics: mechanics,
                lottieUrl: lottieUrl,
                instructions: instructions,
                tier: tier,
                confidence: confidence,
                canonicalHash: canonicalHash,
                createdBy: createdBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExercisesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                equipmentId = false,
                primaryMuscleId = false,
                exerciseMusclesRefs = false,
                exerciseAliasesRefs = false,
                asSource = false,
                asRejection = false,
                userPreferencesRefs = false,
                workoutExercisesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (exerciseMusclesRefs) db.exerciseMuscles,
                    if (exerciseAliasesRefs) db.exerciseAliases,
                    if (asSource) db.substitutionFeedback,
                    if (asRejection) db.substitutionFeedback,
                    if (userPreferencesRefs) db.userPreferences,
                    if (workoutExercisesRefs) db.workoutExercises,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (equipmentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.equipmentId,
                                    referencedTable: $$ExercisesTableReferences
                                        ._equipmentIdTable(db),
                                    referencedColumn: $$ExercisesTableReferences
                                        ._equipmentIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (primaryMuscleId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.primaryMuscleId,
                                    referencedTable: $$ExercisesTableReferences
                                        ._primaryMuscleIdTable(db),
                                    referencedColumn: $$ExercisesTableReferences
                                        ._primaryMuscleIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (exerciseMusclesRefs)
                        await $_getPrefetchedData<
                          ExerciseData,
                          $ExercisesTable,
                          ExerciseMuscleData
                        >(
                          currentTable: table,
                          referencedTable: $$ExercisesTableReferences
                              ._exerciseMusclesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExercisesTableReferences(
                                db,
                                table,
                                p0,
                              ).exerciseMusclesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (exerciseAliasesRefs)
                        await $_getPrefetchedData<
                          ExerciseData,
                          $ExercisesTable,
                          ExerciseAliasData
                        >(
                          currentTable: table,
                          referencedTable: $$ExercisesTableReferences
                              ._exerciseAliasesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExercisesTableReferences(
                                db,
                                table,
                                p0,
                              ).exerciseAliasesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (asSource)
                        await $_getPrefetchedData<
                          ExerciseData,
                          $ExercisesTable,
                          SubstitutionFeedbackData
                        >(
                          currentTable: table,
                          referencedTable: $$ExercisesTableReferences
                              ._asSourceTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExercisesTableReferences(
                                db,
                                table,
                                p0,
                              ).asSource,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sourceExerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (asRejection)
                        await $_getPrefetchedData<
                          ExerciseData,
                          $ExercisesTable,
                          SubstitutionFeedbackData
                        >(
                          currentTable: table,
                          referencedTable: $$ExercisesTableReferences
                              ._asRejectionTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExercisesTableReferences(
                                db,
                                table,
                                p0,
                              ).asRejection,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.rejectedExerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (userPreferencesRefs)
                        await $_getPrefetchedData<
                          ExerciseData,
                          $ExercisesTable,
                          UserPreferenceData
                        >(
                          currentTable: table,
                          referencedTable: $$ExercisesTableReferences
                              ._userPreferencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExercisesTableReferences(
                                db,
                                table,
                                p0,
                              ).userPreferencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (workoutExercisesRefs)
                        await $_getPrefetchedData<
                          ExerciseData,
                          $ExercisesTable,
                          WorkoutExercise
                        >(
                          currentTable: table,
                          referencedTable: $$ExercisesTableReferences
                              ._workoutExercisesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExercisesTableReferences(
                                db,
                                table,
                                p0,
                              ).workoutExercisesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ExercisesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExercisesTable,
      ExerciseData,
      $$ExercisesTableFilterComposer,
      $$ExercisesTableOrderingComposer,
      $$ExercisesTableAnnotationComposer,
      $$ExercisesTableCreateCompanionBuilder,
      $$ExercisesTableUpdateCompanionBuilder,
      (ExerciseData, $$ExercisesTableReferences),
      ExerciseData,
      PrefetchHooks Function({
        bool equipmentId,
        bool primaryMuscleId,
        bool exerciseMusclesRefs,
        bool exerciseAliasesRefs,
        bool asSource,
        bool asRejection,
        bool userPreferencesRefs,
        bool workoutExercisesRefs,
      })
    >;
typedef $$ExerciseMusclesTableCreateCompanionBuilder =
    ExerciseMusclesCompanion Function({
      required String exerciseId,
      required String muscleId,
      required MuscleRole role,
      Value<int> rowid,
    });
typedef $$ExerciseMusclesTableUpdateCompanionBuilder =
    ExerciseMusclesCompanion Function({
      Value<String> exerciseId,
      Value<String> muscleId,
      Value<MuscleRole> role,
      Value<int> rowid,
    });

final class $$ExerciseMusclesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ExerciseMusclesTable,
          ExerciseMuscleData
        > {
  $$ExerciseMusclesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
        $_aliasNameGenerator(db.exerciseMuscles.exerciseId, db.exercises.id),
      );

  $$ExercisesTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<String>('exercise_id')!;

    final manager = $$ExercisesTableTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MuscleRegionsTable _muscleIdTable(_$AppDatabase db) =>
      db.muscleRegions.createAlias(
        $_aliasNameGenerator(db.exerciseMuscles.muscleId, db.muscleRegions.id),
      );

  $$MuscleRegionsTableProcessedTableManager get muscleId {
    final $_column = $_itemColumn<String>('muscle_id')!;

    final manager = $$MuscleRegionsTableTableManager(
      $_db,
      $_db.muscleRegions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_muscleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExerciseMusclesTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseMusclesTable> {
  $$ExerciseMusclesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnWithTypeConverterFilters<MuscleRole, MuscleRole, String> get role =>
      $composableBuilder(
        column: $table.role,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  $$ExercisesTableFilterComposer get exerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MuscleRegionsTableFilterComposer get muscleId {
    final $$MuscleRegionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.muscleId,
      referencedTable: $db.muscleRegions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MuscleRegionsTableFilterComposer(
            $db: $db,
            $table: $db.muscleRegions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseMusclesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseMusclesTable> {
  $$ExerciseMusclesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExercisesTableOrderingComposer get exerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MuscleRegionsTableOrderingComposer get muscleId {
    final $$MuscleRegionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.muscleId,
      referencedTable: $db.muscleRegions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MuscleRegionsTableOrderingComposer(
            $db: $db,
            $table: $db.muscleRegions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseMusclesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseMusclesTable> {
  $$ExerciseMusclesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumnWithTypeConverter<MuscleRole, String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  $$ExercisesTableAnnotationComposer get exerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MuscleRegionsTableAnnotationComposer get muscleId {
    final $$MuscleRegionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.muscleId,
      referencedTable: $db.muscleRegions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MuscleRegionsTableAnnotationComposer(
            $db: $db,
            $table: $db.muscleRegions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseMusclesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExerciseMusclesTable,
          ExerciseMuscleData,
          $$ExerciseMusclesTableFilterComposer,
          $$ExerciseMusclesTableOrderingComposer,
          $$ExerciseMusclesTableAnnotationComposer,
          $$ExerciseMusclesTableCreateCompanionBuilder,
          $$ExerciseMusclesTableUpdateCompanionBuilder,
          (ExerciseMuscleData, $$ExerciseMusclesTableReferences),
          ExerciseMuscleData,
          PrefetchHooks Function({bool exerciseId, bool muscleId})
        > {
  $$ExerciseMusclesTableTableManager(
    _$AppDatabase db,
    $ExerciseMusclesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseMusclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseMusclesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseMusclesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> exerciseId = const Value.absent(),
                Value<String> muscleId = const Value.absent(),
                Value<MuscleRole> role = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExerciseMusclesCompanion(
                exerciseId: exerciseId,
                muscleId: muscleId,
                role: role,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String exerciseId,
                required String muscleId,
                required MuscleRole role,
                Value<int> rowid = const Value.absent(),
              }) => ExerciseMusclesCompanion.insert(
                exerciseId: exerciseId,
                muscleId: muscleId,
                role: role,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExerciseMusclesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({exerciseId = false, muscleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (exerciseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.exerciseId,
                                referencedTable:
                                    $$ExerciseMusclesTableReferences
                                        ._exerciseIdTable(db),
                                referencedColumn:
                                    $$ExerciseMusclesTableReferences
                                        ._exerciseIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (muscleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.muscleId,
                                referencedTable:
                                    $$ExerciseMusclesTableReferences
                                        ._muscleIdTable(db),
                                referencedColumn:
                                    $$ExerciseMusclesTableReferences
                                        ._muscleIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExerciseMusclesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExerciseMusclesTable,
      ExerciseMuscleData,
      $$ExerciseMusclesTableFilterComposer,
      $$ExerciseMusclesTableOrderingComposer,
      $$ExerciseMusclesTableAnnotationComposer,
      $$ExerciseMusclesTableCreateCompanionBuilder,
      $$ExerciseMusclesTableUpdateCompanionBuilder,
      (ExerciseMuscleData, $$ExerciseMusclesTableReferences),
      ExerciseMuscleData,
      PrefetchHooks Function({bool exerciseId, bool muscleId})
    >;
typedef $$ExerciseAliasesTableCreateCompanionBuilder =
    ExerciseAliasesCompanion Function({
      required String id,
      required String exerciseId,
      required String aliasName,
      Value<bool> isPrimary,
      Value<int> rowid,
    });
typedef $$ExerciseAliasesTableUpdateCompanionBuilder =
    ExerciseAliasesCompanion Function({
      Value<String> id,
      Value<String> exerciseId,
      Value<String> aliasName,
      Value<bool> isPrimary,
      Value<int> rowid,
    });

final class $$ExerciseAliasesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ExerciseAliasesTable,
          ExerciseAliasData
        > {
  $$ExerciseAliasesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
        $_aliasNameGenerator(db.exerciseAliases.exerciseId, db.exercises.id),
      );

  $$ExercisesTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<String>('exercise_id')!;

    final manager = $$ExercisesTableTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExerciseAliasesTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseAliasesTable> {
  $$ExerciseAliasesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aliasName => $composableBuilder(
    column: $table.aliasName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPrimary => $composableBuilder(
    column: $table.isPrimary,
    builder: (column) => ColumnFilters(column),
  );

  $$ExercisesTableFilterComposer get exerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseAliasesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseAliasesTable> {
  $$ExerciseAliasesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aliasName => $composableBuilder(
    column: $table.aliasName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPrimary => $composableBuilder(
    column: $table.isPrimary,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExercisesTableOrderingComposer get exerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseAliasesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseAliasesTable> {
  $$ExerciseAliasesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get aliasName =>
      $composableBuilder(column: $table.aliasName, builder: (column) => column);

  GeneratedColumn<bool> get isPrimary =>
      $composableBuilder(column: $table.isPrimary, builder: (column) => column);

  $$ExercisesTableAnnotationComposer get exerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseAliasesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExerciseAliasesTable,
          ExerciseAliasData,
          $$ExerciseAliasesTableFilterComposer,
          $$ExerciseAliasesTableOrderingComposer,
          $$ExerciseAliasesTableAnnotationComposer,
          $$ExerciseAliasesTableCreateCompanionBuilder,
          $$ExerciseAliasesTableUpdateCompanionBuilder,
          (ExerciseAliasData, $$ExerciseAliasesTableReferences),
          ExerciseAliasData,
          PrefetchHooks Function({bool exerciseId})
        > {
  $$ExerciseAliasesTableTableManager(
    _$AppDatabase db,
    $ExerciseAliasesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseAliasesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseAliasesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseAliasesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<String> aliasName = const Value.absent(),
                Value<bool> isPrimary = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExerciseAliasesCompanion(
                id: id,
                exerciseId: exerciseId,
                aliasName: aliasName,
                isPrimary: isPrimary,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String exerciseId,
                required String aliasName,
                Value<bool> isPrimary = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExerciseAliasesCompanion.insert(
                id: id,
                exerciseId: exerciseId,
                aliasName: aliasName,
                isPrimary: isPrimary,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExerciseAliasesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({exerciseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (exerciseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.exerciseId,
                                referencedTable:
                                    $$ExerciseAliasesTableReferences
                                        ._exerciseIdTable(db),
                                referencedColumn:
                                    $$ExerciseAliasesTableReferences
                                        ._exerciseIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExerciseAliasesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExerciseAliasesTable,
      ExerciseAliasData,
      $$ExerciseAliasesTableFilterComposer,
      $$ExerciseAliasesTableOrderingComposer,
      $$ExerciseAliasesTableAnnotationComposer,
      $$ExerciseAliasesTableCreateCompanionBuilder,
      $$ExerciseAliasesTableUpdateCompanionBuilder,
      (ExerciseAliasData, $$ExerciseAliasesTableReferences),
      ExerciseAliasData,
      PrefetchHooks Function({bool exerciseId})
    >;
typedef $$SubstitutionFeedbackTableCreateCompanionBuilder =
    SubstitutionFeedbackCompanion Function({
      required String id,
      required String userId,
      required String sourceExerciseId,
      required String rejectedExerciseId,
      required String createdAt,
      Value<int> rowid,
    });
typedef $$SubstitutionFeedbackTableUpdateCompanionBuilder =
    SubstitutionFeedbackCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> sourceExerciseId,
      Value<String> rejectedExerciseId,
      Value<String> createdAt,
      Value<int> rowid,
    });

final class $$SubstitutionFeedbackTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SubstitutionFeedbackTable,
          SubstitutionFeedbackData
        > {
  $$SubstitutionFeedbackTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ExercisesTable _sourceExerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
        $_aliasNameGenerator(
          db.substitutionFeedback.sourceExerciseId,
          db.exercises.id,
        ),
      );

  $$ExercisesTableProcessedTableManager get sourceExerciseId {
    final $_column = $_itemColumn<String>('source_exercise_id')!;

    final manager = $$ExercisesTableTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sourceExerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ExercisesTable _rejectedExerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
        $_aliasNameGenerator(
          db.substitutionFeedback.rejectedExerciseId,
          db.exercises.id,
        ),
      );

  $$ExercisesTableProcessedTableManager get rejectedExerciseId {
    final $_column = $_itemColumn<String>('rejected_exercise_id')!;

    final manager = $$ExercisesTableTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_rejectedExerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SubstitutionFeedbackTableFilterComposer
    extends Composer<_$AppDatabase, $SubstitutionFeedbackTable> {
  $$SubstitutionFeedbackTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ExercisesTableFilterComposer get sourceExerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceExerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExercisesTableFilterComposer get rejectedExerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rejectedExerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubstitutionFeedbackTableOrderingComposer
    extends Composer<_$AppDatabase, $SubstitutionFeedbackTable> {
  $$SubstitutionFeedbackTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExercisesTableOrderingComposer get sourceExerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceExerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExercisesTableOrderingComposer get rejectedExerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rejectedExerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubstitutionFeedbackTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubstitutionFeedbackTable> {
  $$SubstitutionFeedbackTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ExercisesTableAnnotationComposer get sourceExerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceExerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExercisesTableAnnotationComposer get rejectedExerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rejectedExerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubstitutionFeedbackTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubstitutionFeedbackTable,
          SubstitutionFeedbackData,
          $$SubstitutionFeedbackTableFilterComposer,
          $$SubstitutionFeedbackTableOrderingComposer,
          $$SubstitutionFeedbackTableAnnotationComposer,
          $$SubstitutionFeedbackTableCreateCompanionBuilder,
          $$SubstitutionFeedbackTableUpdateCompanionBuilder,
          (SubstitutionFeedbackData, $$SubstitutionFeedbackTableReferences),
          SubstitutionFeedbackData,
          PrefetchHooks Function({
            bool sourceExerciseId,
            bool rejectedExerciseId,
          })
        > {
  $$SubstitutionFeedbackTableTableManager(
    _$AppDatabase db,
    $SubstitutionFeedbackTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubstitutionFeedbackTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubstitutionFeedbackTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SubstitutionFeedbackTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> sourceExerciseId = const Value.absent(),
                Value<String> rejectedExerciseId = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SubstitutionFeedbackCompanion(
                id: id,
                userId: userId,
                sourceExerciseId: sourceExerciseId,
                rejectedExerciseId: rejectedExerciseId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String sourceExerciseId,
                required String rejectedExerciseId,
                required String createdAt,
                Value<int> rowid = const Value.absent(),
              }) => SubstitutionFeedbackCompanion.insert(
                id: id,
                userId: userId,
                sourceExerciseId: sourceExerciseId,
                rejectedExerciseId: rejectedExerciseId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SubstitutionFeedbackTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({sourceExerciseId = false, rejectedExerciseId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (sourceExerciseId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sourceExerciseId,
                                    referencedTable:
                                        $$SubstitutionFeedbackTableReferences
                                            ._sourceExerciseIdTable(db),
                                    referencedColumn:
                                        $$SubstitutionFeedbackTableReferences
                                            ._sourceExerciseIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (rejectedExerciseId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.rejectedExerciseId,
                                    referencedTable:
                                        $$SubstitutionFeedbackTableReferences
                                            ._rejectedExerciseIdTable(db),
                                    referencedColumn:
                                        $$SubstitutionFeedbackTableReferences
                                            ._rejectedExerciseIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$SubstitutionFeedbackTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubstitutionFeedbackTable,
      SubstitutionFeedbackData,
      $$SubstitutionFeedbackTableFilterComposer,
      $$SubstitutionFeedbackTableOrderingComposer,
      $$SubstitutionFeedbackTableAnnotationComposer,
      $$SubstitutionFeedbackTableCreateCompanionBuilder,
      $$SubstitutionFeedbackTableUpdateCompanionBuilder,
      (SubstitutionFeedbackData, $$SubstitutionFeedbackTableReferences),
      SubstitutionFeedbackData,
      PrefetchHooks Function({bool sourceExerciseId, bool rejectedExerciseId})
    >;
typedef $$SyncQueueTableCreateCompanionBuilder =
    SyncQueueCompanion Function({
      required String id,
      required SyncAction action,
      required String payload,
      Value<SyncStatus> status,
      Value<int> retryCount,
      Value<String?> lastError,
      required String createdAt,
      Value<String?> processedAt,
      Value<String?> updatedAt,
      Value<int> rowid,
    });
typedef $$SyncQueueTableUpdateCompanionBuilder =
    SyncQueueCompanion Function({
      Value<String> id,
      Value<SyncAction> action,
      Value<String> payload,
      Value<SyncStatus> status,
      Value<int> retryCount,
      Value<String?> lastError,
      Value<String> createdAt,
      Value<String?> processedAt,
      Value<String?> updatedAt,
      Value<int> rowid,
    });

class $$SyncQueueTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncAction, SyncAction, String> get action =>
      $composableBuilder(
        column: $table.action,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SyncStatus, SyncStatus, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get processedAt => $composableBuilder(
    column: $table.processedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get processedAt => $composableBuilder(
    column: $table.processedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncAction, String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SyncStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get processedAt => $composableBuilder(
    column: $table.processedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SyncQueueTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncQueueTable,
          SyncQueueData,
          $$SyncQueueTableFilterComposer,
          $$SyncQueueTableOrderingComposer,
          $$SyncQueueTableAnnotationComposer,
          $$SyncQueueTableCreateCompanionBuilder,
          $$SyncQueueTableUpdateCompanionBuilder,
          (
            SyncQueueData,
            BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
          ),
          SyncQueueData,
          PrefetchHooks Function()
        > {
  $$SyncQueueTableTableManager(_$AppDatabase db, $SyncQueueTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<SyncAction> action = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<SyncStatus> status = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String?> processedAt = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncQueueCompanion(
                id: id,
                action: action,
                payload: payload,
                status: status,
                retryCount: retryCount,
                lastError: lastError,
                createdAt: createdAt,
                processedAt: processedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required SyncAction action,
                required String payload,
                Value<SyncStatus> status = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                required String createdAt,
                Value<String?> processedAt = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncQueueCompanion.insert(
                id: id,
                action: action,
                payload: payload,
                status: status,
                retryCount: retryCount,
                lastError: lastError,
                createdAt: createdAt,
                processedAt: processedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncQueueTable,
      SyncQueueData,
      $$SyncQueueTableFilterComposer,
      $$SyncQueueTableOrderingComposer,
      $$SyncQueueTableAnnotationComposer,
      $$SyncQueueTableCreateCompanionBuilder,
      $$SyncQueueTableUpdateCompanionBuilder,
      (
        SyncQueueData,
        BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
      ),
      SyncQueueData,
      PrefetchHooks Function()
    >;
typedef $$UserPreferencesTableCreateCompanionBuilder =
    UserPreferencesCompanion Function({
      required String userId,
      required String exerciseId,
      Value<double> preferenceScore,
      Value<bool> isBlacklisted,
      Value<int> rowid,
    });
typedef $$UserPreferencesTableUpdateCompanionBuilder =
    UserPreferencesCompanion Function({
      Value<String> userId,
      Value<String> exerciseId,
      Value<double> preferenceScore,
      Value<bool> isBlacklisted,
      Value<int> rowid,
    });

final class $$UserPreferencesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $UserPreferencesTable,
          UserPreferenceData
        > {
  $$UserPreferencesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
        $_aliasNameGenerator(db.userPreferences.exerciseId, db.exercises.id),
      );

  $$ExercisesTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<String>('exercise_id')!;

    final manager = $$ExercisesTableTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserPreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get preferenceScore => $composableBuilder(
    column: $table.preferenceScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBlacklisted => $composableBuilder(
    column: $table.isBlacklisted,
    builder: (column) => ColumnFilters(column),
  );

  $$ExercisesTableFilterComposer get exerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserPreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get preferenceScore => $composableBuilder(
    column: $table.preferenceScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBlacklisted => $composableBuilder(
    column: $table.isBlacklisted,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExercisesTableOrderingComposer get exerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserPreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<double> get preferenceScore => $composableBuilder(
    column: $table.preferenceScore,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isBlacklisted => $composableBuilder(
    column: $table.isBlacklisted,
    builder: (column) => column,
  );

  $$ExercisesTableAnnotationComposer get exerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserPreferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserPreferencesTable,
          UserPreferenceData,
          $$UserPreferencesTableFilterComposer,
          $$UserPreferencesTableOrderingComposer,
          $$UserPreferencesTableAnnotationComposer,
          $$UserPreferencesTableCreateCompanionBuilder,
          $$UserPreferencesTableUpdateCompanionBuilder,
          (UserPreferenceData, $$UserPreferencesTableReferences),
          UserPreferenceData,
          PrefetchHooks Function({bool exerciseId})
        > {
  $$UserPreferencesTableTableManager(
    _$AppDatabase db,
    $UserPreferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserPreferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserPreferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserPreferencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<double> preferenceScore = const Value.absent(),
                Value<bool> isBlacklisted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserPreferencesCompanion(
                userId: userId,
                exerciseId: exerciseId,
                preferenceScore: preferenceScore,
                isBlacklisted: isBlacklisted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                required String exerciseId,
                Value<double> preferenceScore = const Value.absent(),
                Value<bool> isBlacklisted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserPreferencesCompanion.insert(
                userId: userId,
                exerciseId: exerciseId,
                preferenceScore: preferenceScore,
                isBlacklisted: isBlacklisted,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserPreferencesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({exerciseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (exerciseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.exerciseId,
                                referencedTable:
                                    $$UserPreferencesTableReferences
                                        ._exerciseIdTable(db),
                                referencedColumn:
                                    $$UserPreferencesTableReferences
                                        ._exerciseIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserPreferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserPreferencesTable,
      UserPreferenceData,
      $$UserPreferencesTableFilterComposer,
      $$UserPreferencesTableOrderingComposer,
      $$UserPreferencesTableAnnotationComposer,
      $$UserPreferencesTableCreateCompanionBuilder,
      $$UserPreferencesTableUpdateCompanionBuilder,
      (UserPreferenceData, $$UserPreferencesTableReferences),
      UserPreferenceData,
      PrefetchHooks Function({bool exerciseId})
    >;
typedef $$UserMuscleConstraintsTableCreateCompanionBuilder =
    UserMuscleConstraintsCompanion Function({
      required String userId,
      required String muscleId,
      required MuscleConstraintStatus status,
      Value<String?> expiresAt,
      Value<int> rowid,
    });
typedef $$UserMuscleConstraintsTableUpdateCompanionBuilder =
    UserMuscleConstraintsCompanion Function({
      Value<String> userId,
      Value<String> muscleId,
      Value<MuscleConstraintStatus> status,
      Value<String?> expiresAt,
      Value<int> rowid,
    });

final class $$UserMuscleConstraintsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $UserMuscleConstraintsTable,
          UserMuscleConstraintData
        > {
  $$UserMuscleConstraintsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MuscleRegionsTable _muscleIdTable(_$AppDatabase db) =>
      db.muscleRegions.createAlias(
        $_aliasNameGenerator(
          db.userMuscleConstraints.muscleId,
          db.muscleRegions.id,
        ),
      );

  $$MuscleRegionsTableProcessedTableManager get muscleId {
    final $_column = $_itemColumn<String>('muscle_id')!;

    final manager = $$MuscleRegionsTableTableManager(
      $_db,
      $_db.muscleRegions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_muscleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserMuscleConstraintsTableFilterComposer
    extends Composer<_$AppDatabase, $UserMuscleConstraintsTable> {
  $$UserMuscleConstraintsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    MuscleConstraintStatus,
    MuscleConstraintStatus,
    String
  >
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MuscleRegionsTableFilterComposer get muscleId {
    final $$MuscleRegionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.muscleId,
      referencedTable: $db.muscleRegions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MuscleRegionsTableFilterComposer(
            $db: $db,
            $table: $db.muscleRegions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserMuscleConstraintsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserMuscleConstraintsTable> {
  $$UserMuscleConstraintsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MuscleRegionsTableOrderingComposer get muscleId {
    final $$MuscleRegionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.muscleId,
      referencedTable: $db.muscleRegions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MuscleRegionsTableOrderingComposer(
            $db: $db,
            $table: $db.muscleRegions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserMuscleConstraintsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserMuscleConstraintsTable> {
  $$UserMuscleConstraintsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MuscleConstraintStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  $$MuscleRegionsTableAnnotationComposer get muscleId {
    final $$MuscleRegionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.muscleId,
      referencedTable: $db.muscleRegions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MuscleRegionsTableAnnotationComposer(
            $db: $db,
            $table: $db.muscleRegions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserMuscleConstraintsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserMuscleConstraintsTable,
          UserMuscleConstraintData,
          $$UserMuscleConstraintsTableFilterComposer,
          $$UserMuscleConstraintsTableOrderingComposer,
          $$UserMuscleConstraintsTableAnnotationComposer,
          $$UserMuscleConstraintsTableCreateCompanionBuilder,
          $$UserMuscleConstraintsTableUpdateCompanionBuilder,
          (UserMuscleConstraintData, $$UserMuscleConstraintsTableReferences),
          UserMuscleConstraintData,
          PrefetchHooks Function({bool muscleId})
        > {
  $$UserMuscleConstraintsTableTableManager(
    _$AppDatabase db,
    $UserMuscleConstraintsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserMuscleConstraintsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$UserMuscleConstraintsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$UserMuscleConstraintsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<String> muscleId = const Value.absent(),
                Value<MuscleConstraintStatus> status = const Value.absent(),
                Value<String?> expiresAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserMuscleConstraintsCompanion(
                userId: userId,
                muscleId: muscleId,
                status: status,
                expiresAt: expiresAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                required String muscleId,
                required MuscleConstraintStatus status,
                Value<String?> expiresAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserMuscleConstraintsCompanion.insert(
                userId: userId,
                muscleId: muscleId,
                status: status,
                expiresAt: expiresAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserMuscleConstraintsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({muscleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (muscleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.muscleId,
                                referencedTable:
                                    $$UserMuscleConstraintsTableReferences
                                        ._muscleIdTable(db),
                                referencedColumn:
                                    $$UserMuscleConstraintsTableReferences
                                        ._muscleIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserMuscleConstraintsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserMuscleConstraintsTable,
      UserMuscleConstraintData,
      $$UserMuscleConstraintsTableFilterComposer,
      $$UserMuscleConstraintsTableOrderingComposer,
      $$UserMuscleConstraintsTableAnnotationComposer,
      $$UserMuscleConstraintsTableCreateCompanionBuilder,
      $$UserMuscleConstraintsTableUpdateCompanionBuilder,
      (UserMuscleConstraintData, $$UserMuscleConstraintsTableReferences),
      UserMuscleConstraintData,
      PrefetchHooks Function({bool muscleId})
    >;
typedef $$WorkoutsTableCreateCompanionBuilder =
    WorkoutsCompanion Function({
      required String id,
      required String userId,
      Value<String?> name,
      required WorkoutStatus status,
      Value<DateTime?> startedAt,
      Value<DateTime?> completedAt,
      Value<double> volumeLoad,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$WorkoutsTableUpdateCompanionBuilder =
    WorkoutsCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String?> name,
      Value<WorkoutStatus> status,
      Value<DateTime?> startedAt,
      Value<DateTime?> completedAt,
      Value<double> volumeLoad,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$WorkoutsTableReferences
    extends BaseReferences<_$AppDatabase, $WorkoutsTable, Workout> {
  $$WorkoutsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WorkoutExercisesTable, List<WorkoutExercise>>
  _workoutExercisesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.workoutExercises,
    aliasName: $_aliasNameGenerator(
      db.workouts.id,
      db.workoutExercises.workoutId,
    ),
  );

  $$WorkoutExercisesTableProcessedTableManager get workoutExercisesRefs {
    final manager = $$WorkoutExercisesTableTableManager(
      $_db,
      $_db.workoutExercises,
    ).filter((f) => f.workoutId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _workoutExercisesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WorkoutsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<WorkoutStatus, WorkoutStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get volumeLoad => $composableBuilder(
    column: $table.volumeLoad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> workoutExercisesRefs(
    Expression<bool> Function($$WorkoutExercisesTableFilterComposer f) f,
  ) {
    final $$WorkoutExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutExercises,
      getReferencedColumn: (t) => t.workoutId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutExercisesTableFilterComposer(
            $db: $db,
            $table: $db.workoutExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WorkoutsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get volumeLoad => $composableBuilder(
    column: $table.volumeLoad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkoutsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<WorkoutStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<double> get volumeLoad => $composableBuilder(
    column: $table.volumeLoad,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> workoutExercisesRefs<T extends Object>(
    Expression<T> Function($$WorkoutExercisesTableAnnotationComposer a) f,
  ) {
    final $$WorkoutExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutExercises,
      getReferencedColumn: (t) => t.workoutId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.workoutExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WorkoutsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutsTable,
          Workout,
          $$WorkoutsTableFilterComposer,
          $$WorkoutsTableOrderingComposer,
          $$WorkoutsTableAnnotationComposer,
          $$WorkoutsTableCreateCompanionBuilder,
          $$WorkoutsTableUpdateCompanionBuilder,
          (Workout, $$WorkoutsTableReferences),
          Workout,
          PrefetchHooks Function({bool workoutExercisesRefs})
        > {
  $$WorkoutsTableTableManager(_$AppDatabase db, $WorkoutsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<WorkoutStatus> status = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<double> volumeLoad = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutsCompanion(
                id: id,
                userId: userId,
                name: name,
                status: status,
                startedAt: startedAt,
                completedAt: completedAt,
                volumeLoad: volumeLoad,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                Value<String?> name = const Value.absent(),
                required WorkoutStatus status,
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<double> volumeLoad = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutsCompanion.insert(
                id: id,
                userId: userId,
                name: name,
                status: status,
                startedAt: startedAt,
                completedAt: completedAt,
                volumeLoad: volumeLoad,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WorkoutsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({workoutExercisesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (workoutExercisesRefs) db.workoutExercises,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (workoutExercisesRefs)
                    await $_getPrefetchedData<
                      Workout,
                      $WorkoutsTable,
                      WorkoutExercise
                    >(
                      currentTable: table,
                      referencedTable: $$WorkoutsTableReferences
                          ._workoutExercisesRefsTable(db),
                      managerFromTypedResult: (p0) => $$WorkoutsTableReferences(
                        db,
                        table,
                        p0,
                      ).workoutExercisesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.workoutId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$WorkoutsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutsTable,
      Workout,
      $$WorkoutsTableFilterComposer,
      $$WorkoutsTableOrderingComposer,
      $$WorkoutsTableAnnotationComposer,
      $$WorkoutsTableCreateCompanionBuilder,
      $$WorkoutsTableUpdateCompanionBuilder,
      (Workout, $$WorkoutsTableReferences),
      Workout,
      PrefetchHooks Function({bool workoutExercisesRefs})
    >;
typedef $$WorkoutExercisesTableCreateCompanionBuilder =
    WorkoutExercisesCompanion Function({
      required String id,
      required String workoutId,
      required String exerciseId,
      required int orderIndex,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$WorkoutExercisesTableUpdateCompanionBuilder =
    WorkoutExercisesCompanion Function({
      Value<String> id,
      Value<String> workoutId,
      Value<String> exerciseId,
      Value<int> orderIndex,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$WorkoutExercisesTableReferences
    extends
        BaseReferences<_$AppDatabase, $WorkoutExercisesTable, WorkoutExercise> {
  $$WorkoutExercisesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WorkoutsTable _workoutIdTable(_$AppDatabase db) =>
      db.workouts.createAlias(
        $_aliasNameGenerator(db.workoutExercises.workoutId, db.workouts.id),
      );

  $$WorkoutsTableProcessedTableManager get workoutId {
    final $_column = $_itemColumn<String>('workout_id')!;

    final manager = $$WorkoutsTableTableManager(
      $_db,
      $_db.workouts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workoutIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
        $_aliasNameGenerator(db.workoutExercises.exerciseId, db.exercises.id),
      );

  $$ExercisesTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<String>('exercise_id')!;

    final manager = $$ExercisesTableTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$WorkoutSetsTable, List<WorkoutSet>>
  _workoutSetsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.workoutSets,
    aliasName: $_aliasNameGenerator(
      db.workoutExercises.id,
      db.workoutSets.workoutExerciseId,
    ),
  );

  $$WorkoutSetsTableProcessedTableManager get workoutSetsRefs {
    final manager = $$WorkoutSetsTableTableManager($_db, $_db.workoutSets)
        .filter(
          (f) => f.workoutExerciseId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_workoutSetsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WorkoutExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutExercisesTable> {
  $$WorkoutExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$WorkoutsTableFilterComposer get workoutId {
    final $$WorkoutsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workoutId,
      referencedTable: $db.workouts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutsTableFilterComposer(
            $db: $db,
            $table: $db.workouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExercisesTableFilterComposer get exerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> workoutSetsRefs(
    Expression<bool> Function($$WorkoutSetsTableFilterComposer f) f,
  ) {
    final $$WorkoutSetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutSets,
      getReferencedColumn: (t) => t.workoutExerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSetsTableFilterComposer(
            $db: $db,
            $table: $db.workoutSets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WorkoutExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutExercisesTable> {
  $$WorkoutExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$WorkoutsTableOrderingComposer get workoutId {
    final $$WorkoutsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workoutId,
      referencedTable: $db.workouts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutsTableOrderingComposer(
            $db: $db,
            $table: $db.workouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExercisesTableOrderingComposer get exerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkoutExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutExercisesTable> {
  $$WorkoutExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$WorkoutsTableAnnotationComposer get workoutId {
    final $$WorkoutsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workoutId,
      referencedTable: $db.workouts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutsTableAnnotationComposer(
            $db: $db,
            $table: $db.workouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExercisesTableAnnotationComposer get exerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> workoutSetsRefs<T extends Object>(
    Expression<T> Function($$WorkoutSetsTableAnnotationComposer a) f,
  ) {
    final $$WorkoutSetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutSets,
      getReferencedColumn: (t) => t.workoutExerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSetsTableAnnotationComposer(
            $db: $db,
            $table: $db.workoutSets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WorkoutExercisesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutExercisesTable,
          WorkoutExercise,
          $$WorkoutExercisesTableFilterComposer,
          $$WorkoutExercisesTableOrderingComposer,
          $$WorkoutExercisesTableAnnotationComposer,
          $$WorkoutExercisesTableCreateCompanionBuilder,
          $$WorkoutExercisesTableUpdateCompanionBuilder,
          (WorkoutExercise, $$WorkoutExercisesTableReferences),
          WorkoutExercise,
          PrefetchHooks Function({
            bool workoutId,
            bool exerciseId,
            bool workoutSetsRefs,
          })
        > {
  $$WorkoutExercisesTableTableManager(
    _$AppDatabase db,
    $WorkoutExercisesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> workoutId = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutExercisesCompanion(
                id: id,
                workoutId: workoutId,
                exerciseId: exerciseId,
                orderIndex: orderIndex,
                notes: notes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String workoutId,
                required String exerciseId,
                required int orderIndex,
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutExercisesCompanion.insert(
                id: id,
                workoutId: workoutId,
                exerciseId: exerciseId,
                orderIndex: orderIndex,
                notes: notes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WorkoutExercisesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                workoutId = false,
                exerciseId = false,
                workoutSetsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (workoutSetsRefs) db.workoutSets,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (workoutId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.workoutId,
                                    referencedTable:
                                        $$WorkoutExercisesTableReferences
                                            ._workoutIdTable(db),
                                    referencedColumn:
                                        $$WorkoutExercisesTableReferences
                                            ._workoutIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (exerciseId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.exerciseId,
                                    referencedTable:
                                        $$WorkoutExercisesTableReferences
                                            ._exerciseIdTable(db),
                                    referencedColumn:
                                        $$WorkoutExercisesTableReferences
                                            ._exerciseIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (workoutSetsRefs)
                        await $_getPrefetchedData<
                          WorkoutExercise,
                          $WorkoutExercisesTable,
                          WorkoutSet
                        >(
                          currentTable: table,
                          referencedTable: $$WorkoutExercisesTableReferences
                              ._workoutSetsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WorkoutExercisesTableReferences(
                                db,
                                table,
                                p0,
                              ).workoutSetsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.workoutExerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$WorkoutExercisesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutExercisesTable,
      WorkoutExercise,
      $$WorkoutExercisesTableFilterComposer,
      $$WorkoutExercisesTableOrderingComposer,
      $$WorkoutExercisesTableAnnotationComposer,
      $$WorkoutExercisesTableCreateCompanionBuilder,
      $$WorkoutExercisesTableUpdateCompanionBuilder,
      (WorkoutExercise, $$WorkoutExercisesTableReferences),
      WorkoutExercise,
      PrefetchHooks Function({
        bool workoutId,
        bool exerciseId,
        bool workoutSetsRefs,
      })
    >;
typedef $$WorkoutSetsTableCreateCompanionBuilder =
    WorkoutSetsCompanion Function({
      required String id,
      required String workoutExerciseId,
      required SetType setType,
      Value<TrackingType> trackingType,
      Value<double?> weight,
      Value<int?> reps,
      Value<double?> rpe,
      Value<double?> distance,
      Value<int?> duration,
      Value<int?> heartRate,
      Value<bool> isPr,
      Value<int?> restSeconds,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$WorkoutSetsTableUpdateCompanionBuilder =
    WorkoutSetsCompanion Function({
      Value<String> id,
      Value<String> workoutExerciseId,
      Value<SetType> setType,
      Value<TrackingType> trackingType,
      Value<double?> weight,
      Value<int?> reps,
      Value<double?> rpe,
      Value<double?> distance,
      Value<int?> duration,
      Value<int?> heartRate,
      Value<bool> isPr,
      Value<int?> restSeconds,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$WorkoutSetsTableReferences
    extends BaseReferences<_$AppDatabase, $WorkoutSetsTable, WorkoutSet> {
  $$WorkoutSetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorkoutExercisesTable _workoutExerciseIdTable(_$AppDatabase db) =>
      db.workoutExercises.createAlias(
        $_aliasNameGenerator(
          db.workoutSets.workoutExerciseId,
          db.workoutExercises.id,
        ),
      );

  $$WorkoutExercisesTableProcessedTableManager get workoutExerciseId {
    final $_column = $_itemColumn<String>('workout_exercise_id')!;

    final manager = $$WorkoutExercisesTableTableManager(
      $_db,
      $_db.workoutExercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workoutExerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WorkoutSetsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutSetsTable> {
  $$WorkoutSetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SetType, SetType, String> get setType =>
      $composableBuilder(
        column: $table.setType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<TrackingType, TrackingType, String>
  get trackingType => $composableBuilder(
    column: $table.trackingType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rpe => $composableBuilder(
    column: $table.rpe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get distance => $composableBuilder(
    column: $table.distance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get heartRate => $composableBuilder(
    column: $table.heartRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPr => $composableBuilder(
    column: $table.isPr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get restSeconds => $composableBuilder(
    column: $table.restSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$WorkoutExercisesTableFilterComposer get workoutExerciseId {
    final $$WorkoutExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workoutExerciseId,
      referencedTable: $db.workoutExercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutExercisesTableFilterComposer(
            $db: $db,
            $table: $db.workoutExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkoutSetsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutSetsTable> {
  $$WorkoutSetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get setType => $composableBuilder(
    column: $table.setType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trackingType => $composableBuilder(
    column: $table.trackingType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rpe => $composableBuilder(
    column: $table.rpe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get distance => $composableBuilder(
    column: $table.distance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get heartRate => $composableBuilder(
    column: $table.heartRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPr => $composableBuilder(
    column: $table.isPr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get restSeconds => $composableBuilder(
    column: $table.restSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$WorkoutExercisesTableOrderingComposer get workoutExerciseId {
    final $$WorkoutExercisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workoutExerciseId,
      referencedTable: $db.workoutExercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutExercisesTableOrderingComposer(
            $db: $db,
            $table: $db.workoutExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkoutSetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutSetsTable> {
  $$WorkoutSetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SetType, String> get setType =>
      $composableBuilder(column: $table.setType, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TrackingType, String> get trackingType =>
      $composableBuilder(
        column: $table.trackingType,
        builder: (column) => column,
      );

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<double> get rpe =>
      $composableBuilder(column: $table.rpe, builder: (column) => column);

  GeneratedColumn<double> get distance =>
      $composableBuilder(column: $table.distance, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<int> get heartRate =>
      $composableBuilder(column: $table.heartRate, builder: (column) => column);

  GeneratedColumn<bool> get isPr =>
      $composableBuilder(column: $table.isPr, builder: (column) => column);

  GeneratedColumn<int> get restSeconds => $composableBuilder(
    column: $table.restSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$WorkoutExercisesTableAnnotationComposer get workoutExerciseId {
    final $$WorkoutExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workoutExerciseId,
      referencedTable: $db.workoutExercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.workoutExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkoutSetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutSetsTable,
          WorkoutSet,
          $$WorkoutSetsTableFilterComposer,
          $$WorkoutSetsTableOrderingComposer,
          $$WorkoutSetsTableAnnotationComposer,
          $$WorkoutSetsTableCreateCompanionBuilder,
          $$WorkoutSetsTableUpdateCompanionBuilder,
          (WorkoutSet, $$WorkoutSetsTableReferences),
          WorkoutSet,
          PrefetchHooks Function({bool workoutExerciseId})
        > {
  $$WorkoutSetsTableTableManager(_$AppDatabase db, $WorkoutSetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutSetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutSetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutSetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> workoutExerciseId = const Value.absent(),
                Value<SetType> setType = const Value.absent(),
                Value<TrackingType> trackingType = const Value.absent(),
                Value<double?> weight = const Value.absent(),
                Value<int?> reps = const Value.absent(),
                Value<double?> rpe = const Value.absent(),
                Value<double?> distance = const Value.absent(),
                Value<int?> duration = const Value.absent(),
                Value<int?> heartRate = const Value.absent(),
                Value<bool> isPr = const Value.absent(),
                Value<int?> restSeconds = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutSetsCompanion(
                id: id,
                workoutExerciseId: workoutExerciseId,
                setType: setType,
                trackingType: trackingType,
                weight: weight,
                reps: reps,
                rpe: rpe,
                distance: distance,
                duration: duration,
                heartRate: heartRate,
                isPr: isPr,
                restSeconds: restSeconds,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String workoutExerciseId,
                required SetType setType,
                Value<TrackingType> trackingType = const Value.absent(),
                Value<double?> weight = const Value.absent(),
                Value<int?> reps = const Value.absent(),
                Value<double?> rpe = const Value.absent(),
                Value<double?> distance = const Value.absent(),
                Value<int?> duration = const Value.absent(),
                Value<int?> heartRate = const Value.absent(),
                Value<bool> isPr = const Value.absent(),
                Value<int?> restSeconds = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutSetsCompanion.insert(
                id: id,
                workoutExerciseId: workoutExerciseId,
                setType: setType,
                trackingType: trackingType,
                weight: weight,
                reps: reps,
                rpe: rpe,
                distance: distance,
                duration: duration,
                heartRate: heartRate,
                isPr: isPr,
                restSeconds: restSeconds,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WorkoutSetsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({workoutExerciseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (workoutExerciseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.workoutExerciseId,
                                referencedTable: $$WorkoutSetsTableReferences
                                    ._workoutExerciseIdTable(db),
                                referencedColumn: $$WorkoutSetsTableReferences
                                    ._workoutExerciseIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WorkoutSetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutSetsTable,
      WorkoutSet,
      $$WorkoutSetsTableFilterComposer,
      $$WorkoutSetsTableOrderingComposer,
      $$WorkoutSetsTableAnnotationComposer,
      $$WorkoutSetsTableCreateCompanionBuilder,
      $$WorkoutSetsTableUpdateCompanionBuilder,
      (WorkoutSet, $$WorkoutSetsTableReferences),
      WorkoutSet,
      PrefetchHooks Function({bool workoutExerciseId})
    >;
typedef $$UserStatsTableCreateCompanionBuilder =
    UserStatsCompanion Function({
      Value<String> userId,
      Value<int> currentStreak,
      Value<int> longestStreak,
      Value<int> streakShields,
      Value<DateTime?> lastWorkoutDate,
      Value<int> totalXp,
      Value<int> level,
      Value<int> rowid,
    });
typedef $$UserStatsTableUpdateCompanionBuilder =
    UserStatsCompanion Function({
      Value<String> userId,
      Value<int> currentStreak,
      Value<int> longestStreak,
      Value<int> streakShields,
      Value<DateTime?> lastWorkoutDate,
      Value<int> totalXp,
      Value<int> level,
      Value<int> rowid,
    });

class $$UserStatsTableFilterComposer
    extends Composer<_$AppDatabase, $UserStatsTable> {
  $$UserStatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get longestStreak => $composableBuilder(
    column: $table.longestStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get streakShields => $composableBuilder(
    column: $table.streakShields,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastWorkoutDate => $composableBuilder(
    column: $table.lastWorkoutDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalXp => $composableBuilder(
    column: $table.totalXp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserStatsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserStatsTable> {
  $$UserStatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get longestStreak => $composableBuilder(
    column: $table.longestStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get streakShields => $composableBuilder(
    column: $table.streakShields,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastWorkoutDate => $composableBuilder(
    column: $table.lastWorkoutDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalXp => $composableBuilder(
    column: $table.totalXp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserStatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserStatsTable> {
  $$UserStatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => column,
  );

  GeneratedColumn<int> get longestStreak => $composableBuilder(
    column: $table.longestStreak,
    builder: (column) => column,
  );

  GeneratedColumn<int> get streakShields => $composableBuilder(
    column: $table.streakShields,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastWorkoutDate => $composableBuilder(
    column: $table.lastWorkoutDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalXp =>
      $composableBuilder(column: $table.totalXp, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);
}

class $$UserStatsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserStatsTable,
          UserStat,
          $$UserStatsTableFilterComposer,
          $$UserStatsTableOrderingComposer,
          $$UserStatsTableAnnotationComposer,
          $$UserStatsTableCreateCompanionBuilder,
          $$UserStatsTableUpdateCompanionBuilder,
          (UserStat, BaseReferences<_$AppDatabase, $UserStatsTable, UserStat>),
          UserStat,
          PrefetchHooks Function()
        > {
  $$UserStatsTableTableManager(_$AppDatabase db, $UserStatsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserStatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserStatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserStatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<int> currentStreak = const Value.absent(),
                Value<int> longestStreak = const Value.absent(),
                Value<int> streakShields = const Value.absent(),
                Value<DateTime?> lastWorkoutDate = const Value.absent(),
                Value<int> totalXp = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserStatsCompanion(
                userId: userId,
                currentStreak: currentStreak,
                longestStreak: longestStreak,
                streakShields: streakShields,
                lastWorkoutDate: lastWorkoutDate,
                totalXp: totalXp,
                level: level,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<int> currentStreak = const Value.absent(),
                Value<int> longestStreak = const Value.absent(),
                Value<int> streakShields = const Value.absent(),
                Value<DateTime?> lastWorkoutDate = const Value.absent(),
                Value<int> totalXp = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserStatsCompanion.insert(
                userId: userId,
                currentStreak: currentStreak,
                longestStreak: longestStreak,
                streakShields: streakShields,
                lastWorkoutDate: lastWorkoutDate,
                totalXp: totalXp,
                level: level,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserStatsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserStatsTable,
      UserStat,
      $$UserStatsTableFilterComposer,
      $$UserStatsTableOrderingComposer,
      $$UserStatsTableAnnotationComposer,
      $$UserStatsTableCreateCompanionBuilder,
      $$UserStatsTableUpdateCompanionBuilder,
      (UserStat, BaseReferences<_$AppDatabase, $UserStatsTable, UserStat>),
      UserStat,
      PrefetchHooks Function()
    >;
typedef $$MuscleExperienceTableCreateCompanionBuilder =
    MuscleExperienceCompanion Function({
      Value<String> userId,
      required String muscleRegionId,
      Value<int> xp,
      Value<int> level,
      Value<int> rowid,
    });
typedef $$MuscleExperienceTableUpdateCompanionBuilder =
    MuscleExperienceCompanion Function({
      Value<String> userId,
      Value<String> muscleRegionId,
      Value<int> xp,
      Value<int> level,
      Value<int> rowid,
    });

class $$MuscleExperienceTableFilterComposer
    extends Composer<_$AppDatabase, $MuscleExperienceTable> {
  $$MuscleExperienceTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get muscleRegionId => $composableBuilder(
    column: $table.muscleRegionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MuscleExperienceTableOrderingComposer
    extends Composer<_$AppDatabase, $MuscleExperienceTable> {
  $$MuscleExperienceTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get muscleRegionId => $composableBuilder(
    column: $table.muscleRegionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MuscleExperienceTableAnnotationComposer
    extends Composer<_$AppDatabase, $MuscleExperienceTable> {
  $$MuscleExperienceTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get muscleRegionId => $composableBuilder(
    column: $table.muscleRegionId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get xp =>
      $composableBuilder(column: $table.xp, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);
}

class $$MuscleExperienceTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MuscleExperienceTable,
          MuscleExperienceData,
          $$MuscleExperienceTableFilterComposer,
          $$MuscleExperienceTableOrderingComposer,
          $$MuscleExperienceTableAnnotationComposer,
          $$MuscleExperienceTableCreateCompanionBuilder,
          $$MuscleExperienceTableUpdateCompanionBuilder,
          (
            MuscleExperienceData,
            BaseReferences<
              _$AppDatabase,
              $MuscleExperienceTable,
              MuscleExperienceData
            >,
          ),
          MuscleExperienceData,
          PrefetchHooks Function()
        > {
  $$MuscleExperienceTableTableManager(
    _$AppDatabase db,
    $MuscleExperienceTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MuscleExperienceTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MuscleExperienceTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MuscleExperienceTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<String> muscleRegionId = const Value.absent(),
                Value<int> xp = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MuscleExperienceCompanion(
                userId: userId,
                muscleRegionId: muscleRegionId,
                xp: xp,
                level: level,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                required String muscleRegionId,
                Value<int> xp = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MuscleExperienceCompanion.insert(
                userId: userId,
                muscleRegionId: muscleRegionId,
                xp: xp,
                level: level,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MuscleExperienceTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MuscleExperienceTable,
      MuscleExperienceData,
      $$MuscleExperienceTableFilterComposer,
      $$MuscleExperienceTableOrderingComposer,
      $$MuscleExperienceTableAnnotationComposer,
      $$MuscleExperienceTableCreateCompanionBuilder,
      $$MuscleExperienceTableUpdateCompanionBuilder,
      (
        MuscleExperienceData,
        BaseReferences<
          _$AppDatabase,
          $MuscleExperienceTable,
          MuscleExperienceData
        >,
      ),
      MuscleExperienceData,
      PrefetchHooks Function()
    >;
typedef $$MigrationStatusTableCreateCompanionBuilder =
    MigrationStatusCompanion Function({
      required String id,
      required String state,
      required String fromUserId,
      required String toUserId,
      required String updatedAt,
      Value<int> rowid,
    });
typedef $$MigrationStatusTableUpdateCompanionBuilder =
    MigrationStatusCompanion Function({
      Value<String> id,
      Value<String> state,
      Value<String> fromUserId,
      Value<String> toUserId,
      Value<String> updatedAt,
      Value<int> rowid,
    });

class $$MigrationStatusTableFilterComposer
    extends Composer<_$AppDatabase, $MigrationStatusTable> {
  $$MigrationStatusTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fromUserId => $composableBuilder(
    column: $table.fromUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toUserId => $composableBuilder(
    column: $table.toUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MigrationStatusTableOrderingComposer
    extends Composer<_$AppDatabase, $MigrationStatusTable> {
  $$MigrationStatusTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fromUserId => $composableBuilder(
    column: $table.fromUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toUserId => $composableBuilder(
    column: $table.toUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MigrationStatusTableAnnotationComposer
    extends Composer<_$AppDatabase, $MigrationStatusTable> {
  $$MigrationStatusTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get fromUserId => $composableBuilder(
    column: $table.fromUserId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get toUserId =>
      $composableBuilder(column: $table.toUserId, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MigrationStatusTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MigrationStatusTable,
          MigrationStatusData,
          $$MigrationStatusTableFilterComposer,
          $$MigrationStatusTableOrderingComposer,
          $$MigrationStatusTableAnnotationComposer,
          $$MigrationStatusTableCreateCompanionBuilder,
          $$MigrationStatusTableUpdateCompanionBuilder,
          (
            MigrationStatusData,
            BaseReferences<
              _$AppDatabase,
              $MigrationStatusTable,
              MigrationStatusData
            >,
          ),
          MigrationStatusData,
          PrefetchHooks Function()
        > {
  $$MigrationStatusTableTableManager(
    _$AppDatabase db,
    $MigrationStatusTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MigrationStatusTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MigrationStatusTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MigrationStatusTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<String> fromUserId = const Value.absent(),
                Value<String> toUserId = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MigrationStatusCompanion(
                id: id,
                state: state,
                fromUserId: fromUserId,
                toUserId: toUserId,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String state,
                required String fromUserId,
                required String toUserId,
                required String updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => MigrationStatusCompanion.insert(
                id: id,
                state: state,
                fromUserId: fromUserId,
                toUserId: toUserId,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MigrationStatusTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MigrationStatusTable,
      MigrationStatusData,
      $$MigrationStatusTableFilterComposer,
      $$MigrationStatusTableOrderingComposer,
      $$MigrationStatusTableAnnotationComposer,
      $$MigrationStatusTableCreateCompanionBuilder,
      $$MigrationStatusTableUpdateCompanionBuilder,
      (
        MigrationStatusData,
        BaseReferences<
          _$AppDatabase,
          $MigrationStatusTable,
          MigrationStatusData
        >,
      ),
      MigrationStatusData,
      PrefetchHooks Function()
    >;
typedef $$UserBiometricsTableCreateCompanionBuilder =
    UserBiometricsCompanion Function({
      required String userId,
      Value<String?> experienceLevel,
      Value<String?> primaryGoal,
      Value<String?> equipmentAvailability,
      Value<double?> weight,
      Value<double?> height,
      Value<int?> age,
      required String updatedAt,
      Value<int> rowid,
    });
typedef $$UserBiometricsTableUpdateCompanionBuilder =
    UserBiometricsCompanion Function({
      Value<String> userId,
      Value<String?> experienceLevel,
      Value<String?> primaryGoal,
      Value<String?> equipmentAvailability,
      Value<double?> weight,
      Value<double?> height,
      Value<int?> age,
      Value<String> updatedAt,
      Value<int> rowid,
    });

class $$UserBiometricsTableFilterComposer
    extends Composer<_$AppDatabase, $UserBiometricsTable> {
  $$UserBiometricsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get experienceLevel => $composableBuilder(
    column: $table.experienceLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primaryGoal => $composableBuilder(
    column: $table.primaryGoal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get equipmentAvailability => $composableBuilder(
    column: $table.equipmentAvailability,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserBiometricsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserBiometricsTable> {
  $$UserBiometricsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get experienceLevel => $composableBuilder(
    column: $table.experienceLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primaryGoal => $composableBuilder(
    column: $table.primaryGoal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get equipmentAvailability => $composableBuilder(
    column: $table.equipmentAvailability,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserBiometricsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserBiometricsTable> {
  $$UserBiometricsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get experienceLevel => $composableBuilder(
    column: $table.experienceLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get primaryGoal => $composableBuilder(
    column: $table.primaryGoal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get equipmentAvailability => $composableBuilder(
    column: $table.equipmentAvailability,
    builder: (column) => column,
  );

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<double> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserBiometricsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserBiometricsTable,
          UserBiometricData,
          $$UserBiometricsTableFilterComposer,
          $$UserBiometricsTableOrderingComposer,
          $$UserBiometricsTableAnnotationComposer,
          $$UserBiometricsTableCreateCompanionBuilder,
          $$UserBiometricsTableUpdateCompanionBuilder,
          (
            UserBiometricData,
            BaseReferences<
              _$AppDatabase,
              $UserBiometricsTable,
              UserBiometricData
            >,
          ),
          UserBiometricData,
          PrefetchHooks Function()
        > {
  $$UserBiometricsTableTableManager(
    _$AppDatabase db,
    $UserBiometricsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserBiometricsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserBiometricsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserBiometricsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<String?> experienceLevel = const Value.absent(),
                Value<String?> primaryGoal = const Value.absent(),
                Value<String?> equipmentAvailability = const Value.absent(),
                Value<double?> weight = const Value.absent(),
                Value<double?> height = const Value.absent(),
                Value<int?> age = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserBiometricsCompanion(
                userId: userId,
                experienceLevel: experienceLevel,
                primaryGoal: primaryGoal,
                equipmentAvailability: equipmentAvailability,
                weight: weight,
                height: height,
                age: age,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                Value<String?> experienceLevel = const Value.absent(),
                Value<String?> primaryGoal = const Value.absent(),
                Value<String?> equipmentAvailability = const Value.absent(),
                Value<double?> weight = const Value.absent(),
                Value<double?> height = const Value.absent(),
                Value<int?> age = const Value.absent(),
                required String updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => UserBiometricsCompanion.insert(
                userId: userId,
                experienceLevel: experienceLevel,
                primaryGoal: primaryGoal,
                equipmentAvailability: equipmentAvailability,
                weight: weight,
                height: height,
                age: age,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserBiometricsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserBiometricsTable,
      UserBiometricData,
      $$UserBiometricsTableFilterComposer,
      $$UserBiometricsTableOrderingComposer,
      $$UserBiometricsTableAnnotationComposer,
      $$UserBiometricsTableCreateCompanionBuilder,
      $$UserBiometricsTableUpdateCompanionBuilder,
      (
        UserBiometricData,
        BaseReferences<_$AppDatabase, $UserBiometricsTable, UserBiometricData>,
      ),
      UserBiometricData,
      PrefetchHooks Function()
    >;
typedef $$HealthSnapshotsTableCreateCompanionBuilder =
    HealthSnapshotsCompanion Function({
      required String id,
      required String userId,
      Value<double?> hrvMs,
      Value<int?> restingHr,
      Value<double?> sleepScore,
      Value<int?> sleepDurationMinutes,
      required String syncSource,
      required DateTime syncedAt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$HealthSnapshotsTableUpdateCompanionBuilder =
    HealthSnapshotsCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<double?> hrvMs,
      Value<int?> restingHr,
      Value<double?> sleepScore,
      Value<int?> sleepDurationMinutes,
      Value<String> syncSource,
      Value<DateTime> syncedAt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$HealthSnapshotsTableFilterComposer
    extends Composer<_$AppDatabase, $HealthSnapshotsTable> {
  $$HealthSnapshotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hrvMs => $composableBuilder(
    column: $table.hrvMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get restingHr => $composableBuilder(
    column: $table.restingHr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sleepScore => $composableBuilder(
    column: $table.sleepScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sleepDurationMinutes => $composableBuilder(
    column: $table.sleepDurationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncSource => $composableBuilder(
    column: $table.syncSource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HealthSnapshotsTableOrderingComposer
    extends Composer<_$AppDatabase, $HealthSnapshotsTable> {
  $$HealthSnapshotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hrvMs => $composableBuilder(
    column: $table.hrvMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get restingHr => $composableBuilder(
    column: $table.restingHr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sleepScore => $composableBuilder(
    column: $table.sleepScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sleepDurationMinutes => $composableBuilder(
    column: $table.sleepDurationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncSource => $composableBuilder(
    column: $table.syncSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HealthSnapshotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HealthSnapshotsTable> {
  $$HealthSnapshotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<double> get hrvMs =>
      $composableBuilder(column: $table.hrvMs, builder: (column) => column);

  GeneratedColumn<int> get restingHr =>
      $composableBuilder(column: $table.restingHr, builder: (column) => column);

  GeneratedColumn<double> get sleepScore => $composableBuilder(
    column: $table.sleepScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sleepDurationMinutes => $composableBuilder(
    column: $table.sleepDurationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncSource => $composableBuilder(
    column: $table.syncSource,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$HealthSnapshotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HealthSnapshotsTable,
          HealthSnapshotRow,
          $$HealthSnapshotsTableFilterComposer,
          $$HealthSnapshotsTableOrderingComposer,
          $$HealthSnapshotsTableAnnotationComposer,
          $$HealthSnapshotsTableCreateCompanionBuilder,
          $$HealthSnapshotsTableUpdateCompanionBuilder,
          (
            HealthSnapshotRow,
            BaseReferences<
              _$AppDatabase,
              $HealthSnapshotsTable,
              HealthSnapshotRow
            >,
          ),
          HealthSnapshotRow,
          PrefetchHooks Function()
        > {
  $$HealthSnapshotsTableTableManager(
    _$AppDatabase db,
    $HealthSnapshotsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HealthSnapshotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HealthSnapshotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HealthSnapshotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<double?> hrvMs = const Value.absent(),
                Value<int?> restingHr = const Value.absent(),
                Value<double?> sleepScore = const Value.absent(),
                Value<int?> sleepDurationMinutes = const Value.absent(),
                Value<String> syncSource = const Value.absent(),
                Value<DateTime> syncedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HealthSnapshotsCompanion(
                id: id,
                userId: userId,
                hrvMs: hrvMs,
                restingHr: restingHr,
                sleepScore: sleepScore,
                sleepDurationMinutes: sleepDurationMinutes,
                syncSource: syncSource,
                syncedAt: syncedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                Value<double?> hrvMs = const Value.absent(),
                Value<int?> restingHr = const Value.absent(),
                Value<double?> sleepScore = const Value.absent(),
                Value<int?> sleepDurationMinutes = const Value.absent(),
                required String syncSource,
                required DateTime syncedAt,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HealthSnapshotsCompanion.insert(
                id: id,
                userId: userId,
                hrvMs: hrvMs,
                restingHr: restingHr,
                sleepScore: sleepScore,
                sleepDurationMinutes: sleepDurationMinutes,
                syncSource: syncSource,
                syncedAt: syncedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HealthSnapshotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HealthSnapshotsTable,
      HealthSnapshotRow,
      $$HealthSnapshotsTableFilterComposer,
      $$HealthSnapshotsTableOrderingComposer,
      $$HealthSnapshotsTableAnnotationComposer,
      $$HealthSnapshotsTableCreateCompanionBuilder,
      $$HealthSnapshotsTableUpdateCompanionBuilder,
      (
        HealthSnapshotRow,
        BaseReferences<_$AppDatabase, $HealthSnapshotsTable, HealthSnapshotRow>,
      ),
      HealthSnapshotRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MuscleRegionsTableTableManager get muscleRegions =>
      $$MuscleRegionsTableTableManager(_db, _db.muscleRegions);
  $$EquipmentTableTableManager get equipment =>
      $$EquipmentTableTableManager(_db, _db.equipment);
  $$ExercisesTableTableManager get exercises =>
      $$ExercisesTableTableManager(_db, _db.exercises);
  $$ExerciseMusclesTableTableManager get exerciseMuscles =>
      $$ExerciseMusclesTableTableManager(_db, _db.exerciseMuscles);
  $$ExerciseAliasesTableTableManager get exerciseAliases =>
      $$ExerciseAliasesTableTableManager(_db, _db.exerciseAliases);
  $$SubstitutionFeedbackTableTableManager get substitutionFeedback =>
      $$SubstitutionFeedbackTableTableManager(_db, _db.substitutionFeedback);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
  $$UserPreferencesTableTableManager get userPreferences =>
      $$UserPreferencesTableTableManager(_db, _db.userPreferences);
  $$UserMuscleConstraintsTableTableManager get userMuscleConstraints =>
      $$UserMuscleConstraintsTableTableManager(_db, _db.userMuscleConstraints);
  $$WorkoutsTableTableManager get workouts =>
      $$WorkoutsTableTableManager(_db, _db.workouts);
  $$WorkoutExercisesTableTableManager get workoutExercises =>
      $$WorkoutExercisesTableTableManager(_db, _db.workoutExercises);
  $$WorkoutSetsTableTableManager get workoutSets =>
      $$WorkoutSetsTableTableManager(_db, _db.workoutSets);
  $$UserStatsTableTableManager get userStats =>
      $$UserStatsTableTableManager(_db, _db.userStats);
  $$MuscleExperienceTableTableManager get muscleExperience =>
      $$MuscleExperienceTableTableManager(_db, _db.muscleExperience);
  $$MigrationStatusTableTableManager get migrationStatus =>
      $$MigrationStatusTableTableManager(_db, _db.migrationStatus);
  $$UserBiometricsTableTableManager get userBiometrics =>
      $$UserBiometricsTableTableManager(_db, _db.userBiometrics);
  $$HealthSnapshotsTableTableManager get healthSnapshots =>
      $$HealthSnapshotsTableTableManager(_db, _db.healthSnapshots);
}
