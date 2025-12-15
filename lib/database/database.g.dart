// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $MuscleGroupsTable extends MuscleGroups
    with TableInfo<$MuscleGroupsTable, MuscleGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MuscleGroupsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('#FF6B6B'),
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
  List<GeneratedColumn> get $columns => [id, name, color, order, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'muscle_groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<MuscleGroup> instance, {
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
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
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
  MuscleGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MuscleGroup(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MuscleGroupsTable createAlias(String alias) {
    return $MuscleGroupsTable(attachedDatabase, alias);
  }
}

class MuscleGroup extends DataClass implements Insertable<MuscleGroup> {
  final String id;
  final String name;
  final String color;
  final int order;
  final DateTime createdAt;
  const MuscleGroup({
    required this.id,
    required this.name,
    required this.color,
    required this.order,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['color'] = Variable<String>(color);
    map['order'] = Variable<int>(order);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MuscleGroupsCompanion toCompanion(bool nullToAbsent) {
    return MuscleGroupsCompanion(
      id: Value(id),
      name: Value(name),
      color: Value(color),
      order: Value(order),
      createdAt: Value(createdAt),
    );
  }

  factory MuscleGroup.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MuscleGroup(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<String>(json['color']),
      order: serializer.fromJson<int>(json['order']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<String>(color),
      'order': serializer.toJson<int>(order),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MuscleGroup copyWith({
    String? id,
    String? name,
    String? color,
    int? order,
    DateTime? createdAt,
  }) => MuscleGroup(
    id: id ?? this.id,
    name: name ?? this.name,
    color: color ?? this.color,
    order: order ?? this.order,
    createdAt: createdAt ?? this.createdAt,
  );
  MuscleGroup copyWithCompanion(MuscleGroupsCompanion data) {
    return MuscleGroup(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      color: data.color.present ? data.color.value : this.color,
      order: data.order.present ? data.order.value : this.order,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MuscleGroup(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('order: $order, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, color, order, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MuscleGroup &&
          other.id == this.id &&
          other.name == this.name &&
          other.color == this.color &&
          other.order == this.order &&
          other.createdAt == this.createdAt);
}

class MuscleGroupsCompanion extends UpdateCompanion<MuscleGroup> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> color;
  final Value<int> order;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const MuscleGroupsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
    this.order = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MuscleGroupsCompanion.insert({
    required String id,
    required String name,
    this.color = const Value.absent(),
    this.order = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<MuscleGroup> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? color,
    Expression<int>? order,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
      if (order != null) 'order': order,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MuscleGroupsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? color,
    Value<int>? order,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return MuscleGroupsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      order: order ?? this.order,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
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
    return (StringBuffer('MuscleGroupsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('order: $order, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TrainingSessionsTable extends TrainingSessions
    with TableInfo<$TrainingSessionsTable, TrainingSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrainingSessionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  @override
  late final GeneratedColumn<bool> isDone = GeneratedColumn<bool>(
    'is_done',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_done" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    createdAt,
    updatedAt,
    isDone,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'training_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<TrainingSession> instance, {
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
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_done')) {
      context.handle(
        _isDoneMeta,
        isDone.isAcceptableOrUnknown(data['is_done']!, _isDoneMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TrainingSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrainingSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isDone: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_done'],
      )!,
    );
  }

  @override
  $TrainingSessionsTable createAlias(String alias) {
    return $TrainingSessionsTable(attachedDatabase, alias);
  }
}

class TrainingSession extends DataClass implements Insertable<TrainingSession> {
  final String id;
  final String name;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDone;
  const TrainingSession({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.isDone,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_done'] = Variable<bool>(isDone);
    return map;
  }

  TrainingSessionsCompanion toCompanion(bool nullToAbsent) {
    return TrainingSessionsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isDone: Value(isDone),
    );
  }

  factory TrainingSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrainingSession(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isDone: serializer.fromJson<bool>(json['isDone']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isDone': serializer.toJson<bool>(isDone),
    };
  }

  TrainingSession copyWith({
    String? id,
    String? name,
    Value<String?> description = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDone,
  }) => TrainingSession(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isDone: isDone ?? this.isDone,
  );
  TrainingSession copyWithCompanion(TrainingSessionsCompanion data) {
    return TrainingSession(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDone: data.isDone.present ? data.isDone.value : this.isDone,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrainingSession(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDone: $isDone')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, createdAt, updatedAt, isDone);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrainingSession &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isDone == this.isDone);
}

class TrainingSessionsCompanion extends UpdateCompanion<TrainingSession> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isDone;
  final Value<int> rowid;
  const TrainingSessionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDone = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TrainingSessionsCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDone = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<TrainingSession> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDone,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDone != null) 'is_done': isDone,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TrainingSessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isDone,
    Value<int>? rowid,
  }) {
    return TrainingSessionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDone: isDone ?? this.isDone,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDone.present) {
      map['is_done'] = Variable<bool>(isDone.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrainingSessionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDone: $isDone, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SessionMuscleGroupsTable extends SessionMuscleGroups
    with TableInfo<$SessionMuscleGroupsTable, SessionMuscleGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionMuscleGroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES training_sessions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _muscleGroupIdMeta = const VerificationMeta(
    'muscleGroupId',
  );
  @override
  late final GeneratedColumn<String> muscleGroupId = GeneratedColumn<String>(
    'muscle_group_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES muscle_groups (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  @override
  late final GeneratedColumn<bool> isDone = GeneratedColumn<bool>(
    'is_done',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_done" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    muscleGroupId,
    order,
    isDone,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'session_muscle_groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<SessionMuscleGroup> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('muscle_group_id')) {
      context.handle(
        _muscleGroupIdMeta,
        muscleGroupId.isAcceptableOrUnknown(
          data['muscle_group_id']!,
          _muscleGroupIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_muscleGroupIdMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    }
    if (data.containsKey('is_done')) {
      context.handle(
        _isDoneMeta,
        isDone.isAcceptableOrUnknown(data['is_done']!, _isDoneMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SessionMuscleGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionMuscleGroup(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      muscleGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}muscle_group_id'],
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      )!,
      isDone: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_done'],
      )!,
    );
  }

  @override
  $SessionMuscleGroupsTable createAlias(String alias) {
    return $SessionMuscleGroupsTable(attachedDatabase, alias);
  }
}

class SessionMuscleGroup extends DataClass
    implements Insertable<SessionMuscleGroup> {
  final String id;
  final String sessionId;
  final String muscleGroupId;
  final int order;
  final bool isDone;
  const SessionMuscleGroup({
    required this.id,
    required this.sessionId,
    required this.muscleGroupId,
    required this.order,
    required this.isDone,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['muscle_group_id'] = Variable<String>(muscleGroupId);
    map['order'] = Variable<int>(order);
    map['is_done'] = Variable<bool>(isDone);
    return map;
  }

  SessionMuscleGroupsCompanion toCompanion(bool nullToAbsent) {
    return SessionMuscleGroupsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      muscleGroupId: Value(muscleGroupId),
      order: Value(order),
      isDone: Value(isDone),
    );
  }

  factory SessionMuscleGroup.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionMuscleGroup(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      muscleGroupId: serializer.fromJson<String>(json['muscleGroupId']),
      order: serializer.fromJson<int>(json['order']),
      isDone: serializer.fromJson<bool>(json['isDone']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'muscleGroupId': serializer.toJson<String>(muscleGroupId),
      'order': serializer.toJson<int>(order),
      'isDone': serializer.toJson<bool>(isDone),
    };
  }

  SessionMuscleGroup copyWith({
    String? id,
    String? sessionId,
    String? muscleGroupId,
    int? order,
    bool? isDone,
  }) => SessionMuscleGroup(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    muscleGroupId: muscleGroupId ?? this.muscleGroupId,
    order: order ?? this.order,
    isDone: isDone ?? this.isDone,
  );
  SessionMuscleGroup copyWithCompanion(SessionMuscleGroupsCompanion data) {
    return SessionMuscleGroup(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      muscleGroupId: data.muscleGroupId.present
          ? data.muscleGroupId.value
          : this.muscleGroupId,
      order: data.order.present ? data.order.value : this.order,
      isDone: data.isDone.present ? data.isDone.value : this.isDone,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionMuscleGroup(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('muscleGroupId: $muscleGroupId, ')
          ..write('order: $order, ')
          ..write('isDone: $isDone')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionId, muscleGroupId, order, isDone);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionMuscleGroup &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.muscleGroupId == this.muscleGroupId &&
          other.order == this.order &&
          other.isDone == this.isDone);
}

class SessionMuscleGroupsCompanion extends UpdateCompanion<SessionMuscleGroup> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String> muscleGroupId;
  final Value<int> order;
  final Value<bool> isDone;
  final Value<int> rowid;
  const SessionMuscleGroupsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.muscleGroupId = const Value.absent(),
    this.order = const Value.absent(),
    this.isDone = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionMuscleGroupsCompanion.insert({
    required String id,
    required String sessionId,
    required String muscleGroupId,
    this.order = const Value.absent(),
    this.isDone = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sessionId = Value(sessionId),
       muscleGroupId = Value(muscleGroupId);
  static Insertable<SessionMuscleGroup> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? muscleGroupId,
    Expression<int>? order,
    Expression<bool>? isDone,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (muscleGroupId != null) 'muscle_group_id': muscleGroupId,
      if (order != null) 'order': order,
      if (isDone != null) 'is_done': isDone,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionMuscleGroupsCompanion copyWith({
    Value<String>? id,
    Value<String>? sessionId,
    Value<String>? muscleGroupId,
    Value<int>? order,
    Value<bool>? isDone,
    Value<int>? rowid,
  }) {
    return SessionMuscleGroupsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      muscleGroupId: muscleGroupId ?? this.muscleGroupId,
      order: order ?? this.order,
      isDone: isDone ?? this.isDone,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (muscleGroupId.present) {
      map['muscle_group_id'] = Variable<String>(muscleGroupId.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (isDone.present) {
      map['is_done'] = Variable<bool>(isDone.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionMuscleGroupsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('muscleGroupId: $muscleGroupId, ')
          ..write('order: $order, ')
          ..write('isDone: $isDone, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExercisesTable extends Exercises
    with TableInfo<$ExercisesTable, Exercise> {
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
  static const VerificationMeta _sessionMuscleGroupIdMeta =
      const VerificationMeta('sessionMuscleGroupId');
  @override
  late final GeneratedColumn<String> sessionMuscleGroupId =
      GeneratedColumn<String>(
        'session_muscle_group_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES session_muscle_groups (id) ON DELETE CASCADE',
        ),
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
  static const VerificationMeta _plannedSeriesMeta = const VerificationMeta(
    'plannedSeries',
  );
  @override
  late final GeneratedColumn<int> plannedSeries = GeneratedColumn<int>(
    'planned_series',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plannedRepsMeta = const VerificationMeta(
    'plannedReps',
  );
  @override
  late final GeneratedColumn<int> plannedReps = GeneratedColumn<int>(
    'planned_reps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intervalSecondsMeta = const VerificationMeta(
    'intervalSeconds',
  );
  @override
  late final GeneratedColumn<int> intervalSeconds = GeneratedColumn<int>(
    'interval_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(60),
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isUnilateralMeta = const VerificationMeta(
    'isUnilateral',
  );
  @override
  late final GeneratedColumn<bool> isUnilateral = GeneratedColumn<bool>(
    'is_unilateral',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_unilateral" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    sessionMuscleGroupId,
    name,
    plannedSeries,
    plannedReps,
    intervalSeconds,
    order,
    isUnilateral,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<Exercise> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_muscle_group_id')) {
      context.handle(
        _sessionMuscleGroupIdMeta,
        sessionMuscleGroupId.isAcceptableOrUnknown(
          data['session_muscle_group_id']!,
          _sessionMuscleGroupIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sessionMuscleGroupIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('planned_series')) {
      context.handle(
        _plannedSeriesMeta,
        plannedSeries.isAcceptableOrUnknown(
          data['planned_series']!,
          _plannedSeriesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_plannedSeriesMeta);
    }
    if (data.containsKey('planned_reps')) {
      context.handle(
        _plannedRepsMeta,
        plannedReps.isAcceptableOrUnknown(
          data['planned_reps']!,
          _plannedRepsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_plannedRepsMeta);
    }
    if (data.containsKey('interval_seconds')) {
      context.handle(
        _intervalSecondsMeta,
        intervalSeconds.isAcceptableOrUnknown(
          data['interval_seconds']!,
          _intervalSecondsMeta,
        ),
      );
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    }
    if (data.containsKey('is_unilateral')) {
      context.handle(
        _isUnilateralMeta,
        isUnilateral.isAcceptableOrUnknown(
          data['is_unilateral']!,
          _isUnilateralMeta,
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
  Exercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Exercise(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionMuscleGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_muscle_group_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      plannedSeries: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}planned_series'],
      )!,
      plannedReps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}planned_reps'],
      )!,
      intervalSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_seconds'],
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      )!,
      isUnilateral: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_unilateral'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ExercisesTable createAlias(String alias) {
    return $ExercisesTable(attachedDatabase, alias);
  }
}

class Exercise extends DataClass implements Insertable<Exercise> {
  final String id;
  final String sessionMuscleGroupId;
  final String name;
  final int plannedSeries;
  final int plannedReps;
  final int intervalSeconds;
  final int order;
  final bool isUnilateral;
  final DateTime createdAt;
  const Exercise({
    required this.id,
    required this.sessionMuscleGroupId,
    required this.name,
    required this.plannedSeries,
    required this.plannedReps,
    required this.intervalSeconds,
    required this.order,
    required this.isUnilateral,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_muscle_group_id'] = Variable<String>(sessionMuscleGroupId);
    map['name'] = Variable<String>(name);
    map['planned_series'] = Variable<int>(plannedSeries);
    map['planned_reps'] = Variable<int>(plannedReps);
    map['interval_seconds'] = Variable<int>(intervalSeconds);
    map['order'] = Variable<int>(order);
    map['is_unilateral'] = Variable<bool>(isUnilateral);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ExercisesCompanion toCompanion(bool nullToAbsent) {
    return ExercisesCompanion(
      id: Value(id),
      sessionMuscleGroupId: Value(sessionMuscleGroupId),
      name: Value(name),
      plannedSeries: Value(plannedSeries),
      plannedReps: Value(plannedReps),
      intervalSeconds: Value(intervalSeconds),
      order: Value(order),
      isUnilateral: Value(isUnilateral),
      createdAt: Value(createdAt),
    );
  }

  factory Exercise.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Exercise(
      id: serializer.fromJson<String>(json['id']),
      sessionMuscleGroupId: serializer.fromJson<String>(
        json['sessionMuscleGroupId'],
      ),
      name: serializer.fromJson<String>(json['name']),
      plannedSeries: serializer.fromJson<int>(json['plannedSeries']),
      plannedReps: serializer.fromJson<int>(json['plannedReps']),
      intervalSeconds: serializer.fromJson<int>(json['intervalSeconds']),
      order: serializer.fromJson<int>(json['order']),
      isUnilateral: serializer.fromJson<bool>(json['isUnilateral']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionMuscleGroupId': serializer.toJson<String>(sessionMuscleGroupId),
      'name': serializer.toJson<String>(name),
      'plannedSeries': serializer.toJson<int>(plannedSeries),
      'plannedReps': serializer.toJson<int>(plannedReps),
      'intervalSeconds': serializer.toJson<int>(intervalSeconds),
      'order': serializer.toJson<int>(order),
      'isUnilateral': serializer.toJson<bool>(isUnilateral),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Exercise copyWith({
    String? id,
    String? sessionMuscleGroupId,
    String? name,
    int? plannedSeries,
    int? plannedReps,
    int? intervalSeconds,
    int? order,
    bool? isUnilateral,
    DateTime? createdAt,
  }) => Exercise(
    id: id ?? this.id,
    sessionMuscleGroupId: sessionMuscleGroupId ?? this.sessionMuscleGroupId,
    name: name ?? this.name,
    plannedSeries: plannedSeries ?? this.plannedSeries,
    plannedReps: plannedReps ?? this.plannedReps,
    intervalSeconds: intervalSeconds ?? this.intervalSeconds,
    order: order ?? this.order,
    isUnilateral: isUnilateral ?? this.isUnilateral,
    createdAt: createdAt ?? this.createdAt,
  );
  Exercise copyWithCompanion(ExercisesCompanion data) {
    return Exercise(
      id: data.id.present ? data.id.value : this.id,
      sessionMuscleGroupId: data.sessionMuscleGroupId.present
          ? data.sessionMuscleGroupId.value
          : this.sessionMuscleGroupId,
      name: data.name.present ? data.name.value : this.name,
      plannedSeries: data.plannedSeries.present
          ? data.plannedSeries.value
          : this.plannedSeries,
      plannedReps: data.plannedReps.present
          ? data.plannedReps.value
          : this.plannedReps,
      intervalSeconds: data.intervalSeconds.present
          ? data.intervalSeconds.value
          : this.intervalSeconds,
      order: data.order.present ? data.order.value : this.order,
      isUnilateral: data.isUnilateral.present
          ? data.isUnilateral.value
          : this.isUnilateral,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Exercise(')
          ..write('id: $id, ')
          ..write('sessionMuscleGroupId: $sessionMuscleGroupId, ')
          ..write('name: $name, ')
          ..write('plannedSeries: $plannedSeries, ')
          ..write('plannedReps: $plannedReps, ')
          ..write('intervalSeconds: $intervalSeconds, ')
          ..write('order: $order, ')
          ..write('isUnilateral: $isUnilateral, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionMuscleGroupId,
    name,
    plannedSeries,
    plannedReps,
    intervalSeconds,
    order,
    isUnilateral,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Exercise &&
          other.id == this.id &&
          other.sessionMuscleGroupId == this.sessionMuscleGroupId &&
          other.name == this.name &&
          other.plannedSeries == this.plannedSeries &&
          other.plannedReps == this.plannedReps &&
          other.intervalSeconds == this.intervalSeconds &&
          other.order == this.order &&
          other.isUnilateral == this.isUnilateral &&
          other.createdAt == this.createdAt);
}

class ExercisesCompanion extends UpdateCompanion<Exercise> {
  final Value<String> id;
  final Value<String> sessionMuscleGroupId;
  final Value<String> name;
  final Value<int> plannedSeries;
  final Value<int> plannedReps;
  final Value<int> intervalSeconds;
  final Value<int> order;
  final Value<bool> isUnilateral;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ExercisesCompanion({
    this.id = const Value.absent(),
    this.sessionMuscleGroupId = const Value.absent(),
    this.name = const Value.absent(),
    this.plannedSeries = const Value.absent(),
    this.plannedReps = const Value.absent(),
    this.intervalSeconds = const Value.absent(),
    this.order = const Value.absent(),
    this.isUnilateral = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExercisesCompanion.insert({
    required String id,
    required String sessionMuscleGroupId,
    required String name,
    required int plannedSeries,
    required int plannedReps,
    this.intervalSeconds = const Value.absent(),
    this.order = const Value.absent(),
    this.isUnilateral = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sessionMuscleGroupId = Value(sessionMuscleGroupId),
       name = Value(name),
       plannedSeries = Value(plannedSeries),
       plannedReps = Value(plannedReps);
  static Insertable<Exercise> custom({
    Expression<String>? id,
    Expression<String>? sessionMuscleGroupId,
    Expression<String>? name,
    Expression<int>? plannedSeries,
    Expression<int>? plannedReps,
    Expression<int>? intervalSeconds,
    Expression<int>? order,
    Expression<bool>? isUnilateral,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionMuscleGroupId != null)
        'session_muscle_group_id': sessionMuscleGroupId,
      if (name != null) 'name': name,
      if (plannedSeries != null) 'planned_series': plannedSeries,
      if (plannedReps != null) 'planned_reps': plannedReps,
      if (intervalSeconds != null) 'interval_seconds': intervalSeconds,
      if (order != null) 'order': order,
      if (isUnilateral != null) 'is_unilateral': isUnilateral,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExercisesCompanion copyWith({
    Value<String>? id,
    Value<String>? sessionMuscleGroupId,
    Value<String>? name,
    Value<int>? plannedSeries,
    Value<int>? plannedReps,
    Value<int>? intervalSeconds,
    Value<int>? order,
    Value<bool>? isUnilateral,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ExercisesCompanion(
      id: id ?? this.id,
      sessionMuscleGroupId: sessionMuscleGroupId ?? this.sessionMuscleGroupId,
      name: name ?? this.name,
      plannedSeries: plannedSeries ?? this.plannedSeries,
      plannedReps: plannedReps ?? this.plannedReps,
      intervalSeconds: intervalSeconds ?? this.intervalSeconds,
      order: order ?? this.order,
      isUnilateral: isUnilateral ?? this.isUnilateral,
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
    if (sessionMuscleGroupId.present) {
      map['session_muscle_group_id'] = Variable<String>(
        sessionMuscleGroupId.value,
      );
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (plannedSeries.present) {
      map['planned_series'] = Variable<int>(plannedSeries.value);
    }
    if (plannedReps.present) {
      map['planned_reps'] = Variable<int>(plannedReps.value);
    }
    if (intervalSeconds.present) {
      map['interval_seconds'] = Variable<int>(intervalSeconds.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (isUnilateral.present) {
      map['is_unilateral'] = Variable<bool>(isUnilateral.value);
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
    return (StringBuffer('ExercisesCompanion(')
          ..write('id: $id, ')
          ..write('sessionMuscleGroupId: $sessionMuscleGroupId, ')
          ..write('name: $name, ')
          ..write('plannedSeries: $plannedSeries, ')
          ..write('plannedReps: $plannedReps, ')
          ..write('intervalSeconds: $intervalSeconds, ')
          ..write('order: $order, ')
          ..write('isUnilateral: $isUnilateral, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExerciseSeriesListTable extends ExerciseSeriesList
    with TableInfo<$ExerciseSeriesListTable, ExerciseSeries> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseSeriesListTable(this.attachedDatabase, [this._alias]);
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
      'REFERENCES exercises (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _seriesNumberMeta = const VerificationMeta(
    'seriesNumber',
  );
  @override
  late final GeneratedColumn<int> seriesNumber = GeneratedColumn<int>(
    'series_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actualRepsMeta = const VerificationMeta(
    'actualReps',
  );
  @override
  late final GeneratedColumn<int> actualReps = GeneratedColumn<int>(
    'actual_reps',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
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
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _feedbackMeta = const VerificationMeta(
    'feedback',
  );
  @override
  late final GeneratedColumn<String> feedback = GeneratedColumn<String>(
    'feedback',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    exerciseId,
    seriesNumber,
    actualReps,
    weightKg,
    completedAt,
    isCompleted,
    feedback,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_series_list';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseSeries> instance, {
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
    if (data.containsKey('series_number')) {
      context.handle(
        _seriesNumberMeta,
        seriesNumber.isAcceptableOrUnknown(
          data['series_number']!,
          _seriesNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_seriesNumberMeta);
    }
    if (data.containsKey('actual_reps')) {
      context.handle(
        _actualRepsMeta,
        actualReps.isAcceptableOrUnknown(data['actual_reps']!, _actualRepsMeta),
      );
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
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
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('feedback')) {
      context.handle(
        _feedbackMeta,
        feedback.isAcceptableOrUnknown(data['feedback']!, _feedbackMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseSeries map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseSeries(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      seriesNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}series_number'],
      )!,
      actualReps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}actual_reps'],
      ),
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      feedback: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}feedback'],
      ),
    );
  }

  @override
  $ExerciseSeriesListTable createAlias(String alias) {
    return $ExerciseSeriesListTable(attachedDatabase, alias);
  }
}

class ExerciseSeries extends DataClass implements Insertable<ExerciseSeries> {
  final String id;
  final String exerciseId;
  final int seriesNumber;
  final int? actualReps;
  final double? weightKg;
  final DateTime? completedAt;
  final bool isCompleted;
  final String? feedback;
  const ExerciseSeries({
    required this.id,
    required this.exerciseId,
    required this.seriesNumber,
    this.actualReps,
    this.weightKg,
    this.completedAt,
    required this.isCompleted,
    this.feedback,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['series_number'] = Variable<int>(seriesNumber);
    if (!nullToAbsent || actualReps != null) {
      map['actual_reps'] = Variable<int>(actualReps);
    }
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || feedback != null) {
      map['feedback'] = Variable<String>(feedback);
    }
    return map;
  }

  ExerciseSeriesListCompanion toCompanion(bool nullToAbsent) {
    return ExerciseSeriesListCompanion(
      id: Value(id),
      exerciseId: Value(exerciseId),
      seriesNumber: Value(seriesNumber),
      actualReps: actualReps == null && nullToAbsent
          ? const Value.absent()
          : Value(actualReps),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      isCompleted: Value(isCompleted),
      feedback: feedback == null && nullToAbsent
          ? const Value.absent()
          : Value(feedback),
    );
  }

  factory ExerciseSeries.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseSeries(
      id: serializer.fromJson<String>(json['id']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      seriesNumber: serializer.fromJson<int>(json['seriesNumber']),
      actualReps: serializer.fromJson<int?>(json['actualReps']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      feedback: serializer.fromJson<String?>(json['feedback']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'seriesNumber': serializer.toJson<int>(seriesNumber),
      'actualReps': serializer.toJson<int?>(actualReps),
      'weightKg': serializer.toJson<double?>(weightKg),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'feedback': serializer.toJson<String?>(feedback),
    };
  }

  ExerciseSeries copyWith({
    String? id,
    String? exerciseId,
    int? seriesNumber,
    Value<int?> actualReps = const Value.absent(),
    Value<double?> weightKg = const Value.absent(),
    Value<DateTime?> completedAt = const Value.absent(),
    bool? isCompleted,
    Value<String?> feedback = const Value.absent(),
  }) => ExerciseSeries(
    id: id ?? this.id,
    exerciseId: exerciseId ?? this.exerciseId,
    seriesNumber: seriesNumber ?? this.seriesNumber,
    actualReps: actualReps.present ? actualReps.value : this.actualReps,
    weightKg: weightKg.present ? weightKg.value : this.weightKg,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    isCompleted: isCompleted ?? this.isCompleted,
    feedback: feedback.present ? feedback.value : this.feedback,
  );
  ExerciseSeries copyWithCompanion(ExerciseSeriesListCompanion data) {
    return ExerciseSeries(
      id: data.id.present ? data.id.value : this.id,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      seriesNumber: data.seriesNumber.present
          ? data.seriesNumber.value
          : this.seriesNumber,
      actualReps: data.actualReps.present
          ? data.actualReps.value
          : this.actualReps,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      feedback: data.feedback.present ? data.feedback.value : this.feedback,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseSeries(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('seriesNumber: $seriesNumber, ')
          ..write('actualReps: $actualReps, ')
          ..write('weightKg: $weightKg, ')
          ..write('completedAt: $completedAt, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('feedback: $feedback')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    exerciseId,
    seriesNumber,
    actualReps,
    weightKg,
    completedAt,
    isCompleted,
    feedback,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseSeries &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.seriesNumber == this.seriesNumber &&
          other.actualReps == this.actualReps &&
          other.weightKg == this.weightKg &&
          other.completedAt == this.completedAt &&
          other.isCompleted == this.isCompleted &&
          other.feedback == this.feedback);
}

class ExerciseSeriesListCompanion extends UpdateCompanion<ExerciseSeries> {
  final Value<String> id;
  final Value<String> exerciseId;
  final Value<int> seriesNumber;
  final Value<int?> actualReps;
  final Value<double?> weightKg;
  final Value<DateTime?> completedAt;
  final Value<bool> isCompleted;
  final Value<String?> feedback;
  final Value<int> rowid;
  const ExerciseSeriesListCompanion({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.seriesNumber = const Value.absent(),
    this.actualReps = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.feedback = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExerciseSeriesListCompanion.insert({
    required String id,
    required String exerciseId,
    required int seriesNumber,
    this.actualReps = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.feedback = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       exerciseId = Value(exerciseId),
       seriesNumber = Value(seriesNumber);
  static Insertable<ExerciseSeries> custom({
    Expression<String>? id,
    Expression<String>? exerciseId,
    Expression<int>? seriesNumber,
    Expression<int>? actualReps,
    Expression<double>? weightKg,
    Expression<DateTime>? completedAt,
    Expression<bool>? isCompleted,
    Expression<String>? feedback,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (seriesNumber != null) 'series_number': seriesNumber,
      if (actualReps != null) 'actual_reps': actualReps,
      if (weightKg != null) 'weight_kg': weightKg,
      if (completedAt != null) 'completed_at': completedAt,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (feedback != null) 'feedback': feedback,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExerciseSeriesListCompanion copyWith({
    Value<String>? id,
    Value<String>? exerciseId,
    Value<int>? seriesNumber,
    Value<int?>? actualReps,
    Value<double?>? weightKg,
    Value<DateTime?>? completedAt,
    Value<bool>? isCompleted,
    Value<String?>? feedback,
    Value<int>? rowid,
  }) {
    return ExerciseSeriesListCompanion(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      seriesNumber: seriesNumber ?? this.seriesNumber,
      actualReps: actualReps ?? this.actualReps,
      weightKg: weightKg ?? this.weightKg,
      completedAt: completedAt ?? this.completedAt,
      isCompleted: isCompleted ?? this.isCompleted,
      feedback: feedback ?? this.feedback,
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
    if (seriesNumber.present) {
      map['series_number'] = Variable<int>(seriesNumber.value);
    }
    if (actualReps.present) {
      map['actual_reps'] = Variable<int>(actualReps.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (feedback.present) {
      map['feedback'] = Variable<String>(feedback.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseSeriesListCompanion(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('seriesNumber: $seriesNumber, ')
          ..write('actualReps: $actualReps, ')
          ..write('weightKg: $weightKg, ')
          ..write('completedAt: $completedAt, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('feedback: $feedback, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutSessionsTable extends WorkoutSessions
    with TableInfo<$WorkoutSessionsTable, WorkoutSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _trainingSessionIdMeta = const VerificationMeta(
    'trainingSessionId',
  );
  @override
  late final GeneratedColumn<String> trainingSessionId =
      GeneratedColumn<String>(
        'training_session_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES training_sessions (id) ON DELETE CASCADE',
        ),
      );
  static const VerificationMeta _sessionMuscleGroupIdMeta =
      const VerificationMeta('sessionMuscleGroupId');
  @override
  late final GeneratedColumn<String> sessionMuscleGroupId =
      GeneratedColumn<String>(
        'session_muscle_group_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES session_muscle_groups (id) ON DELETE CASCADE',
        ),
      );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    trainingSessionId,
    sessionMuscleGroupId,
    startedAt,
    completedAt,
    isCompleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('training_session_id')) {
      context.handle(
        _trainingSessionIdMeta,
        trainingSessionId.isAcceptableOrUnknown(
          data['training_session_id']!,
          _trainingSessionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_trainingSessionIdMeta);
    }
    if (data.containsKey('session_muscle_group_id')) {
      context.handle(
        _sessionMuscleGroupIdMeta,
        sessionMuscleGroupId.isAcceptableOrUnknown(
          data['session_muscle_group_id']!,
          _sessionMuscleGroupIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sessionMuscleGroupIdMeta);
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
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      trainingSessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}training_session_id'],
      )!,
      sessionMuscleGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_muscle_group_id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
    );
  }

  @override
  $WorkoutSessionsTable createAlias(String alias) {
    return $WorkoutSessionsTable(attachedDatabase, alias);
  }
}

class WorkoutSession extends DataClass implements Insertable<WorkoutSession> {
  final String id;
  final String trainingSessionId;
  final String sessionMuscleGroupId;
  final DateTime startedAt;
  final DateTime? completedAt;
  final bool isCompleted;
  const WorkoutSession({
    required this.id,
    required this.trainingSessionId,
    required this.sessionMuscleGroupId,
    required this.startedAt,
    this.completedAt,
    required this.isCompleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['training_session_id'] = Variable<String>(trainingSessionId);
    map['session_muscle_group_id'] = Variable<String>(sessionMuscleGroupId);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['is_completed'] = Variable<bool>(isCompleted);
    return map;
  }

  WorkoutSessionsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutSessionsCompanion(
      id: Value(id),
      trainingSessionId: Value(trainingSessionId),
      sessionMuscleGroupId: Value(sessionMuscleGroupId),
      startedAt: Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      isCompleted: Value(isCompleted),
    );
  }

  factory WorkoutSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutSession(
      id: serializer.fromJson<String>(json['id']),
      trainingSessionId: serializer.fromJson<String>(json['trainingSessionId']),
      sessionMuscleGroupId: serializer.fromJson<String>(
        json['sessionMuscleGroupId'],
      ),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'trainingSessionId': serializer.toJson<String>(trainingSessionId),
      'sessionMuscleGroupId': serializer.toJson<String>(sessionMuscleGroupId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'isCompleted': serializer.toJson<bool>(isCompleted),
    };
  }

  WorkoutSession copyWith({
    String? id,
    String? trainingSessionId,
    String? sessionMuscleGroupId,
    DateTime? startedAt,
    Value<DateTime?> completedAt = const Value.absent(),
    bool? isCompleted,
  }) => WorkoutSession(
    id: id ?? this.id,
    trainingSessionId: trainingSessionId ?? this.trainingSessionId,
    sessionMuscleGroupId: sessionMuscleGroupId ?? this.sessionMuscleGroupId,
    startedAt: startedAt ?? this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    isCompleted: isCompleted ?? this.isCompleted,
  );
  WorkoutSession copyWithCompanion(WorkoutSessionsCompanion data) {
    return WorkoutSession(
      id: data.id.present ? data.id.value : this.id,
      trainingSessionId: data.trainingSessionId.present
          ? data.trainingSessionId.value
          : this.trainingSessionId,
      sessionMuscleGroupId: data.sessionMuscleGroupId.present
          ? data.sessionMuscleGroupId.value
          : this.sessionMuscleGroupId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSession(')
          ..write('id: $id, ')
          ..write('trainingSessionId: $trainingSessionId, ')
          ..write('sessionMuscleGroupId: $sessionMuscleGroupId, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    trainingSessionId,
    sessionMuscleGroupId,
    startedAt,
    completedAt,
    isCompleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutSession &&
          other.id == this.id &&
          other.trainingSessionId == this.trainingSessionId &&
          other.sessionMuscleGroupId == this.sessionMuscleGroupId &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.isCompleted == this.isCompleted);
}

class WorkoutSessionsCompanion extends UpdateCompanion<WorkoutSession> {
  final Value<String> id;
  final Value<String> trainingSessionId;
  final Value<String> sessionMuscleGroupId;
  final Value<DateTime> startedAt;
  final Value<DateTime?> completedAt;
  final Value<bool> isCompleted;
  final Value<int> rowid;
  const WorkoutSessionsCompanion({
    this.id = const Value.absent(),
    this.trainingSessionId = const Value.absent(),
    this.sessionMuscleGroupId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutSessionsCompanion.insert({
    required String id,
    required String trainingSessionId,
    required String sessionMuscleGroupId,
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       trainingSessionId = Value(trainingSessionId),
       sessionMuscleGroupId = Value(sessionMuscleGroupId);
  static Insertable<WorkoutSession> custom({
    Expression<String>? id,
    Expression<String>? trainingSessionId,
    Expression<String>? sessionMuscleGroupId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<bool>? isCompleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (trainingSessionId != null) 'training_session_id': trainingSessionId,
      if (sessionMuscleGroupId != null)
        'session_muscle_group_id': sessionMuscleGroupId,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutSessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? trainingSessionId,
    Value<String>? sessionMuscleGroupId,
    Value<DateTime>? startedAt,
    Value<DateTime?>? completedAt,
    Value<bool>? isCompleted,
    Value<int>? rowid,
  }) {
    return WorkoutSessionsCompanion(
      id: id ?? this.id,
      trainingSessionId: trainingSessionId ?? this.trainingSessionId,
      sessionMuscleGroupId: sessionMuscleGroupId ?? this.sessionMuscleGroupId,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      isCompleted: isCompleted ?? this.isCompleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (trainingSessionId.present) {
      map['training_session_id'] = Variable<String>(trainingSessionId.value);
    }
    if (sessionMuscleGroupId.present) {
      map['session_muscle_group_id'] = Variable<String>(
        sessionMuscleGroupId.value,
      );
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSessionsCompanion(')
          ..write('id: $id, ')
          ..write('trainingSessionId: $trainingSessionId, ')
          ..write('sessionMuscleGroupId: $sessionMuscleGroupId, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutHistoriesTable extends WorkoutHistories
    with TableInfo<$WorkoutHistoriesTable, WorkoutHistory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutHistoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workoutSessionIdMeta = const VerificationMeta(
    'workoutSessionId',
  );
  @override
  late final GeneratedColumn<String> workoutSessionId = GeneratedColumn<String>(
    'workout_session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workout_sessions (id) ON DELETE CASCADE',
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
      'REFERENCES exercises (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _completedSeriesMeta = const VerificationMeta(
    'completedSeries',
  );
  @override
  late final GeneratedColumn<int> completedSeries = GeneratedColumn<int>(
    'completed_series',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxWeightKgMeta = const VerificationMeta(
    'maxWeightKg',
  );
  @override
  late final GeneratedColumn<double> maxWeightKg = GeneratedColumn<double>(
    'max_weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalVolumeLoadMeta = const VerificationMeta(
    'totalVolumeLoad',
  );
  @override
  late final GeneratedColumn<double> totalVolumeLoad = GeneratedColumn<double>(
    'total_volume_load',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    workoutSessionId,
    exerciseId,
    completedSeries,
    maxWeightKg,
    totalVolumeLoad,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_histories';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutHistory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workout_session_id')) {
      context.handle(
        _workoutSessionIdMeta,
        workoutSessionId.isAcceptableOrUnknown(
          data['workout_session_id']!,
          _workoutSessionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workoutSessionIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('completed_series')) {
      context.handle(
        _completedSeriesMeta,
        completedSeries.isAcceptableOrUnknown(
          data['completed_series']!,
          _completedSeriesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedSeriesMeta);
    }
    if (data.containsKey('max_weight_kg')) {
      context.handle(
        _maxWeightKgMeta,
        maxWeightKg.isAcceptableOrUnknown(
          data['max_weight_kg']!,
          _maxWeightKgMeta,
        ),
      );
    }
    if (data.containsKey('total_volume_load')) {
      context.handle(
        _totalVolumeLoadMeta,
        totalVolumeLoad.isAcceptableOrUnknown(
          data['total_volume_load']!,
          _totalVolumeLoadMeta,
        ),
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutHistory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutHistory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      workoutSessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workout_session_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      completedSeries: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed_series'],
      )!,
      maxWeightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_weight_kg'],
      ),
      totalVolumeLoad: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_volume_load'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      )!,
    );
  }

  @override
  $WorkoutHistoriesTable createAlias(String alias) {
    return $WorkoutHistoriesTable(attachedDatabase, alias);
  }
}

class WorkoutHistory extends DataClass implements Insertable<WorkoutHistory> {
  final String id;
  final String workoutSessionId;
  final String exerciseId;
  final int completedSeries;
  final double? maxWeightKg;
  final double totalVolumeLoad;
  final DateTime completedAt;
  const WorkoutHistory({
    required this.id,
    required this.workoutSessionId,
    required this.exerciseId,
    required this.completedSeries,
    this.maxWeightKg,
    required this.totalVolumeLoad,
    required this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workout_session_id'] = Variable<String>(workoutSessionId);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['completed_series'] = Variable<int>(completedSeries);
    if (!nullToAbsent || maxWeightKg != null) {
      map['max_weight_kg'] = Variable<double>(maxWeightKg);
    }
    map['total_volume_load'] = Variable<double>(totalVolumeLoad);
    map['completed_at'] = Variable<DateTime>(completedAt);
    return map;
  }

  WorkoutHistoriesCompanion toCompanion(bool nullToAbsent) {
    return WorkoutHistoriesCompanion(
      id: Value(id),
      workoutSessionId: Value(workoutSessionId),
      exerciseId: Value(exerciseId),
      completedSeries: Value(completedSeries),
      maxWeightKg: maxWeightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(maxWeightKg),
      totalVolumeLoad: Value(totalVolumeLoad),
      completedAt: Value(completedAt),
    );
  }

  factory WorkoutHistory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutHistory(
      id: serializer.fromJson<String>(json['id']),
      workoutSessionId: serializer.fromJson<String>(json['workoutSessionId']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      completedSeries: serializer.fromJson<int>(json['completedSeries']),
      maxWeightKg: serializer.fromJson<double?>(json['maxWeightKg']),
      totalVolumeLoad: serializer.fromJson<double>(json['totalVolumeLoad']),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workoutSessionId': serializer.toJson<String>(workoutSessionId),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'completedSeries': serializer.toJson<int>(completedSeries),
      'maxWeightKg': serializer.toJson<double?>(maxWeightKg),
      'totalVolumeLoad': serializer.toJson<double>(totalVolumeLoad),
      'completedAt': serializer.toJson<DateTime>(completedAt),
    };
  }

  WorkoutHistory copyWith({
    String? id,
    String? workoutSessionId,
    String? exerciseId,
    int? completedSeries,
    Value<double?> maxWeightKg = const Value.absent(),
    double? totalVolumeLoad,
    DateTime? completedAt,
  }) => WorkoutHistory(
    id: id ?? this.id,
    workoutSessionId: workoutSessionId ?? this.workoutSessionId,
    exerciseId: exerciseId ?? this.exerciseId,
    completedSeries: completedSeries ?? this.completedSeries,
    maxWeightKg: maxWeightKg.present ? maxWeightKg.value : this.maxWeightKg,
    totalVolumeLoad: totalVolumeLoad ?? this.totalVolumeLoad,
    completedAt: completedAt ?? this.completedAt,
  );
  WorkoutHistory copyWithCompanion(WorkoutHistoriesCompanion data) {
    return WorkoutHistory(
      id: data.id.present ? data.id.value : this.id,
      workoutSessionId: data.workoutSessionId.present
          ? data.workoutSessionId.value
          : this.workoutSessionId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      completedSeries: data.completedSeries.present
          ? data.completedSeries.value
          : this.completedSeries,
      maxWeightKg: data.maxWeightKg.present
          ? data.maxWeightKg.value
          : this.maxWeightKg,
      totalVolumeLoad: data.totalVolumeLoad.present
          ? data.totalVolumeLoad.value
          : this.totalVolumeLoad,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutHistory(')
          ..write('id: $id, ')
          ..write('workoutSessionId: $workoutSessionId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('completedSeries: $completedSeries, ')
          ..write('maxWeightKg: $maxWeightKg, ')
          ..write('totalVolumeLoad: $totalVolumeLoad, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    workoutSessionId,
    exerciseId,
    completedSeries,
    maxWeightKg,
    totalVolumeLoad,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutHistory &&
          other.id == this.id &&
          other.workoutSessionId == this.workoutSessionId &&
          other.exerciseId == this.exerciseId &&
          other.completedSeries == this.completedSeries &&
          other.maxWeightKg == this.maxWeightKg &&
          other.totalVolumeLoad == this.totalVolumeLoad &&
          other.completedAt == this.completedAt);
}

class WorkoutHistoriesCompanion extends UpdateCompanion<WorkoutHistory> {
  final Value<String> id;
  final Value<String> workoutSessionId;
  final Value<String> exerciseId;
  final Value<int> completedSeries;
  final Value<double?> maxWeightKg;
  final Value<double> totalVolumeLoad;
  final Value<DateTime> completedAt;
  final Value<int> rowid;
  const WorkoutHistoriesCompanion({
    this.id = const Value.absent(),
    this.workoutSessionId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.completedSeries = const Value.absent(),
    this.maxWeightKg = const Value.absent(),
    this.totalVolumeLoad = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutHistoriesCompanion.insert({
    required String id,
    required String workoutSessionId,
    required String exerciseId,
    required int completedSeries,
    this.maxWeightKg = const Value.absent(),
    this.totalVolumeLoad = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       workoutSessionId = Value(workoutSessionId),
       exerciseId = Value(exerciseId),
       completedSeries = Value(completedSeries);
  static Insertable<WorkoutHistory> custom({
    Expression<String>? id,
    Expression<String>? workoutSessionId,
    Expression<String>? exerciseId,
    Expression<int>? completedSeries,
    Expression<double>? maxWeightKg,
    Expression<double>? totalVolumeLoad,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workoutSessionId != null) 'workout_session_id': workoutSessionId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (completedSeries != null) 'completed_series': completedSeries,
      if (maxWeightKg != null) 'max_weight_kg': maxWeightKg,
      if (totalVolumeLoad != null) 'total_volume_load': totalVolumeLoad,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutHistoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? workoutSessionId,
    Value<String>? exerciseId,
    Value<int>? completedSeries,
    Value<double?>? maxWeightKg,
    Value<double>? totalVolumeLoad,
    Value<DateTime>? completedAt,
    Value<int>? rowid,
  }) {
    return WorkoutHistoriesCompanion(
      id: id ?? this.id,
      workoutSessionId: workoutSessionId ?? this.workoutSessionId,
      exerciseId: exerciseId ?? this.exerciseId,
      completedSeries: completedSeries ?? this.completedSeries,
      maxWeightKg: maxWeightKg ?? this.maxWeightKg,
      totalVolumeLoad: totalVolumeLoad ?? this.totalVolumeLoad,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workoutSessionId.present) {
      map['workout_session_id'] = Variable<String>(workoutSessionId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (completedSeries.present) {
      map['completed_series'] = Variable<int>(completedSeries.value);
    }
    if (maxWeightKg.present) {
      map['max_weight_kg'] = Variable<double>(maxWeightKg.value);
    }
    if (totalVolumeLoad.present) {
      map['total_volume_load'] = Variable<double>(totalVolumeLoad.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutHistoriesCompanion(')
          ..write('id: $id, ')
          ..write('workoutSessionId: $workoutSessionId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('completedSeries: $completedSeries, ')
          ..write('maxWeightKg: $maxWeightKg, ')
          ..write('totalVolumeLoad: $totalVolumeLoad, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MuscleRecoveriesTable extends MuscleRecoveries
    with TableInfo<$MuscleRecoveriesTable, MuscleRecovery> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MuscleRecoveriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _muscleGroupIdMeta = const VerificationMeta(
    'muscleGroupId',
  );
  @override
  late final GeneratedColumn<String> muscleGroupId = GeneratedColumn<String>(
    'muscle_group_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES muscle_groups (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _isRecoveredMeta = const VerificationMeta(
    'isRecovered',
  );
  @override
  late final GeneratedColumn<bool> isRecovered = GeneratedColumn<bool>(
    'is_recovered',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_recovered" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
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
  static const VerificationMeta _recoveredAtMeta = const VerificationMeta(
    'recoveredAt',
  );
  @override
  late final GeneratedColumn<DateTime> recoveredAt = GeneratedColumn<DateTime>(
    'recovered_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    muscleGroupId,
    isRecovered,
    lastWorkoutDate,
    recoveredAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'muscle_recoveries';
  @override
  VerificationContext validateIntegrity(
    Insertable<MuscleRecovery> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('muscle_group_id')) {
      context.handle(
        _muscleGroupIdMeta,
        muscleGroupId.isAcceptableOrUnknown(
          data['muscle_group_id']!,
          _muscleGroupIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_muscleGroupIdMeta);
    }
    if (data.containsKey('is_recovered')) {
      context.handle(
        _isRecoveredMeta,
        isRecovered.isAcceptableOrUnknown(
          data['is_recovered']!,
          _isRecoveredMeta,
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
    if (data.containsKey('recovered_at')) {
      context.handle(
        _recoveredAtMeta,
        recoveredAt.isAcceptableOrUnknown(
          data['recovered_at']!,
          _recoveredAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MuscleRecovery map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MuscleRecovery(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      muscleGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}muscle_group_id'],
      )!,
      isRecovered: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_recovered'],
      )!,
      lastWorkoutDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_workout_date'],
      ),
      recoveredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}recovered_at'],
      ),
    );
  }

  @override
  $MuscleRecoveriesTable createAlias(String alias) {
    return $MuscleRecoveriesTable(attachedDatabase, alias);
  }
}

class MuscleRecovery extends DataClass implements Insertable<MuscleRecovery> {
  final String id;
  final String muscleGroupId;
  final bool isRecovered;
  final DateTime? lastWorkoutDate;
  final DateTime? recoveredAt;
  const MuscleRecovery({
    required this.id,
    required this.muscleGroupId,
    required this.isRecovered,
    this.lastWorkoutDate,
    this.recoveredAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['muscle_group_id'] = Variable<String>(muscleGroupId);
    map['is_recovered'] = Variable<bool>(isRecovered);
    if (!nullToAbsent || lastWorkoutDate != null) {
      map['last_workout_date'] = Variable<DateTime>(lastWorkoutDate);
    }
    if (!nullToAbsent || recoveredAt != null) {
      map['recovered_at'] = Variable<DateTime>(recoveredAt);
    }
    return map;
  }

  MuscleRecoveriesCompanion toCompanion(bool nullToAbsent) {
    return MuscleRecoveriesCompanion(
      id: Value(id),
      muscleGroupId: Value(muscleGroupId),
      isRecovered: Value(isRecovered),
      lastWorkoutDate: lastWorkoutDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastWorkoutDate),
      recoveredAt: recoveredAt == null && nullToAbsent
          ? const Value.absent()
          : Value(recoveredAt),
    );
  }

  factory MuscleRecovery.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MuscleRecovery(
      id: serializer.fromJson<String>(json['id']),
      muscleGroupId: serializer.fromJson<String>(json['muscleGroupId']),
      isRecovered: serializer.fromJson<bool>(json['isRecovered']),
      lastWorkoutDate: serializer.fromJson<DateTime?>(json['lastWorkoutDate']),
      recoveredAt: serializer.fromJson<DateTime?>(json['recoveredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'muscleGroupId': serializer.toJson<String>(muscleGroupId),
      'isRecovered': serializer.toJson<bool>(isRecovered),
      'lastWorkoutDate': serializer.toJson<DateTime?>(lastWorkoutDate),
      'recoveredAt': serializer.toJson<DateTime?>(recoveredAt),
    };
  }

  MuscleRecovery copyWith({
    String? id,
    String? muscleGroupId,
    bool? isRecovered,
    Value<DateTime?> lastWorkoutDate = const Value.absent(),
    Value<DateTime?> recoveredAt = const Value.absent(),
  }) => MuscleRecovery(
    id: id ?? this.id,
    muscleGroupId: muscleGroupId ?? this.muscleGroupId,
    isRecovered: isRecovered ?? this.isRecovered,
    lastWorkoutDate: lastWorkoutDate.present
        ? lastWorkoutDate.value
        : this.lastWorkoutDate,
    recoveredAt: recoveredAt.present ? recoveredAt.value : this.recoveredAt,
  );
  MuscleRecovery copyWithCompanion(MuscleRecoveriesCompanion data) {
    return MuscleRecovery(
      id: data.id.present ? data.id.value : this.id,
      muscleGroupId: data.muscleGroupId.present
          ? data.muscleGroupId.value
          : this.muscleGroupId,
      isRecovered: data.isRecovered.present
          ? data.isRecovered.value
          : this.isRecovered,
      lastWorkoutDate: data.lastWorkoutDate.present
          ? data.lastWorkoutDate.value
          : this.lastWorkoutDate,
      recoveredAt: data.recoveredAt.present
          ? data.recoveredAt.value
          : this.recoveredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MuscleRecovery(')
          ..write('id: $id, ')
          ..write('muscleGroupId: $muscleGroupId, ')
          ..write('isRecovered: $isRecovered, ')
          ..write('lastWorkoutDate: $lastWorkoutDate, ')
          ..write('recoveredAt: $recoveredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, muscleGroupId, isRecovered, lastWorkoutDate, recoveredAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MuscleRecovery &&
          other.id == this.id &&
          other.muscleGroupId == this.muscleGroupId &&
          other.isRecovered == this.isRecovered &&
          other.lastWorkoutDate == this.lastWorkoutDate &&
          other.recoveredAt == this.recoveredAt);
}

class MuscleRecoveriesCompanion extends UpdateCompanion<MuscleRecovery> {
  final Value<String> id;
  final Value<String> muscleGroupId;
  final Value<bool> isRecovered;
  final Value<DateTime?> lastWorkoutDate;
  final Value<DateTime?> recoveredAt;
  final Value<int> rowid;
  const MuscleRecoveriesCompanion({
    this.id = const Value.absent(),
    this.muscleGroupId = const Value.absent(),
    this.isRecovered = const Value.absent(),
    this.lastWorkoutDate = const Value.absent(),
    this.recoveredAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MuscleRecoveriesCompanion.insert({
    required String id,
    required String muscleGroupId,
    this.isRecovered = const Value.absent(),
    this.lastWorkoutDate = const Value.absent(),
    this.recoveredAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       muscleGroupId = Value(muscleGroupId);
  static Insertable<MuscleRecovery> custom({
    Expression<String>? id,
    Expression<String>? muscleGroupId,
    Expression<bool>? isRecovered,
    Expression<DateTime>? lastWorkoutDate,
    Expression<DateTime>? recoveredAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (muscleGroupId != null) 'muscle_group_id': muscleGroupId,
      if (isRecovered != null) 'is_recovered': isRecovered,
      if (lastWorkoutDate != null) 'last_workout_date': lastWorkoutDate,
      if (recoveredAt != null) 'recovered_at': recoveredAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MuscleRecoveriesCompanion copyWith({
    Value<String>? id,
    Value<String>? muscleGroupId,
    Value<bool>? isRecovered,
    Value<DateTime?>? lastWorkoutDate,
    Value<DateTime?>? recoveredAt,
    Value<int>? rowid,
  }) {
    return MuscleRecoveriesCompanion(
      id: id ?? this.id,
      muscleGroupId: muscleGroupId ?? this.muscleGroupId,
      isRecovered: isRecovered ?? this.isRecovered,
      lastWorkoutDate: lastWorkoutDate ?? this.lastWorkoutDate,
      recoveredAt: recoveredAt ?? this.recoveredAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (muscleGroupId.present) {
      map['muscle_group_id'] = Variable<String>(muscleGroupId.value);
    }
    if (isRecovered.present) {
      map['is_recovered'] = Variable<bool>(isRecovered.value);
    }
    if (lastWorkoutDate.present) {
      map['last_workout_date'] = Variable<DateTime>(lastWorkoutDate.value);
    }
    if (recoveredAt.present) {
      map['recovered_at'] = Variable<DateTime>(recoveredAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MuscleRecoveriesCompanion(')
          ..write('id: $id, ')
          ..write('muscleGroupId: $muscleGroupId, ')
          ..write('isRecovered: $isRecovered, ')
          ..write('lastWorkoutDate: $lastWorkoutDate, ')
          ..write('recoveredAt: $recoveredAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutHistorySetsTable extends WorkoutHistorySets
    with TableInfo<$WorkoutHistorySetsTable, WorkoutHistorySet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutHistorySetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workoutHistoryIdMeta = const VerificationMeta(
    'workoutHistoryId',
  );
  @override
  late final GeneratedColumn<String> workoutHistoryId = GeneratedColumn<String>(
    'workout_history_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES workout_histories (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _seriesOrderMeta = const VerificationMeta(
    'seriesOrder',
  );
  @override
  late final GeneratedColumn<int> seriesOrder = GeneratedColumn<int>(
    'series_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _feedbackMeta = const VerificationMeta(
    'feedback',
  );
  @override
  late final GeneratedColumn<String> feedback = GeneratedColumn<String>(
    'feedback',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    workoutHistoryId,
    reps,
    weightKg,
    seriesOrder,
    feedback,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_history_sets';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutHistorySet> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workout_history_id')) {
      context.handle(
        _workoutHistoryIdMeta,
        workoutHistoryId.isAcceptableOrUnknown(
          data['workout_history_id']!,
          _workoutHistoryIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workoutHistoryIdMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    } else if (isInserting) {
      context.missing(_repsMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('series_order')) {
      context.handle(
        _seriesOrderMeta,
        seriesOrder.isAcceptableOrUnknown(
          data['series_order']!,
          _seriesOrderMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_seriesOrderMeta);
    }
    if (data.containsKey('feedback')) {
      context.handle(
        _feedbackMeta,
        feedback.isAcceptableOrUnknown(data['feedback']!, _feedbackMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutHistorySet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutHistorySet(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      workoutHistoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workout_history_id'],
      )!,
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      )!,
      seriesOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}series_order'],
      )!,
      feedback: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}feedback'],
      ),
    );
  }

  @override
  $WorkoutHistorySetsTable createAlias(String alias) {
    return $WorkoutHistorySetsTable(attachedDatabase, alias);
  }
}

class WorkoutHistorySet extends DataClass
    implements Insertable<WorkoutHistorySet> {
  final String id;
  final String workoutHistoryId;
  final int reps;
  final double weightKg;
  final int seriesOrder;
  final String? feedback;
  const WorkoutHistorySet({
    required this.id,
    required this.workoutHistoryId,
    required this.reps,
    required this.weightKg,
    required this.seriesOrder,
    this.feedback,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workout_history_id'] = Variable<String>(workoutHistoryId);
    map['reps'] = Variable<int>(reps);
    map['weight_kg'] = Variable<double>(weightKg);
    map['series_order'] = Variable<int>(seriesOrder);
    if (!nullToAbsent || feedback != null) {
      map['feedback'] = Variable<String>(feedback);
    }
    return map;
  }

  WorkoutHistorySetsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutHistorySetsCompanion(
      id: Value(id),
      workoutHistoryId: Value(workoutHistoryId),
      reps: Value(reps),
      weightKg: Value(weightKg),
      seriesOrder: Value(seriesOrder),
      feedback: feedback == null && nullToAbsent
          ? const Value.absent()
          : Value(feedback),
    );
  }

  factory WorkoutHistorySet.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutHistorySet(
      id: serializer.fromJson<String>(json['id']),
      workoutHistoryId: serializer.fromJson<String>(json['workoutHistoryId']),
      reps: serializer.fromJson<int>(json['reps']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      seriesOrder: serializer.fromJson<int>(json['seriesOrder']),
      feedback: serializer.fromJson<String?>(json['feedback']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workoutHistoryId': serializer.toJson<String>(workoutHistoryId),
      'reps': serializer.toJson<int>(reps),
      'weightKg': serializer.toJson<double>(weightKg),
      'seriesOrder': serializer.toJson<int>(seriesOrder),
      'feedback': serializer.toJson<String?>(feedback),
    };
  }

  WorkoutHistorySet copyWith({
    String? id,
    String? workoutHistoryId,
    int? reps,
    double? weightKg,
    int? seriesOrder,
    Value<String?> feedback = const Value.absent(),
  }) => WorkoutHistorySet(
    id: id ?? this.id,
    workoutHistoryId: workoutHistoryId ?? this.workoutHistoryId,
    reps: reps ?? this.reps,
    weightKg: weightKg ?? this.weightKg,
    seriesOrder: seriesOrder ?? this.seriesOrder,
    feedback: feedback.present ? feedback.value : this.feedback,
  );
  WorkoutHistorySet copyWithCompanion(WorkoutHistorySetsCompanion data) {
    return WorkoutHistorySet(
      id: data.id.present ? data.id.value : this.id,
      workoutHistoryId: data.workoutHistoryId.present
          ? data.workoutHistoryId.value
          : this.workoutHistoryId,
      reps: data.reps.present ? data.reps.value : this.reps,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      seriesOrder: data.seriesOrder.present
          ? data.seriesOrder.value
          : this.seriesOrder,
      feedback: data.feedback.present ? data.feedback.value : this.feedback,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutHistorySet(')
          ..write('id: $id, ')
          ..write('workoutHistoryId: $workoutHistoryId, ')
          ..write('reps: $reps, ')
          ..write('weightKg: $weightKg, ')
          ..write('seriesOrder: $seriesOrder, ')
          ..write('feedback: $feedback')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, workoutHistoryId, reps, weightKg, seriesOrder, feedback);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutHistorySet &&
          other.id == this.id &&
          other.workoutHistoryId == this.workoutHistoryId &&
          other.reps == this.reps &&
          other.weightKg == this.weightKg &&
          other.seriesOrder == this.seriesOrder &&
          other.feedback == this.feedback);
}

class WorkoutHistorySetsCompanion extends UpdateCompanion<WorkoutHistorySet> {
  final Value<String> id;
  final Value<String> workoutHistoryId;
  final Value<int> reps;
  final Value<double> weightKg;
  final Value<int> seriesOrder;
  final Value<String?> feedback;
  final Value<int> rowid;
  const WorkoutHistorySetsCompanion({
    this.id = const Value.absent(),
    this.workoutHistoryId = const Value.absent(),
    this.reps = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.seriesOrder = const Value.absent(),
    this.feedback = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutHistorySetsCompanion.insert({
    required String id,
    required String workoutHistoryId,
    required int reps,
    required double weightKg,
    required int seriesOrder,
    this.feedback = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       workoutHistoryId = Value(workoutHistoryId),
       reps = Value(reps),
       weightKg = Value(weightKg),
       seriesOrder = Value(seriesOrder);
  static Insertable<WorkoutHistorySet> custom({
    Expression<String>? id,
    Expression<String>? workoutHistoryId,
    Expression<int>? reps,
    Expression<double>? weightKg,
    Expression<int>? seriesOrder,
    Expression<String>? feedback,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workoutHistoryId != null) 'workout_history_id': workoutHistoryId,
      if (reps != null) 'reps': reps,
      if (weightKg != null) 'weight_kg': weightKg,
      if (seriesOrder != null) 'series_order': seriesOrder,
      if (feedback != null) 'feedback': feedback,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutHistorySetsCompanion copyWith({
    Value<String>? id,
    Value<String>? workoutHistoryId,
    Value<int>? reps,
    Value<double>? weightKg,
    Value<int>? seriesOrder,
    Value<String?>? feedback,
    Value<int>? rowid,
  }) {
    return WorkoutHistorySetsCompanion(
      id: id ?? this.id,
      workoutHistoryId: workoutHistoryId ?? this.workoutHistoryId,
      reps: reps ?? this.reps,
      weightKg: weightKg ?? this.weightKg,
      seriesOrder: seriesOrder ?? this.seriesOrder,
      feedback: feedback ?? this.feedback,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workoutHistoryId.present) {
      map['workout_history_id'] = Variable<String>(workoutHistoryId.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (seriesOrder.present) {
      map['series_order'] = Variable<int>(seriesOrder.value);
    }
    if (feedback.present) {
      map['feedback'] = Variable<String>(feedback.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutHistorySetsCompanion(')
          ..write('id: $id, ')
          ..write('workoutHistoryId: $workoutHistoryId, ')
          ..write('reps: $reps, ')
          ..write('weightKg: $weightKg, ')
          ..write('seriesOrder: $seriesOrder, ')
          ..write('feedback: $feedback, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyContextsTable extends DailyContexts
    with TableInfo<$DailyContextsTable, DailyContext> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyContextsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sleepTagsMeta = const VerificationMeta(
    'sleepTags',
  );
  @override
  late final GeneratedColumn<String> sleepTags = GeneratedColumn<String>(
    'sleep_tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nutritionTagsMeta = const VerificationMeta(
    'nutritionTags',
  );
  @override
  late final GeneratedColumn<String> nutritionTags = GeneratedColumn<String>(
    'nutrition_tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stressTagsMeta = const VerificationMeta(
    'stressTags',
  );
  @override
  late final GeneratedColumn<String> stressTags = GeneratedColumn<String>(
    'stress_tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    sleepTags,
    nutritionTags,
    stressTags,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_contexts';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyContext> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('sleep_tags')) {
      context.handle(
        _sleepTagsMeta,
        sleepTags.isAcceptableOrUnknown(data['sleep_tags']!, _sleepTagsMeta),
      );
    } else if (isInserting) {
      context.missing(_sleepTagsMeta);
    }
    if (data.containsKey('nutrition_tags')) {
      context.handle(
        _nutritionTagsMeta,
        nutritionTags.isAcceptableOrUnknown(
          data['nutrition_tags']!,
          _nutritionTagsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nutritionTagsMeta);
    }
    if (data.containsKey('stress_tags')) {
      context.handle(
        _stressTagsMeta,
        stressTags.isAcceptableOrUnknown(data['stress_tags']!, _stressTagsMeta),
      );
    } else if (isInserting) {
      context.missing(_stressTagsMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyContext map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyContext(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      sleepTags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sleep_tags'],
      )!,
      nutritionTags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nutrition_tags'],
      )!,
      stressTags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stress_tags'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $DailyContextsTable createAlias(String alias) {
    return $DailyContextsTable(attachedDatabase, alias);
  }
}

class DailyContext extends DataClass implements Insertable<DailyContext> {
  final String id;
  final DateTime date;
  final String sleepTags;
  final String nutritionTags;
  final String stressTags;
  final String? notes;
  const DailyContext({
    required this.id,
    required this.date,
    required this.sleepTags,
    required this.nutritionTags,
    required this.stressTags,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['sleep_tags'] = Variable<String>(sleepTags);
    map['nutrition_tags'] = Variable<String>(nutritionTags);
    map['stress_tags'] = Variable<String>(stressTags);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  DailyContextsCompanion toCompanion(bool nullToAbsent) {
    return DailyContextsCompanion(
      id: Value(id),
      date: Value(date),
      sleepTags: Value(sleepTags),
      nutritionTags: Value(nutritionTags),
      stressTags: Value(stressTags),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory DailyContext.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyContext(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      sleepTags: serializer.fromJson<String>(json['sleepTags']),
      nutritionTags: serializer.fromJson<String>(json['nutritionTags']),
      stressTags: serializer.fromJson<String>(json['stressTags']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'sleepTags': serializer.toJson<String>(sleepTags),
      'nutritionTags': serializer.toJson<String>(nutritionTags),
      'stressTags': serializer.toJson<String>(stressTags),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  DailyContext copyWith({
    String? id,
    DateTime? date,
    String? sleepTags,
    String? nutritionTags,
    String? stressTags,
    Value<String?> notes = const Value.absent(),
  }) => DailyContext(
    id: id ?? this.id,
    date: date ?? this.date,
    sleepTags: sleepTags ?? this.sleepTags,
    nutritionTags: nutritionTags ?? this.nutritionTags,
    stressTags: stressTags ?? this.stressTags,
    notes: notes.present ? notes.value : this.notes,
  );
  DailyContext copyWithCompanion(DailyContextsCompanion data) {
    return DailyContext(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      sleepTags: data.sleepTags.present ? data.sleepTags.value : this.sleepTags,
      nutritionTags: data.nutritionTags.present
          ? data.nutritionTags.value
          : this.nutritionTags,
      stressTags: data.stressTags.present
          ? data.stressTags.value
          : this.stressTags,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyContext(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('sleepTags: $sleepTags, ')
          ..write('nutritionTags: $nutritionTags, ')
          ..write('stressTags: $stressTags, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, date, sleepTags, nutritionTags, stressTags, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyContext &&
          other.id == this.id &&
          other.date == this.date &&
          other.sleepTags == this.sleepTags &&
          other.nutritionTags == this.nutritionTags &&
          other.stressTags == this.stressTags &&
          other.notes == this.notes);
}

class DailyContextsCompanion extends UpdateCompanion<DailyContext> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<String> sleepTags;
  final Value<String> nutritionTags;
  final Value<String> stressTags;
  final Value<String?> notes;
  final Value<int> rowid;
  const DailyContextsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.sleepTags = const Value.absent(),
    this.nutritionTags = const Value.absent(),
    this.stressTags = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyContextsCompanion.insert({
    required String id,
    required DateTime date,
    required String sleepTags,
    required String nutritionTags,
    required String stressTags,
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date),
       sleepTags = Value(sleepTags),
       nutritionTags = Value(nutritionTags),
       stressTags = Value(stressTags);
  static Insertable<DailyContext> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<String>? sleepTags,
    Expression<String>? nutritionTags,
    Expression<String>? stressTags,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (sleepTags != null) 'sleep_tags': sleepTags,
      if (nutritionTags != null) 'nutrition_tags': nutritionTags,
      if (stressTags != null) 'stress_tags': stressTags,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyContextsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<String>? sleepTags,
    Value<String>? nutritionTags,
    Value<String>? stressTags,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return DailyContextsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      sleepTags: sleepTags ?? this.sleepTags,
      nutritionTags: nutritionTags ?? this.nutritionTags,
      stressTags: stressTags ?? this.stressTags,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (sleepTags.present) {
      map['sleep_tags'] = Variable<String>(sleepTags.value);
    }
    if (nutritionTags.present) {
      map['nutrition_tags'] = Variable<String>(nutritionTags.value);
    }
    if (stressTags.present) {
      map['stress_tags'] = Variable<String>(stressTags.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyContextsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('sleepTags: $sleepTags, ')
          ..write('nutritionTags: $nutritionTags, ')
          ..write('stressTags: $stressTags, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecoveryHistoryLogsTable extends RecoveryHistoryLogs
    with TableInfo<$RecoveryHistoryLogsTable, RecoveryHistoryLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecoveryHistoryLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _muscleGroupIdMeta = const VerificationMeta(
    'muscleGroupId',
  );
  @override
  late final GeneratedColumn<String> muscleGroupId = GeneratedColumn<String>(
    'muscle_group_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES muscle_groups (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _fatigueDateMeta = const VerificationMeta(
    'fatigueDate',
  );
  @override
  late final GeneratedColumn<DateTime> fatigueDate = GeneratedColumn<DateTime>(
    'fatigue_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recoveredDateMeta = const VerificationMeta(
    'recoveredDate',
  );
  @override
  late final GeneratedColumn<DateTime> recoveredDate =
      GeneratedColumn<DateTime>(
        'recovered_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _durationInHoursMeta = const VerificationMeta(
    'durationInHours',
  );
  @override
  late final GeneratedColumn<int> durationInHours = GeneratedColumn<int>(
    'duration_in_hours',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    muscleGroupId,
    fatigueDate,
    recoveredDate,
    durationInHours,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recovery_history_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecoveryHistoryLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('muscle_group_id')) {
      context.handle(
        _muscleGroupIdMeta,
        muscleGroupId.isAcceptableOrUnknown(
          data['muscle_group_id']!,
          _muscleGroupIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_muscleGroupIdMeta);
    }
    if (data.containsKey('fatigue_date')) {
      context.handle(
        _fatigueDateMeta,
        fatigueDate.isAcceptableOrUnknown(
          data['fatigue_date']!,
          _fatigueDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fatigueDateMeta);
    }
    if (data.containsKey('recovered_date')) {
      context.handle(
        _recoveredDateMeta,
        recoveredDate.isAcceptableOrUnknown(
          data['recovered_date']!,
          _recoveredDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_recoveredDateMeta);
    }
    if (data.containsKey('duration_in_hours')) {
      context.handle(
        _durationInHoursMeta,
        durationInHours.isAcceptableOrUnknown(
          data['duration_in_hours']!,
          _durationInHoursMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationInHoursMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecoveryHistoryLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecoveryHistoryLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      muscleGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}muscle_group_id'],
      )!,
      fatigueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fatigue_date'],
      )!,
      recoveredDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}recovered_date'],
      )!,
      durationInHours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_in_hours'],
      )!,
    );
  }

  @override
  $RecoveryHistoryLogsTable createAlias(String alias) {
    return $RecoveryHistoryLogsTable(attachedDatabase, alias);
  }
}

class RecoveryHistoryLog extends DataClass
    implements Insertable<RecoveryHistoryLog> {
  final String id;
  final String muscleGroupId;
  final DateTime fatigueDate;
  final DateTime recoveredDate;
  final int durationInHours;
  const RecoveryHistoryLog({
    required this.id,
    required this.muscleGroupId,
    required this.fatigueDate,
    required this.recoveredDate,
    required this.durationInHours,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['muscle_group_id'] = Variable<String>(muscleGroupId);
    map['fatigue_date'] = Variable<DateTime>(fatigueDate);
    map['recovered_date'] = Variable<DateTime>(recoveredDate);
    map['duration_in_hours'] = Variable<int>(durationInHours);
    return map;
  }

  RecoveryHistoryLogsCompanion toCompanion(bool nullToAbsent) {
    return RecoveryHistoryLogsCompanion(
      id: Value(id),
      muscleGroupId: Value(muscleGroupId),
      fatigueDate: Value(fatigueDate),
      recoveredDate: Value(recoveredDate),
      durationInHours: Value(durationInHours),
    );
  }

  factory RecoveryHistoryLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecoveryHistoryLog(
      id: serializer.fromJson<String>(json['id']),
      muscleGroupId: serializer.fromJson<String>(json['muscleGroupId']),
      fatigueDate: serializer.fromJson<DateTime>(json['fatigueDate']),
      recoveredDate: serializer.fromJson<DateTime>(json['recoveredDate']),
      durationInHours: serializer.fromJson<int>(json['durationInHours']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'muscleGroupId': serializer.toJson<String>(muscleGroupId),
      'fatigueDate': serializer.toJson<DateTime>(fatigueDate),
      'recoveredDate': serializer.toJson<DateTime>(recoveredDate),
      'durationInHours': serializer.toJson<int>(durationInHours),
    };
  }

  RecoveryHistoryLog copyWith({
    String? id,
    String? muscleGroupId,
    DateTime? fatigueDate,
    DateTime? recoveredDate,
    int? durationInHours,
  }) => RecoveryHistoryLog(
    id: id ?? this.id,
    muscleGroupId: muscleGroupId ?? this.muscleGroupId,
    fatigueDate: fatigueDate ?? this.fatigueDate,
    recoveredDate: recoveredDate ?? this.recoveredDate,
    durationInHours: durationInHours ?? this.durationInHours,
  );
  RecoveryHistoryLog copyWithCompanion(RecoveryHistoryLogsCompanion data) {
    return RecoveryHistoryLog(
      id: data.id.present ? data.id.value : this.id,
      muscleGroupId: data.muscleGroupId.present
          ? data.muscleGroupId.value
          : this.muscleGroupId,
      fatigueDate: data.fatigueDate.present
          ? data.fatigueDate.value
          : this.fatigueDate,
      recoveredDate: data.recoveredDate.present
          ? data.recoveredDate.value
          : this.recoveredDate,
      durationInHours: data.durationInHours.present
          ? data.durationInHours.value
          : this.durationInHours,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecoveryHistoryLog(')
          ..write('id: $id, ')
          ..write('muscleGroupId: $muscleGroupId, ')
          ..write('fatigueDate: $fatigueDate, ')
          ..write('recoveredDate: $recoveredDate, ')
          ..write('durationInHours: $durationInHours')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    muscleGroupId,
    fatigueDate,
    recoveredDate,
    durationInHours,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecoveryHistoryLog &&
          other.id == this.id &&
          other.muscleGroupId == this.muscleGroupId &&
          other.fatigueDate == this.fatigueDate &&
          other.recoveredDate == this.recoveredDate &&
          other.durationInHours == this.durationInHours);
}

class RecoveryHistoryLogsCompanion extends UpdateCompanion<RecoveryHistoryLog> {
  final Value<String> id;
  final Value<String> muscleGroupId;
  final Value<DateTime> fatigueDate;
  final Value<DateTime> recoveredDate;
  final Value<int> durationInHours;
  final Value<int> rowid;
  const RecoveryHistoryLogsCompanion({
    this.id = const Value.absent(),
    this.muscleGroupId = const Value.absent(),
    this.fatigueDate = const Value.absent(),
    this.recoveredDate = const Value.absent(),
    this.durationInHours = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecoveryHistoryLogsCompanion.insert({
    required String id,
    required String muscleGroupId,
    required DateTime fatigueDate,
    required DateTime recoveredDate,
    required int durationInHours,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       muscleGroupId = Value(muscleGroupId),
       fatigueDate = Value(fatigueDate),
       recoveredDate = Value(recoveredDate),
       durationInHours = Value(durationInHours);
  static Insertable<RecoveryHistoryLog> custom({
    Expression<String>? id,
    Expression<String>? muscleGroupId,
    Expression<DateTime>? fatigueDate,
    Expression<DateTime>? recoveredDate,
    Expression<int>? durationInHours,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (muscleGroupId != null) 'muscle_group_id': muscleGroupId,
      if (fatigueDate != null) 'fatigue_date': fatigueDate,
      if (recoveredDate != null) 'recovered_date': recoveredDate,
      if (durationInHours != null) 'duration_in_hours': durationInHours,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecoveryHistoryLogsCompanion copyWith({
    Value<String>? id,
    Value<String>? muscleGroupId,
    Value<DateTime>? fatigueDate,
    Value<DateTime>? recoveredDate,
    Value<int>? durationInHours,
    Value<int>? rowid,
  }) {
    return RecoveryHistoryLogsCompanion(
      id: id ?? this.id,
      muscleGroupId: muscleGroupId ?? this.muscleGroupId,
      fatigueDate: fatigueDate ?? this.fatigueDate,
      recoveredDate: recoveredDate ?? this.recoveredDate,
      durationInHours: durationInHours ?? this.durationInHours,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (muscleGroupId.present) {
      map['muscle_group_id'] = Variable<String>(muscleGroupId.value);
    }
    if (fatigueDate.present) {
      map['fatigue_date'] = Variable<DateTime>(fatigueDate.value);
    }
    if (recoveredDate.present) {
      map['recovered_date'] = Variable<DateTime>(recoveredDate.value);
    }
    if (durationInHours.present) {
      map['duration_in_hours'] = Variable<int>(durationInHours.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecoveryHistoryLogsCompanion(')
          ..write('id: $id, ')
          ..write('muscleGroupId: $muscleGroupId, ')
          ..write('fatigueDate: $fatigueDate, ')
          ..write('recoveredDate: $recoveredDate, ')
          ..write('durationInHours: $durationInHours, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MealsTable extends Meals with TableInfo<$MealsTable, Meal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mealIndexMeta = const VerificationMeta(
    'mealIndex',
  );
  @override
  late final GeneratedColumn<int> mealIndex = GeneratedColumn<int>(
    'meal_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caloriesMeta = const VerificationMeta(
    'calories',
  );
  @override
  late final GeneratedColumn<double> calories = GeneratedColumn<double>(
    'calories',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _carbsMeta = const VerificationMeta('carbs');
  @override
  late final GeneratedColumn<double> carbs = GeneratedColumn<double>(
    'carbs',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _proteinMeta = const VerificationMeta(
    'protein',
  );
  @override
  late final GeneratedColumn<double> protein = GeneratedColumn<double>(
    'protein',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _totalFatMeta = const VerificationMeta(
    'totalFat',
  );
  @override
  late final GeneratedColumn<double> totalFat = GeneratedColumn<double>(
    'total_fat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _saturatedFatMeta = const VerificationMeta(
    'saturatedFat',
  );
  @override
  late final GeneratedColumn<double> saturatedFat = GeneratedColumn<double>(
    'saturated_fat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _fiberMeta = const VerificationMeta('fiber');
  @override
  late final GeneratedColumn<double> fiber = GeneratedColumn<double>(
    'fiber',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _sodiumMeta = const VerificationMeta('sodium');
  @override
  late final GeneratedColumn<double> sodium = GeneratedColumn<double>(
    'sodium',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _calciumMeta = const VerificationMeta(
    'calcium',
  );
  @override
  late final GeneratedColumn<double> calcium = GeneratedColumn<double>(
    'calcium',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    mealIndex,
    calories,
    carbs,
    protein,
    totalFat,
    saturatedFat,
    fiber,
    sodium,
    calcium,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meals';
  @override
  VerificationContext validateIntegrity(
    Insertable<Meal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('meal_index')) {
      context.handle(
        _mealIndexMeta,
        mealIndex.isAcceptableOrUnknown(data['meal_index']!, _mealIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_mealIndexMeta);
    }
    if (data.containsKey('calories')) {
      context.handle(
        _caloriesMeta,
        calories.isAcceptableOrUnknown(data['calories']!, _caloriesMeta),
      );
    }
    if (data.containsKey('carbs')) {
      context.handle(
        _carbsMeta,
        carbs.isAcceptableOrUnknown(data['carbs']!, _carbsMeta),
      );
    }
    if (data.containsKey('protein')) {
      context.handle(
        _proteinMeta,
        protein.isAcceptableOrUnknown(data['protein']!, _proteinMeta),
      );
    }
    if (data.containsKey('total_fat')) {
      context.handle(
        _totalFatMeta,
        totalFat.isAcceptableOrUnknown(data['total_fat']!, _totalFatMeta),
      );
    }
    if (data.containsKey('saturated_fat')) {
      context.handle(
        _saturatedFatMeta,
        saturatedFat.isAcceptableOrUnknown(
          data['saturated_fat']!,
          _saturatedFatMeta,
        ),
      );
    }
    if (data.containsKey('fiber')) {
      context.handle(
        _fiberMeta,
        fiber.isAcceptableOrUnknown(data['fiber']!, _fiberMeta),
      );
    }
    if (data.containsKey('sodium')) {
      context.handle(
        _sodiumMeta,
        sodium.isAcceptableOrUnknown(data['sodium']!, _sodiumMeta),
      );
    }
    if (data.containsKey('calcium')) {
      context.handle(
        _calciumMeta,
        calcium.isAcceptableOrUnknown(data['calcium']!, _calciumMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Meal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Meal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      mealIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}meal_index'],
      )!,
      calories: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calories'],
      )!,
      carbs: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs'],
      )!,
      protein: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein'],
      )!,
      totalFat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_fat'],
      )!,
      saturatedFat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}saturated_fat'],
      )!,
      fiber: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fiber'],
      )!,
      sodium: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sodium'],
      )!,
      calcium: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calcium'],
      )!,
    );
  }

  @override
  $MealsTable createAlias(String alias) {
    return $MealsTable(attachedDatabase, alias);
  }
}

class Meal extends DataClass implements Insertable<Meal> {
  final String id;
  final DateTime date;
  final int mealIndex;
  final double calories;
  final double carbs;
  final double protein;
  final double totalFat;
  final double saturatedFat;
  final double fiber;
  final double sodium;
  final double calcium;
  const Meal({
    required this.id,
    required this.date,
    required this.mealIndex,
    required this.calories,
    required this.carbs,
    required this.protein,
    required this.totalFat,
    required this.saturatedFat,
    required this.fiber,
    required this.sodium,
    required this.calcium,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['meal_index'] = Variable<int>(mealIndex);
    map['calories'] = Variable<double>(calories);
    map['carbs'] = Variable<double>(carbs);
    map['protein'] = Variable<double>(protein);
    map['total_fat'] = Variable<double>(totalFat);
    map['saturated_fat'] = Variable<double>(saturatedFat);
    map['fiber'] = Variable<double>(fiber);
    map['sodium'] = Variable<double>(sodium);
    map['calcium'] = Variable<double>(calcium);
    return map;
  }

  MealsCompanion toCompanion(bool nullToAbsent) {
    return MealsCompanion(
      id: Value(id),
      date: Value(date),
      mealIndex: Value(mealIndex),
      calories: Value(calories),
      carbs: Value(carbs),
      protein: Value(protein),
      totalFat: Value(totalFat),
      saturatedFat: Value(saturatedFat),
      fiber: Value(fiber),
      sodium: Value(sodium),
      calcium: Value(calcium),
    );
  }

  factory Meal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Meal(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      mealIndex: serializer.fromJson<int>(json['mealIndex']),
      calories: serializer.fromJson<double>(json['calories']),
      carbs: serializer.fromJson<double>(json['carbs']),
      protein: serializer.fromJson<double>(json['protein']),
      totalFat: serializer.fromJson<double>(json['totalFat']),
      saturatedFat: serializer.fromJson<double>(json['saturatedFat']),
      fiber: serializer.fromJson<double>(json['fiber']),
      sodium: serializer.fromJson<double>(json['sodium']),
      calcium: serializer.fromJson<double>(json['calcium']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'mealIndex': serializer.toJson<int>(mealIndex),
      'calories': serializer.toJson<double>(calories),
      'carbs': serializer.toJson<double>(carbs),
      'protein': serializer.toJson<double>(protein),
      'totalFat': serializer.toJson<double>(totalFat),
      'saturatedFat': serializer.toJson<double>(saturatedFat),
      'fiber': serializer.toJson<double>(fiber),
      'sodium': serializer.toJson<double>(sodium),
      'calcium': serializer.toJson<double>(calcium),
    };
  }

  Meal copyWith({
    String? id,
    DateTime? date,
    int? mealIndex,
    double? calories,
    double? carbs,
    double? protein,
    double? totalFat,
    double? saturatedFat,
    double? fiber,
    double? sodium,
    double? calcium,
  }) => Meal(
    id: id ?? this.id,
    date: date ?? this.date,
    mealIndex: mealIndex ?? this.mealIndex,
    calories: calories ?? this.calories,
    carbs: carbs ?? this.carbs,
    protein: protein ?? this.protein,
    totalFat: totalFat ?? this.totalFat,
    saturatedFat: saturatedFat ?? this.saturatedFat,
    fiber: fiber ?? this.fiber,
    sodium: sodium ?? this.sodium,
    calcium: calcium ?? this.calcium,
  );
  Meal copyWithCompanion(MealsCompanion data) {
    return Meal(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      mealIndex: data.mealIndex.present ? data.mealIndex.value : this.mealIndex,
      calories: data.calories.present ? data.calories.value : this.calories,
      carbs: data.carbs.present ? data.carbs.value : this.carbs,
      protein: data.protein.present ? data.protein.value : this.protein,
      totalFat: data.totalFat.present ? data.totalFat.value : this.totalFat,
      saturatedFat: data.saturatedFat.present
          ? data.saturatedFat.value
          : this.saturatedFat,
      fiber: data.fiber.present ? data.fiber.value : this.fiber,
      sodium: data.sodium.present ? data.sodium.value : this.sodium,
      calcium: data.calcium.present ? data.calcium.value : this.calcium,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Meal(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('mealIndex: $mealIndex, ')
          ..write('calories: $calories, ')
          ..write('carbs: $carbs, ')
          ..write('protein: $protein, ')
          ..write('totalFat: $totalFat, ')
          ..write('saturatedFat: $saturatedFat, ')
          ..write('fiber: $fiber, ')
          ..write('sodium: $sodium, ')
          ..write('calcium: $calcium')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    date,
    mealIndex,
    calories,
    carbs,
    protein,
    totalFat,
    saturatedFat,
    fiber,
    sodium,
    calcium,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Meal &&
          other.id == this.id &&
          other.date == this.date &&
          other.mealIndex == this.mealIndex &&
          other.calories == this.calories &&
          other.carbs == this.carbs &&
          other.protein == this.protein &&
          other.totalFat == this.totalFat &&
          other.saturatedFat == this.saturatedFat &&
          other.fiber == this.fiber &&
          other.sodium == this.sodium &&
          other.calcium == this.calcium);
}

class MealsCompanion extends UpdateCompanion<Meal> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<int> mealIndex;
  final Value<double> calories;
  final Value<double> carbs;
  final Value<double> protein;
  final Value<double> totalFat;
  final Value<double> saturatedFat;
  final Value<double> fiber;
  final Value<double> sodium;
  final Value<double> calcium;
  final Value<int> rowid;
  const MealsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.mealIndex = const Value.absent(),
    this.calories = const Value.absent(),
    this.carbs = const Value.absent(),
    this.protein = const Value.absent(),
    this.totalFat = const Value.absent(),
    this.saturatedFat = const Value.absent(),
    this.fiber = const Value.absent(),
    this.sodium = const Value.absent(),
    this.calcium = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MealsCompanion.insert({
    required String id,
    required DateTime date,
    required int mealIndex,
    this.calories = const Value.absent(),
    this.carbs = const Value.absent(),
    this.protein = const Value.absent(),
    this.totalFat = const Value.absent(),
    this.saturatedFat = const Value.absent(),
    this.fiber = const Value.absent(),
    this.sodium = const Value.absent(),
    this.calcium = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date),
       mealIndex = Value(mealIndex);
  static Insertable<Meal> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<int>? mealIndex,
    Expression<double>? calories,
    Expression<double>? carbs,
    Expression<double>? protein,
    Expression<double>? totalFat,
    Expression<double>? saturatedFat,
    Expression<double>? fiber,
    Expression<double>? sodium,
    Expression<double>? calcium,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (mealIndex != null) 'meal_index': mealIndex,
      if (calories != null) 'calories': calories,
      if (carbs != null) 'carbs': carbs,
      if (protein != null) 'protein': protein,
      if (totalFat != null) 'total_fat': totalFat,
      if (saturatedFat != null) 'saturated_fat': saturatedFat,
      if (fiber != null) 'fiber': fiber,
      if (sodium != null) 'sodium': sodium,
      if (calcium != null) 'calcium': calcium,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MealsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<int>? mealIndex,
    Value<double>? calories,
    Value<double>? carbs,
    Value<double>? protein,
    Value<double>? totalFat,
    Value<double>? saturatedFat,
    Value<double>? fiber,
    Value<double>? sodium,
    Value<double>? calcium,
    Value<int>? rowid,
  }) {
    return MealsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      mealIndex: mealIndex ?? this.mealIndex,
      calories: calories ?? this.calories,
      carbs: carbs ?? this.carbs,
      protein: protein ?? this.protein,
      totalFat: totalFat ?? this.totalFat,
      saturatedFat: saturatedFat ?? this.saturatedFat,
      fiber: fiber ?? this.fiber,
      sodium: sodium ?? this.sodium,
      calcium: calcium ?? this.calcium,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (mealIndex.present) {
      map['meal_index'] = Variable<int>(mealIndex.value);
    }
    if (calories.present) {
      map['calories'] = Variable<double>(calories.value);
    }
    if (carbs.present) {
      map['carbs'] = Variable<double>(carbs.value);
    }
    if (protein.present) {
      map['protein'] = Variable<double>(protein.value);
    }
    if (totalFat.present) {
      map['total_fat'] = Variable<double>(totalFat.value);
    }
    if (saturatedFat.present) {
      map['saturated_fat'] = Variable<double>(saturatedFat.value);
    }
    if (fiber.present) {
      map['fiber'] = Variable<double>(fiber.value);
    }
    if (sodium.present) {
      map['sodium'] = Variable<double>(sodium.value);
    }
    if (calcium.present) {
      map['calcium'] = Variable<double>(calcium.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('mealIndex: $mealIndex, ')
          ..write('calories: $calories, ')
          ..write('carbs: $carbs, ')
          ..write('protein: $protein, ')
          ..write('totalFat: $totalFat, ')
          ..write('saturatedFat: $saturatedFat, ')
          ..write('fiber: $fiber, ')
          ..write('sodium: $sodium, ')
          ..write('calcium: $calcium, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserGoalsTable extends UserGoals
    with TableInfo<$UserGoalsTable, UserGoal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserGoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caloriesTargetMeta = const VerificationMeta(
    'caloriesTarget',
  );
  @override
  late final GeneratedColumn<double> caloriesTarget = GeneratedColumn<double>(
    'calories_target',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(2000.0),
  );
  static const VerificationMeta _carbsTargetMeta = const VerificationMeta(
    'carbsTarget',
  );
  @override
  late final GeneratedColumn<double> carbsTarget = GeneratedColumn<double>(
    'carbs_target',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(250.0),
  );
  static const VerificationMeta _proteinTargetMeta = const VerificationMeta(
    'proteinTarget',
  );
  @override
  late final GeneratedColumn<double> proteinTarget = GeneratedColumn<double>(
    'protein_target',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(150.0),
  );
  static const VerificationMeta _fatTargetMeta = const VerificationMeta(
    'fatTarget',
  );
  @override
  late final GeneratedColumn<double> fatTarget = GeneratedColumn<double>(
    'fat_target',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(70.0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    caloriesTarget,
    carbsTarget,
    proteinTarget,
    fatTarget,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserGoal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('calories_target')) {
      context.handle(
        _caloriesTargetMeta,
        caloriesTarget.isAcceptableOrUnknown(
          data['calories_target']!,
          _caloriesTargetMeta,
        ),
      );
    }
    if (data.containsKey('carbs_target')) {
      context.handle(
        _carbsTargetMeta,
        carbsTarget.isAcceptableOrUnknown(
          data['carbs_target']!,
          _carbsTargetMeta,
        ),
      );
    }
    if (data.containsKey('protein_target')) {
      context.handle(
        _proteinTargetMeta,
        proteinTarget.isAcceptableOrUnknown(
          data['protein_target']!,
          _proteinTargetMeta,
        ),
      );
    }
    if (data.containsKey('fat_target')) {
      context.handle(
        _fatTargetMeta,
        fatTarget.isAcceptableOrUnknown(data['fat_target']!, _fatTargetMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserGoal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserGoal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      caloriesTarget: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calories_target'],
      )!,
      carbsTarget: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs_target'],
      )!,
      proteinTarget: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_target'],
      )!,
      fatTarget: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_target'],
      )!,
    );
  }

  @override
  $UserGoalsTable createAlias(String alias) {
    return $UserGoalsTable(attachedDatabase, alias);
  }
}

class UserGoal extends DataClass implements Insertable<UserGoal> {
  final String id;
  final double caloriesTarget;
  final double carbsTarget;
  final double proteinTarget;
  final double fatTarget;
  const UserGoal({
    required this.id,
    required this.caloriesTarget,
    required this.carbsTarget,
    required this.proteinTarget,
    required this.fatTarget,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['calories_target'] = Variable<double>(caloriesTarget);
    map['carbs_target'] = Variable<double>(carbsTarget);
    map['protein_target'] = Variable<double>(proteinTarget);
    map['fat_target'] = Variable<double>(fatTarget);
    return map;
  }

  UserGoalsCompanion toCompanion(bool nullToAbsent) {
    return UserGoalsCompanion(
      id: Value(id),
      caloriesTarget: Value(caloriesTarget),
      carbsTarget: Value(carbsTarget),
      proteinTarget: Value(proteinTarget),
      fatTarget: Value(fatTarget),
    );
  }

  factory UserGoal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserGoal(
      id: serializer.fromJson<String>(json['id']),
      caloriesTarget: serializer.fromJson<double>(json['caloriesTarget']),
      carbsTarget: serializer.fromJson<double>(json['carbsTarget']),
      proteinTarget: serializer.fromJson<double>(json['proteinTarget']),
      fatTarget: serializer.fromJson<double>(json['fatTarget']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'caloriesTarget': serializer.toJson<double>(caloriesTarget),
      'carbsTarget': serializer.toJson<double>(carbsTarget),
      'proteinTarget': serializer.toJson<double>(proteinTarget),
      'fatTarget': serializer.toJson<double>(fatTarget),
    };
  }

  UserGoal copyWith({
    String? id,
    double? caloriesTarget,
    double? carbsTarget,
    double? proteinTarget,
    double? fatTarget,
  }) => UserGoal(
    id: id ?? this.id,
    caloriesTarget: caloriesTarget ?? this.caloriesTarget,
    carbsTarget: carbsTarget ?? this.carbsTarget,
    proteinTarget: proteinTarget ?? this.proteinTarget,
    fatTarget: fatTarget ?? this.fatTarget,
  );
  UserGoal copyWithCompanion(UserGoalsCompanion data) {
    return UserGoal(
      id: data.id.present ? data.id.value : this.id,
      caloriesTarget: data.caloriesTarget.present
          ? data.caloriesTarget.value
          : this.caloriesTarget,
      carbsTarget: data.carbsTarget.present
          ? data.carbsTarget.value
          : this.carbsTarget,
      proteinTarget: data.proteinTarget.present
          ? data.proteinTarget.value
          : this.proteinTarget,
      fatTarget: data.fatTarget.present ? data.fatTarget.value : this.fatTarget,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserGoal(')
          ..write('id: $id, ')
          ..write('caloriesTarget: $caloriesTarget, ')
          ..write('carbsTarget: $carbsTarget, ')
          ..write('proteinTarget: $proteinTarget, ')
          ..write('fatTarget: $fatTarget')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, caloriesTarget, carbsTarget, proteinTarget, fatTarget);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserGoal &&
          other.id == this.id &&
          other.caloriesTarget == this.caloriesTarget &&
          other.carbsTarget == this.carbsTarget &&
          other.proteinTarget == this.proteinTarget &&
          other.fatTarget == this.fatTarget);
}

class UserGoalsCompanion extends UpdateCompanion<UserGoal> {
  final Value<String> id;
  final Value<double> caloriesTarget;
  final Value<double> carbsTarget;
  final Value<double> proteinTarget;
  final Value<double> fatTarget;
  final Value<int> rowid;
  const UserGoalsCompanion({
    this.id = const Value.absent(),
    this.caloriesTarget = const Value.absent(),
    this.carbsTarget = const Value.absent(),
    this.proteinTarget = const Value.absent(),
    this.fatTarget = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserGoalsCompanion.insert({
    required String id,
    this.caloriesTarget = const Value.absent(),
    this.carbsTarget = const Value.absent(),
    this.proteinTarget = const Value.absent(),
    this.fatTarget = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<UserGoal> custom({
    Expression<String>? id,
    Expression<double>? caloriesTarget,
    Expression<double>? carbsTarget,
    Expression<double>? proteinTarget,
    Expression<double>? fatTarget,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (caloriesTarget != null) 'calories_target': caloriesTarget,
      if (carbsTarget != null) 'carbs_target': carbsTarget,
      if (proteinTarget != null) 'protein_target': proteinTarget,
      if (fatTarget != null) 'fat_target': fatTarget,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserGoalsCompanion copyWith({
    Value<String>? id,
    Value<double>? caloriesTarget,
    Value<double>? carbsTarget,
    Value<double>? proteinTarget,
    Value<double>? fatTarget,
    Value<int>? rowid,
  }) {
    return UserGoalsCompanion(
      id: id ?? this.id,
      caloriesTarget: caloriesTarget ?? this.caloriesTarget,
      carbsTarget: carbsTarget ?? this.carbsTarget,
      proteinTarget: proteinTarget ?? this.proteinTarget,
      fatTarget: fatTarget ?? this.fatTarget,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (caloriesTarget.present) {
      map['calories_target'] = Variable<double>(caloriesTarget.value);
    }
    if (carbsTarget.present) {
      map['carbs_target'] = Variable<double>(carbsTarget.value);
    }
    if (proteinTarget.present) {
      map['protein_target'] = Variable<double>(proteinTarget.value);
    }
    if (fatTarget.present) {
      map['fat_target'] = Variable<double>(fatTarget.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserGoalsCompanion(')
          ..write('id: $id, ')
          ..write('caloriesTarget: $caloriesTarget, ')
          ..write('carbsTarget: $carbsTarget, ')
          ..write('proteinTarget: $proteinTarget, ')
          ..write('fatTarget: $fatTarget, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MuscleGroupsTable muscleGroups = $MuscleGroupsTable(this);
  late final $TrainingSessionsTable trainingSessions = $TrainingSessionsTable(
    this,
  );
  late final $SessionMuscleGroupsTable sessionMuscleGroups =
      $SessionMuscleGroupsTable(this);
  late final $ExercisesTable exercises = $ExercisesTable(this);
  late final $ExerciseSeriesListTable exerciseSeriesList =
      $ExerciseSeriesListTable(this);
  late final $WorkoutSessionsTable workoutSessions = $WorkoutSessionsTable(
    this,
  );
  late final $WorkoutHistoriesTable workoutHistories = $WorkoutHistoriesTable(
    this,
  );
  late final $MuscleRecoveriesTable muscleRecoveries = $MuscleRecoveriesTable(
    this,
  );
  late final $WorkoutHistorySetsTable workoutHistorySets =
      $WorkoutHistorySetsTable(this);
  late final $DailyContextsTable dailyContexts = $DailyContextsTable(this);
  late final $RecoveryHistoryLogsTable recoveryHistoryLogs =
      $RecoveryHistoryLogsTable(this);
  late final $MealsTable meals = $MealsTable(this);
  late final $UserGoalsTable userGoals = $UserGoalsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    muscleGroups,
    trainingSessions,
    sessionMuscleGroups,
    exercises,
    exerciseSeriesList,
    workoutSessions,
    workoutHistories,
    muscleRecoveries,
    workoutHistorySets,
    dailyContexts,
    recoveryHistoryLogs,
    meals,
    userGoals,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'training_sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('session_muscle_groups', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'muscle_groups',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('session_muscle_groups', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'session_muscle_groups',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('exercises', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'exercises',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('exercise_series_list', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'training_sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('workout_sessions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'session_muscle_groups',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('workout_sessions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'workout_sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('workout_histories', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'exercises',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('workout_histories', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'muscle_groups',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('muscle_recoveries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'workout_histories',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('workout_history_sets', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'muscle_groups',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recovery_history_logs', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$MuscleGroupsTableCreateCompanionBuilder =
    MuscleGroupsCompanion Function({
      required String id,
      required String name,
      Value<String> color,
      Value<int> order,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$MuscleGroupsTableUpdateCompanionBuilder =
    MuscleGroupsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> color,
      Value<int> order,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$MuscleGroupsTableReferences
    extends BaseReferences<_$AppDatabase, $MuscleGroupsTable, MuscleGroup> {
  $$MuscleGroupsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $SessionMuscleGroupsTable,
    List<SessionMuscleGroup>
  >
  _sessionMuscleGroupsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.sessionMuscleGroups,
        aliasName: $_aliasNameGenerator(
          db.muscleGroups.id,
          db.sessionMuscleGroups.muscleGroupId,
        ),
      );

  $$SessionMuscleGroupsTableProcessedTableManager get sessionMuscleGroupsRefs {
    final manager = $$SessionMuscleGroupsTableTableManager(
      $_db,
      $_db.sessionMuscleGroups,
    ).filter((f) => f.muscleGroupId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _sessionMuscleGroupsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MuscleRecoveriesTable, List<MuscleRecovery>>
  _muscleRecoveriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.muscleRecoveries,
    aliasName: $_aliasNameGenerator(
      db.muscleGroups.id,
      db.muscleRecoveries.muscleGroupId,
    ),
  );

  $$MuscleRecoveriesTableProcessedTableManager get muscleRecoveriesRefs {
    final manager = $$MuscleRecoveriesTableTableManager(
      $_db,
      $_db.muscleRecoveries,
    ).filter((f) => f.muscleGroupId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _muscleRecoveriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $RecoveryHistoryLogsTable,
    List<RecoveryHistoryLog>
  >
  _recoveryHistoryLogsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recoveryHistoryLogs,
        aliasName: $_aliasNameGenerator(
          db.muscleGroups.id,
          db.recoveryHistoryLogs.muscleGroupId,
        ),
      );

  $$RecoveryHistoryLogsTableProcessedTableManager get recoveryHistoryLogsRefs {
    final manager = $$RecoveryHistoryLogsTableTableManager(
      $_db,
      $_db.recoveryHistoryLogs,
    ).filter((f) => f.muscleGroupId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recoveryHistoryLogsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MuscleGroupsTableFilterComposer
    extends Composer<_$AppDatabase, $MuscleGroupsTable> {
  $$MuscleGroupsTableFilterComposer({
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

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sessionMuscleGroupsRefs(
    Expression<bool> Function($$SessionMuscleGroupsTableFilterComposer f) f,
  ) {
    final $$SessionMuscleGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessionMuscleGroups,
      getReferencedColumn: (t) => t.muscleGroupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionMuscleGroupsTableFilterComposer(
            $db: $db,
            $table: $db.sessionMuscleGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> muscleRecoveriesRefs(
    Expression<bool> Function($$MuscleRecoveriesTableFilterComposer f) f,
  ) {
    final $$MuscleRecoveriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.muscleRecoveries,
      getReferencedColumn: (t) => t.muscleGroupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MuscleRecoveriesTableFilterComposer(
            $db: $db,
            $table: $db.muscleRecoveries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> recoveryHistoryLogsRefs(
    Expression<bool> Function($$RecoveryHistoryLogsTableFilterComposer f) f,
  ) {
    final $$RecoveryHistoryLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recoveryHistoryLogs,
      getReferencedColumn: (t) => t.muscleGroupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecoveryHistoryLogsTableFilterComposer(
            $db: $db,
            $table: $db.recoveryHistoryLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MuscleGroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $MuscleGroupsTable> {
  $$MuscleGroupsTableOrderingComposer({
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

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MuscleGroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MuscleGroupsTable> {
  $$MuscleGroupsTableAnnotationComposer({
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

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> sessionMuscleGroupsRefs<T extends Object>(
    Expression<T> Function($$SessionMuscleGroupsTableAnnotationComposer a) f,
  ) {
    final $$SessionMuscleGroupsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.sessionMuscleGroups,
          getReferencedColumn: (t) => t.muscleGroupId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SessionMuscleGroupsTableAnnotationComposer(
                $db: $db,
                $table: $db.sessionMuscleGroups,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> muscleRecoveriesRefs<T extends Object>(
    Expression<T> Function($$MuscleRecoveriesTableAnnotationComposer a) f,
  ) {
    final $$MuscleRecoveriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.muscleRecoveries,
      getReferencedColumn: (t) => t.muscleGroupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MuscleRecoveriesTableAnnotationComposer(
            $db: $db,
            $table: $db.muscleRecoveries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> recoveryHistoryLogsRefs<T extends Object>(
    Expression<T> Function($$RecoveryHistoryLogsTableAnnotationComposer a) f,
  ) {
    final $$RecoveryHistoryLogsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recoveryHistoryLogs,
          getReferencedColumn: (t) => t.muscleGroupId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecoveryHistoryLogsTableAnnotationComposer(
                $db: $db,
                $table: $db.recoveryHistoryLogs,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MuscleGroupsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MuscleGroupsTable,
          MuscleGroup,
          $$MuscleGroupsTableFilterComposer,
          $$MuscleGroupsTableOrderingComposer,
          $$MuscleGroupsTableAnnotationComposer,
          $$MuscleGroupsTableCreateCompanionBuilder,
          $$MuscleGroupsTableUpdateCompanionBuilder,
          (MuscleGroup, $$MuscleGroupsTableReferences),
          MuscleGroup,
          PrefetchHooks Function({
            bool sessionMuscleGroupsRefs,
            bool muscleRecoveriesRefs,
            bool recoveryHistoryLogsRefs,
          })
        > {
  $$MuscleGroupsTableTableManager(_$AppDatabase db, $MuscleGroupsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MuscleGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MuscleGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MuscleGroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> color = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MuscleGroupsCompanion(
                id: id,
                name: name,
                color: color,
                order: order,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String> color = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MuscleGroupsCompanion.insert(
                id: id,
                name: name,
                color: color,
                order: order,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MuscleGroupsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                sessionMuscleGroupsRefs = false,
                muscleRecoveriesRefs = false,
                recoveryHistoryLogsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (sessionMuscleGroupsRefs) db.sessionMuscleGroups,
                    if (muscleRecoveriesRefs) db.muscleRecoveries,
                    if (recoveryHistoryLogsRefs) db.recoveryHistoryLogs,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (sessionMuscleGroupsRefs)
                        await $_getPrefetchedData<
                          MuscleGroup,
                          $MuscleGroupsTable,
                          SessionMuscleGroup
                        >(
                          currentTable: table,
                          referencedTable: $$MuscleGroupsTableReferences
                              ._sessionMuscleGroupsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MuscleGroupsTableReferences(
                                db,
                                table,
                                p0,
                              ).sessionMuscleGroupsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.muscleGroupId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (muscleRecoveriesRefs)
                        await $_getPrefetchedData<
                          MuscleGroup,
                          $MuscleGroupsTable,
                          MuscleRecovery
                        >(
                          currentTable: table,
                          referencedTable: $$MuscleGroupsTableReferences
                              ._muscleRecoveriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MuscleGroupsTableReferences(
                                db,
                                table,
                                p0,
                              ).muscleRecoveriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.muscleGroupId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (recoveryHistoryLogsRefs)
                        await $_getPrefetchedData<
                          MuscleGroup,
                          $MuscleGroupsTable,
                          RecoveryHistoryLog
                        >(
                          currentTable: table,
                          referencedTable: $$MuscleGroupsTableReferences
                              ._recoveryHistoryLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MuscleGroupsTableReferences(
                                db,
                                table,
                                p0,
                              ).recoveryHistoryLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.muscleGroupId == item.id,
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

typedef $$MuscleGroupsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MuscleGroupsTable,
      MuscleGroup,
      $$MuscleGroupsTableFilterComposer,
      $$MuscleGroupsTableOrderingComposer,
      $$MuscleGroupsTableAnnotationComposer,
      $$MuscleGroupsTableCreateCompanionBuilder,
      $$MuscleGroupsTableUpdateCompanionBuilder,
      (MuscleGroup, $$MuscleGroupsTableReferences),
      MuscleGroup,
      PrefetchHooks Function({
        bool sessionMuscleGroupsRefs,
        bool muscleRecoveriesRefs,
        bool recoveryHistoryLogsRefs,
      })
    >;
typedef $$TrainingSessionsTableCreateCompanionBuilder =
    TrainingSessionsCompanion Function({
      required String id,
      required String name,
      Value<String?> description,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isDone,
      Value<int> rowid,
    });
typedef $$TrainingSessionsTableUpdateCompanionBuilder =
    TrainingSessionsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> description,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isDone,
      Value<int> rowid,
    });

final class $$TrainingSessionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $TrainingSessionsTable, TrainingSession> {
  $$TrainingSessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $SessionMuscleGroupsTable,
    List<SessionMuscleGroup>
  >
  _sessionMuscleGroupsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.sessionMuscleGroups,
        aliasName: $_aliasNameGenerator(
          db.trainingSessions.id,
          db.sessionMuscleGroups.sessionId,
        ),
      );

  $$SessionMuscleGroupsTableProcessedTableManager get sessionMuscleGroupsRefs {
    final manager = $$SessionMuscleGroupsTableTableManager(
      $_db,
      $_db.sessionMuscleGroups,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _sessionMuscleGroupsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WorkoutSessionsTable, List<WorkoutSession>>
  _workoutSessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.workoutSessions,
    aliasName: $_aliasNameGenerator(
      db.trainingSessions.id,
      db.workoutSessions.trainingSessionId,
    ),
  );

  $$WorkoutSessionsTableProcessedTableManager get workoutSessionsRefs {
    final manager =
        $$WorkoutSessionsTableTableManager($_db, $_db.workoutSessions).filter(
          (f) => f.trainingSessionId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _workoutSessionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TrainingSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $TrainingSessionsTable> {
  $$TrainingSessionsTableFilterComposer({
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

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDone => $composableBuilder(
    column: $table.isDone,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sessionMuscleGroupsRefs(
    Expression<bool> Function($$SessionMuscleGroupsTableFilterComposer f) f,
  ) {
    final $$SessionMuscleGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessionMuscleGroups,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionMuscleGroupsTableFilterComposer(
            $db: $db,
            $table: $db.sessionMuscleGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> workoutSessionsRefs(
    Expression<bool> Function($$WorkoutSessionsTableFilterComposer f) f,
  ) {
    final $$WorkoutSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutSessions,
      getReferencedColumn: (t) => t.trainingSessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSessionsTableFilterComposer(
            $db: $db,
            $table: $db.workoutSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TrainingSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TrainingSessionsTable> {
  $$TrainingSessionsTableOrderingComposer({
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

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDone => $composableBuilder(
    column: $table.isDone,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TrainingSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrainingSessionsTable> {
  $$TrainingSessionsTableAnnotationComposer({
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

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDone =>
      $composableBuilder(column: $table.isDone, builder: (column) => column);

  Expression<T> sessionMuscleGroupsRefs<T extends Object>(
    Expression<T> Function($$SessionMuscleGroupsTableAnnotationComposer a) f,
  ) {
    final $$SessionMuscleGroupsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.sessionMuscleGroups,
          getReferencedColumn: (t) => t.sessionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SessionMuscleGroupsTableAnnotationComposer(
                $db: $db,
                $table: $db.sessionMuscleGroups,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> workoutSessionsRefs<T extends Object>(
    Expression<T> Function($$WorkoutSessionsTableAnnotationComposer a) f,
  ) {
    final $$WorkoutSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutSessions,
      getReferencedColumn: (t) => t.trainingSessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.workoutSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TrainingSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrainingSessionsTable,
          TrainingSession,
          $$TrainingSessionsTableFilterComposer,
          $$TrainingSessionsTableOrderingComposer,
          $$TrainingSessionsTableAnnotationComposer,
          $$TrainingSessionsTableCreateCompanionBuilder,
          $$TrainingSessionsTableUpdateCompanionBuilder,
          (TrainingSession, $$TrainingSessionsTableReferences),
          TrainingSession,
          PrefetchHooks Function({
            bool sessionMuscleGroupsRefs,
            bool workoutSessionsRefs,
          })
        > {
  $$TrainingSessionsTableTableManager(
    _$AppDatabase db,
    $TrainingSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrainingSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrainingSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrainingSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDone = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrainingSessionsCompanion(
                id: id,
                name: name,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isDone: isDone,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDone = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrainingSessionsCompanion.insert(
                id: id,
                name: name,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isDone: isDone,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TrainingSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({sessionMuscleGroupsRefs = false, workoutSessionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (sessionMuscleGroupsRefs) db.sessionMuscleGroups,
                    if (workoutSessionsRefs) db.workoutSessions,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (sessionMuscleGroupsRefs)
                        await $_getPrefetchedData<
                          TrainingSession,
                          $TrainingSessionsTable,
                          SessionMuscleGroup
                        >(
                          currentTable: table,
                          referencedTable: $$TrainingSessionsTableReferences
                              ._sessionMuscleGroupsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TrainingSessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).sessionMuscleGroupsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (workoutSessionsRefs)
                        await $_getPrefetchedData<
                          TrainingSession,
                          $TrainingSessionsTable,
                          WorkoutSession
                        >(
                          currentTable: table,
                          referencedTable: $$TrainingSessionsTableReferences
                              ._workoutSessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TrainingSessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).workoutSessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.trainingSessionId == item.id,
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

typedef $$TrainingSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrainingSessionsTable,
      TrainingSession,
      $$TrainingSessionsTableFilterComposer,
      $$TrainingSessionsTableOrderingComposer,
      $$TrainingSessionsTableAnnotationComposer,
      $$TrainingSessionsTableCreateCompanionBuilder,
      $$TrainingSessionsTableUpdateCompanionBuilder,
      (TrainingSession, $$TrainingSessionsTableReferences),
      TrainingSession,
      PrefetchHooks Function({
        bool sessionMuscleGroupsRefs,
        bool workoutSessionsRefs,
      })
    >;
typedef $$SessionMuscleGroupsTableCreateCompanionBuilder =
    SessionMuscleGroupsCompanion Function({
      required String id,
      required String sessionId,
      required String muscleGroupId,
      Value<int> order,
      Value<bool> isDone,
      Value<int> rowid,
    });
typedef $$SessionMuscleGroupsTableUpdateCompanionBuilder =
    SessionMuscleGroupsCompanion Function({
      Value<String> id,
      Value<String> sessionId,
      Value<String> muscleGroupId,
      Value<int> order,
      Value<bool> isDone,
      Value<int> rowid,
    });

final class $$SessionMuscleGroupsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SessionMuscleGroupsTable,
          SessionMuscleGroup
        > {
  $$SessionMuscleGroupsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TrainingSessionsTable _sessionIdTable(_$AppDatabase db) =>
      db.trainingSessions.createAlias(
        $_aliasNameGenerator(
          db.sessionMuscleGroups.sessionId,
          db.trainingSessions.id,
        ),
      );

  $$TrainingSessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$TrainingSessionsTableTableManager(
      $_db,
      $_db.trainingSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MuscleGroupsTable _muscleGroupIdTable(_$AppDatabase db) =>
      db.muscleGroups.createAlias(
        $_aliasNameGenerator(
          db.sessionMuscleGroups.muscleGroupId,
          db.muscleGroups.id,
        ),
      );

  $$MuscleGroupsTableProcessedTableManager get muscleGroupId {
    final $_column = $_itemColumn<String>('muscle_group_id')!;

    final manager = $$MuscleGroupsTableTableManager(
      $_db,
      $_db.muscleGroups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_muscleGroupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ExercisesTable, List<Exercise>>
  _exercisesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.exercises,
    aliasName: $_aliasNameGenerator(
      db.sessionMuscleGroups.id,
      db.exercises.sessionMuscleGroupId,
    ),
  );

  $$ExercisesTableProcessedTableManager get exercisesRefs {
    final manager = $$ExercisesTableTableManager($_db, $_db.exercises).filter(
      (f) => f.sessionMuscleGroupId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_exercisesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WorkoutSessionsTable, List<WorkoutSession>>
  _workoutSessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.workoutSessions,
    aliasName: $_aliasNameGenerator(
      db.sessionMuscleGroups.id,
      db.workoutSessions.sessionMuscleGroupId,
    ),
  );

  $$WorkoutSessionsTableProcessedTableManager get workoutSessionsRefs {
    final manager =
        $$WorkoutSessionsTableTableManager($_db, $_db.workoutSessions).filter(
          (f) =>
              f.sessionMuscleGroupId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _workoutSessionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SessionMuscleGroupsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionMuscleGroupsTable> {
  $$SessionMuscleGroupsTableFilterComposer({
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

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDone => $composableBuilder(
    column: $table.isDone,
    builder: (column) => ColumnFilters(column),
  );

  $$TrainingSessionsTableFilterComposer get sessionId {
    final $$TrainingSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.trainingSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrainingSessionsTableFilterComposer(
            $db: $db,
            $table: $db.trainingSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MuscleGroupsTableFilterComposer get muscleGroupId {
    final $$MuscleGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.muscleGroupId,
      referencedTable: $db.muscleGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MuscleGroupsTableFilterComposer(
            $db: $db,
            $table: $db.muscleGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> exercisesRefs(
    Expression<bool> Function($$ExercisesTableFilterComposer f) f,
  ) {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.sessionMuscleGroupId,
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

  Expression<bool> workoutSessionsRefs(
    Expression<bool> Function($$WorkoutSessionsTableFilterComposer f) f,
  ) {
    final $$WorkoutSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutSessions,
      getReferencedColumn: (t) => t.sessionMuscleGroupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSessionsTableFilterComposer(
            $db: $db,
            $table: $db.workoutSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SessionMuscleGroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionMuscleGroupsTable> {
  $$SessionMuscleGroupsTableOrderingComposer({
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

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDone => $composableBuilder(
    column: $table.isDone,
    builder: (column) => ColumnOrderings(column),
  );

  $$TrainingSessionsTableOrderingComposer get sessionId {
    final $$TrainingSessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.trainingSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrainingSessionsTableOrderingComposer(
            $db: $db,
            $table: $db.trainingSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MuscleGroupsTableOrderingComposer get muscleGroupId {
    final $$MuscleGroupsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.muscleGroupId,
      referencedTable: $db.muscleGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MuscleGroupsTableOrderingComposer(
            $db: $db,
            $table: $db.muscleGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionMuscleGroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionMuscleGroupsTable> {
  $$SessionMuscleGroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<bool> get isDone =>
      $composableBuilder(column: $table.isDone, builder: (column) => column);

  $$TrainingSessionsTableAnnotationComposer get sessionId {
    final $$TrainingSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.trainingSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrainingSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.trainingSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MuscleGroupsTableAnnotationComposer get muscleGroupId {
    final $$MuscleGroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.muscleGroupId,
      referencedTable: $db.muscleGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MuscleGroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.muscleGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> exercisesRefs<T extends Object>(
    Expression<T> Function($$ExercisesTableAnnotationComposer a) f,
  ) {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.sessionMuscleGroupId,
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

  Expression<T> workoutSessionsRefs<T extends Object>(
    Expression<T> Function($$WorkoutSessionsTableAnnotationComposer a) f,
  ) {
    final $$WorkoutSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutSessions,
      getReferencedColumn: (t) => t.sessionMuscleGroupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.workoutSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SessionMuscleGroupsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionMuscleGroupsTable,
          SessionMuscleGroup,
          $$SessionMuscleGroupsTableFilterComposer,
          $$SessionMuscleGroupsTableOrderingComposer,
          $$SessionMuscleGroupsTableAnnotationComposer,
          $$SessionMuscleGroupsTableCreateCompanionBuilder,
          $$SessionMuscleGroupsTableUpdateCompanionBuilder,
          (SessionMuscleGroup, $$SessionMuscleGroupsTableReferences),
          SessionMuscleGroup,
          PrefetchHooks Function({
            bool sessionId,
            bool muscleGroupId,
            bool exercisesRefs,
            bool workoutSessionsRefs,
          })
        > {
  $$SessionMuscleGroupsTableTableManager(
    _$AppDatabase db,
    $SessionMuscleGroupsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionMuscleGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionMuscleGroupsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SessionMuscleGroupsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String> muscleGroupId = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<bool> isDone = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionMuscleGroupsCompanion(
                id: id,
                sessionId: sessionId,
                muscleGroupId: muscleGroupId,
                order: order,
                isDone: isDone,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sessionId,
                required String muscleGroupId,
                Value<int> order = const Value.absent(),
                Value<bool> isDone = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionMuscleGroupsCompanion.insert(
                id: id,
                sessionId: sessionId,
                muscleGroupId: muscleGroupId,
                order: order,
                isDone: isDone,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SessionMuscleGroupsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                sessionId = false,
                muscleGroupId = false,
                exercisesRefs = false,
                workoutSessionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (exercisesRefs) db.exercises,
                    if (workoutSessionsRefs) db.workoutSessions,
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
                        if (sessionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sessionId,
                                    referencedTable:
                                        $$SessionMuscleGroupsTableReferences
                                            ._sessionIdTable(db),
                                    referencedColumn:
                                        $$SessionMuscleGroupsTableReferences
                                            ._sessionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (muscleGroupId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.muscleGroupId,
                                    referencedTable:
                                        $$SessionMuscleGroupsTableReferences
                                            ._muscleGroupIdTable(db),
                                    referencedColumn:
                                        $$SessionMuscleGroupsTableReferences
                                            ._muscleGroupIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (exercisesRefs)
                        await $_getPrefetchedData<
                          SessionMuscleGroup,
                          $SessionMuscleGroupsTable,
                          Exercise
                        >(
                          currentTable: table,
                          referencedTable: $$SessionMuscleGroupsTableReferences
                              ._exercisesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SessionMuscleGroupsTableReferences(
                                db,
                                table,
                                p0,
                              ).exercisesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionMuscleGroupId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (workoutSessionsRefs)
                        await $_getPrefetchedData<
                          SessionMuscleGroup,
                          $SessionMuscleGroupsTable,
                          WorkoutSession
                        >(
                          currentTable: table,
                          referencedTable: $$SessionMuscleGroupsTableReferences
                              ._workoutSessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SessionMuscleGroupsTableReferences(
                                db,
                                table,
                                p0,
                              ).workoutSessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionMuscleGroupId == item.id,
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

typedef $$SessionMuscleGroupsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionMuscleGroupsTable,
      SessionMuscleGroup,
      $$SessionMuscleGroupsTableFilterComposer,
      $$SessionMuscleGroupsTableOrderingComposer,
      $$SessionMuscleGroupsTableAnnotationComposer,
      $$SessionMuscleGroupsTableCreateCompanionBuilder,
      $$SessionMuscleGroupsTableUpdateCompanionBuilder,
      (SessionMuscleGroup, $$SessionMuscleGroupsTableReferences),
      SessionMuscleGroup,
      PrefetchHooks Function({
        bool sessionId,
        bool muscleGroupId,
        bool exercisesRefs,
        bool workoutSessionsRefs,
      })
    >;
typedef $$ExercisesTableCreateCompanionBuilder =
    ExercisesCompanion Function({
      required String id,
      required String sessionMuscleGroupId,
      required String name,
      required int plannedSeries,
      required int plannedReps,
      Value<int> intervalSeconds,
      Value<int> order,
      Value<bool> isUnilateral,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$ExercisesTableUpdateCompanionBuilder =
    ExercisesCompanion Function({
      Value<String> id,
      Value<String> sessionMuscleGroupId,
      Value<String> name,
      Value<int> plannedSeries,
      Value<int> plannedReps,
      Value<int> intervalSeconds,
      Value<int> order,
      Value<bool> isUnilateral,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$ExercisesTableReferences
    extends BaseReferences<_$AppDatabase, $ExercisesTable, Exercise> {
  $$ExercisesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SessionMuscleGroupsTable _sessionMuscleGroupIdTable(
    _$AppDatabase db,
  ) => db.sessionMuscleGroups.createAlias(
    $_aliasNameGenerator(
      db.exercises.sessionMuscleGroupId,
      db.sessionMuscleGroups.id,
    ),
  );

  $$SessionMuscleGroupsTableProcessedTableManager get sessionMuscleGroupId {
    final $_column = $_itemColumn<String>('session_muscle_group_id')!;

    final manager = $$SessionMuscleGroupsTableTableManager(
      $_db,
      $_db.sessionMuscleGroups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _sessionMuscleGroupIdTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ExerciseSeriesListTable, List<ExerciseSeries>>
  _exerciseSeriesListRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.exerciseSeriesList,
        aliasName: $_aliasNameGenerator(
          db.exercises.id,
          db.exerciseSeriesList.exerciseId,
        ),
      );

  $$ExerciseSeriesListTableProcessedTableManager get exerciseSeriesListRefs {
    final manager = $$ExerciseSeriesListTableTableManager(
      $_db,
      $_db.exerciseSeriesList,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _exerciseSeriesListRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WorkoutHistoriesTable, List<WorkoutHistory>>
  _workoutHistoriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.workoutHistories,
    aliasName: $_aliasNameGenerator(
      db.exercises.id,
      db.workoutHistories.exerciseId,
    ),
  );

  $$WorkoutHistoriesTableProcessedTableManager get workoutHistoriesRefs {
    final manager = $$WorkoutHistoriesTableTableManager(
      $_db,
      $_db.workoutHistories,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _workoutHistoriesRefsTable($_db),
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

  ColumnFilters<int> get plannedSeries => $composableBuilder(
    column: $table.plannedSeries,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get plannedReps => $composableBuilder(
    column: $table.plannedReps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalSeconds => $composableBuilder(
    column: $table.intervalSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isUnilateral => $composableBuilder(
    column: $table.isUnilateral,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SessionMuscleGroupsTableFilterComposer get sessionMuscleGroupId {
    final $$SessionMuscleGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionMuscleGroupId,
      referencedTable: $db.sessionMuscleGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionMuscleGroupsTableFilterComposer(
            $db: $db,
            $table: $db.sessionMuscleGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> exerciseSeriesListRefs(
    Expression<bool> Function($$ExerciseSeriesListTableFilterComposer f) f,
  ) {
    final $$ExerciseSeriesListTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exerciseSeriesList,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseSeriesListTableFilterComposer(
            $db: $db,
            $table: $db.exerciseSeriesList,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> workoutHistoriesRefs(
    Expression<bool> Function($$WorkoutHistoriesTableFilterComposer f) f,
  ) {
    final $$WorkoutHistoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutHistories,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutHistoriesTableFilterComposer(
            $db: $db,
            $table: $db.workoutHistories,
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

  ColumnOrderings<int> get plannedSeries => $composableBuilder(
    column: $table.plannedSeries,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get plannedReps => $composableBuilder(
    column: $table.plannedReps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalSeconds => $composableBuilder(
    column: $table.intervalSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isUnilateral => $composableBuilder(
    column: $table.isUnilateral,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SessionMuscleGroupsTableOrderingComposer get sessionMuscleGroupId {
    final $$SessionMuscleGroupsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.sessionMuscleGroupId,
          referencedTable: $db.sessionMuscleGroups,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SessionMuscleGroupsTableOrderingComposer(
                $db: $db,
                $table: $db.sessionMuscleGroups,
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

  GeneratedColumn<int> get plannedSeries => $composableBuilder(
    column: $table.plannedSeries,
    builder: (column) => column,
  );

  GeneratedColumn<int> get plannedReps => $composableBuilder(
    column: $table.plannedReps,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intervalSeconds => $composableBuilder(
    column: $table.intervalSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<bool> get isUnilateral => $composableBuilder(
    column: $table.isUnilateral,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SessionMuscleGroupsTableAnnotationComposer get sessionMuscleGroupId {
    final $$SessionMuscleGroupsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.sessionMuscleGroupId,
          referencedTable: $db.sessionMuscleGroups,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SessionMuscleGroupsTableAnnotationComposer(
                $db: $db,
                $table: $db.sessionMuscleGroups,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> exerciseSeriesListRefs<T extends Object>(
    Expression<T> Function($$ExerciseSeriesListTableAnnotationComposer a) f,
  ) {
    final $$ExerciseSeriesListTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.exerciseSeriesList,
          getReferencedColumn: (t) => t.exerciseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ExerciseSeriesListTableAnnotationComposer(
                $db: $db,
                $table: $db.exerciseSeriesList,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> workoutHistoriesRefs<T extends Object>(
    Expression<T> Function($$WorkoutHistoriesTableAnnotationComposer a) f,
  ) {
    final $$WorkoutHistoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutHistories,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutHistoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.workoutHistories,
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
          Exercise,
          $$ExercisesTableFilterComposer,
          $$ExercisesTableOrderingComposer,
          $$ExercisesTableAnnotationComposer,
          $$ExercisesTableCreateCompanionBuilder,
          $$ExercisesTableUpdateCompanionBuilder,
          (Exercise, $$ExercisesTableReferences),
          Exercise,
          PrefetchHooks Function({
            bool sessionMuscleGroupId,
            bool exerciseSeriesListRefs,
            bool workoutHistoriesRefs,
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
                Value<String> sessionMuscleGroupId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> plannedSeries = const Value.absent(),
                Value<int> plannedReps = const Value.absent(),
                Value<int> intervalSeconds = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<bool> isUnilateral = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExercisesCompanion(
                id: id,
                sessionMuscleGroupId: sessionMuscleGroupId,
                name: name,
                plannedSeries: plannedSeries,
                plannedReps: plannedReps,
                intervalSeconds: intervalSeconds,
                order: order,
                isUnilateral: isUnilateral,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sessionMuscleGroupId,
                required String name,
                required int plannedSeries,
                required int plannedReps,
                Value<int> intervalSeconds = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<bool> isUnilateral = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExercisesCompanion.insert(
                id: id,
                sessionMuscleGroupId: sessionMuscleGroupId,
                name: name,
                plannedSeries: plannedSeries,
                plannedReps: plannedReps,
                intervalSeconds: intervalSeconds,
                order: order,
                isUnilateral: isUnilateral,
                createdAt: createdAt,
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
                sessionMuscleGroupId = false,
                exerciseSeriesListRefs = false,
                workoutHistoriesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (exerciseSeriesListRefs) db.exerciseSeriesList,
                    if (workoutHistoriesRefs) db.workoutHistories,
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
                        if (sessionMuscleGroupId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sessionMuscleGroupId,
                                    referencedTable: $$ExercisesTableReferences
                                        ._sessionMuscleGroupIdTable(db),
                                    referencedColumn: $$ExercisesTableReferences
                                        ._sessionMuscleGroupIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (exerciseSeriesListRefs)
                        await $_getPrefetchedData<
                          Exercise,
                          $ExercisesTable,
                          ExerciseSeries
                        >(
                          currentTable: table,
                          referencedTable: $$ExercisesTableReferences
                              ._exerciseSeriesListRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExercisesTableReferences(
                                db,
                                table,
                                p0,
                              ).exerciseSeriesListRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (workoutHistoriesRefs)
                        await $_getPrefetchedData<
                          Exercise,
                          $ExercisesTable,
                          WorkoutHistory
                        >(
                          currentTable: table,
                          referencedTable: $$ExercisesTableReferences
                              ._workoutHistoriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExercisesTableReferences(
                                db,
                                table,
                                p0,
                              ).workoutHistoriesRefs,
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
      Exercise,
      $$ExercisesTableFilterComposer,
      $$ExercisesTableOrderingComposer,
      $$ExercisesTableAnnotationComposer,
      $$ExercisesTableCreateCompanionBuilder,
      $$ExercisesTableUpdateCompanionBuilder,
      (Exercise, $$ExercisesTableReferences),
      Exercise,
      PrefetchHooks Function({
        bool sessionMuscleGroupId,
        bool exerciseSeriesListRefs,
        bool workoutHistoriesRefs,
      })
    >;
typedef $$ExerciseSeriesListTableCreateCompanionBuilder =
    ExerciseSeriesListCompanion Function({
      required String id,
      required String exerciseId,
      required int seriesNumber,
      Value<int?> actualReps,
      Value<double?> weightKg,
      Value<DateTime?> completedAt,
      Value<bool> isCompleted,
      Value<String?> feedback,
      Value<int> rowid,
    });
typedef $$ExerciseSeriesListTableUpdateCompanionBuilder =
    ExerciseSeriesListCompanion Function({
      Value<String> id,
      Value<String> exerciseId,
      Value<int> seriesNumber,
      Value<int?> actualReps,
      Value<double?> weightKg,
      Value<DateTime?> completedAt,
      Value<bool> isCompleted,
      Value<String?> feedback,
      Value<int> rowid,
    });

final class $$ExerciseSeriesListTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ExerciseSeriesListTable,
          ExerciseSeries
        > {
  $$ExerciseSeriesListTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
        $_aliasNameGenerator(db.exerciseSeriesList.exerciseId, db.exercises.id),
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

class $$ExerciseSeriesListTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseSeriesListTable> {
  $$ExerciseSeriesListTableFilterComposer({
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

  ColumnFilters<int> get seriesNumber => $composableBuilder(
    column: $table.seriesNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get actualReps => $composableBuilder(
    column: $table.actualReps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get feedback => $composableBuilder(
    column: $table.feedback,
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

class $$ExerciseSeriesListTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseSeriesListTable> {
  $$ExerciseSeriesListTableOrderingComposer({
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

  ColumnOrderings<int> get seriesNumber => $composableBuilder(
    column: $table.seriesNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get actualReps => $composableBuilder(
    column: $table.actualReps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get feedback => $composableBuilder(
    column: $table.feedback,
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

class $$ExerciseSeriesListTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseSeriesListTable> {
  $$ExerciseSeriesListTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get seriesNumber => $composableBuilder(
    column: $table.seriesNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get actualReps => $composableBuilder(
    column: $table.actualReps,
    builder: (column) => column,
  );

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<String> get feedback =>
      $composableBuilder(column: $table.feedback, builder: (column) => column);

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

class $$ExerciseSeriesListTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExerciseSeriesListTable,
          ExerciseSeries,
          $$ExerciseSeriesListTableFilterComposer,
          $$ExerciseSeriesListTableOrderingComposer,
          $$ExerciseSeriesListTableAnnotationComposer,
          $$ExerciseSeriesListTableCreateCompanionBuilder,
          $$ExerciseSeriesListTableUpdateCompanionBuilder,
          (ExerciseSeries, $$ExerciseSeriesListTableReferences),
          ExerciseSeries,
          PrefetchHooks Function({bool exerciseId})
        > {
  $$ExerciseSeriesListTableTableManager(
    _$AppDatabase db,
    $ExerciseSeriesListTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseSeriesListTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseSeriesListTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseSeriesListTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<int> seriesNumber = const Value.absent(),
                Value<int?> actualReps = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<String?> feedback = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExerciseSeriesListCompanion(
                id: id,
                exerciseId: exerciseId,
                seriesNumber: seriesNumber,
                actualReps: actualReps,
                weightKg: weightKg,
                completedAt: completedAt,
                isCompleted: isCompleted,
                feedback: feedback,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String exerciseId,
                required int seriesNumber,
                Value<int?> actualReps = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<String?> feedback = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExerciseSeriesListCompanion.insert(
                id: id,
                exerciseId: exerciseId,
                seriesNumber: seriesNumber,
                actualReps: actualReps,
                weightKg: weightKg,
                completedAt: completedAt,
                isCompleted: isCompleted,
                feedback: feedback,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExerciseSeriesListTableReferences(db, table, e),
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
                                    $$ExerciseSeriesListTableReferences
                                        ._exerciseIdTable(db),
                                referencedColumn:
                                    $$ExerciseSeriesListTableReferences
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

typedef $$ExerciseSeriesListTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExerciseSeriesListTable,
      ExerciseSeries,
      $$ExerciseSeriesListTableFilterComposer,
      $$ExerciseSeriesListTableOrderingComposer,
      $$ExerciseSeriesListTableAnnotationComposer,
      $$ExerciseSeriesListTableCreateCompanionBuilder,
      $$ExerciseSeriesListTableUpdateCompanionBuilder,
      (ExerciseSeries, $$ExerciseSeriesListTableReferences),
      ExerciseSeries,
      PrefetchHooks Function({bool exerciseId})
    >;
typedef $$WorkoutSessionsTableCreateCompanionBuilder =
    WorkoutSessionsCompanion Function({
      required String id,
      required String trainingSessionId,
      required String sessionMuscleGroupId,
      Value<DateTime> startedAt,
      Value<DateTime?> completedAt,
      Value<bool> isCompleted,
      Value<int> rowid,
    });
typedef $$WorkoutSessionsTableUpdateCompanionBuilder =
    WorkoutSessionsCompanion Function({
      Value<String> id,
      Value<String> trainingSessionId,
      Value<String> sessionMuscleGroupId,
      Value<DateTime> startedAt,
      Value<DateTime?> completedAt,
      Value<bool> isCompleted,
      Value<int> rowid,
    });

final class $$WorkoutSessionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $WorkoutSessionsTable, WorkoutSession> {
  $$WorkoutSessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TrainingSessionsTable _trainingSessionIdTable(_$AppDatabase db) =>
      db.trainingSessions.createAlias(
        $_aliasNameGenerator(
          db.workoutSessions.trainingSessionId,
          db.trainingSessions.id,
        ),
      );

  $$TrainingSessionsTableProcessedTableManager get trainingSessionId {
    final $_column = $_itemColumn<String>('training_session_id')!;

    final manager = $$TrainingSessionsTableTableManager(
      $_db,
      $_db.trainingSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_trainingSessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SessionMuscleGroupsTable _sessionMuscleGroupIdTable(
    _$AppDatabase db,
  ) => db.sessionMuscleGroups.createAlias(
    $_aliasNameGenerator(
      db.workoutSessions.sessionMuscleGroupId,
      db.sessionMuscleGroups.id,
    ),
  );

  $$SessionMuscleGroupsTableProcessedTableManager get sessionMuscleGroupId {
    final $_column = $_itemColumn<String>('session_muscle_group_id')!;

    final manager = $$SessionMuscleGroupsTableTableManager(
      $_db,
      $_db.sessionMuscleGroups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _sessionMuscleGroupIdTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$WorkoutHistoriesTable, List<WorkoutHistory>>
  _workoutHistoriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.workoutHistories,
    aliasName: $_aliasNameGenerator(
      db.workoutSessions.id,
      db.workoutHistories.workoutSessionId,
    ),
  );

  $$WorkoutHistoriesTableProcessedTableManager get workoutHistoriesRefs {
    final manager =
        $$WorkoutHistoriesTableTableManager($_db, $_db.workoutHistories).filter(
          (f) => f.workoutSessionId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _workoutHistoriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WorkoutSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableFilterComposer({
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

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  $$TrainingSessionsTableFilterComposer get trainingSessionId {
    final $$TrainingSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trainingSessionId,
      referencedTable: $db.trainingSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrainingSessionsTableFilterComposer(
            $db: $db,
            $table: $db.trainingSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SessionMuscleGroupsTableFilterComposer get sessionMuscleGroupId {
    final $$SessionMuscleGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionMuscleGroupId,
      referencedTable: $db.sessionMuscleGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionMuscleGroupsTableFilterComposer(
            $db: $db,
            $table: $db.sessionMuscleGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> workoutHistoriesRefs(
    Expression<bool> Function($$WorkoutHistoriesTableFilterComposer f) f,
  ) {
    final $$WorkoutHistoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutHistories,
      getReferencedColumn: (t) => t.workoutSessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutHistoriesTableFilterComposer(
            $db: $db,
            $table: $db.workoutHistories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WorkoutSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  $$TrainingSessionsTableOrderingComposer get trainingSessionId {
    final $$TrainingSessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trainingSessionId,
      referencedTable: $db.trainingSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrainingSessionsTableOrderingComposer(
            $db: $db,
            $table: $db.trainingSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SessionMuscleGroupsTableOrderingComposer get sessionMuscleGroupId {
    final $$SessionMuscleGroupsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.sessionMuscleGroupId,
          referencedTable: $db.sessionMuscleGroups,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SessionMuscleGroupsTableOrderingComposer(
                $db: $db,
                $table: $db.sessionMuscleGroups,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$WorkoutSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  $$TrainingSessionsTableAnnotationComposer get trainingSessionId {
    final $$TrainingSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trainingSessionId,
      referencedTable: $db.trainingSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrainingSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.trainingSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SessionMuscleGroupsTableAnnotationComposer get sessionMuscleGroupId {
    final $$SessionMuscleGroupsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.sessionMuscleGroupId,
          referencedTable: $db.sessionMuscleGroups,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SessionMuscleGroupsTableAnnotationComposer(
                $db: $db,
                $table: $db.sessionMuscleGroups,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> workoutHistoriesRefs<T extends Object>(
    Expression<T> Function($$WorkoutHistoriesTableAnnotationComposer a) f,
  ) {
    final $$WorkoutHistoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutHistories,
      getReferencedColumn: (t) => t.workoutSessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutHistoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.workoutHistories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WorkoutSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutSessionsTable,
          WorkoutSession,
          $$WorkoutSessionsTableFilterComposer,
          $$WorkoutSessionsTableOrderingComposer,
          $$WorkoutSessionsTableAnnotationComposer,
          $$WorkoutSessionsTableCreateCompanionBuilder,
          $$WorkoutSessionsTableUpdateCompanionBuilder,
          (WorkoutSession, $$WorkoutSessionsTableReferences),
          WorkoutSession,
          PrefetchHooks Function({
            bool trainingSessionId,
            bool sessionMuscleGroupId,
            bool workoutHistoriesRefs,
          })
        > {
  $$WorkoutSessionsTableTableManager(
    _$AppDatabase db,
    $WorkoutSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> trainingSessionId = const Value.absent(),
                Value<String> sessionMuscleGroupId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutSessionsCompanion(
                id: id,
                trainingSessionId: trainingSessionId,
                sessionMuscleGroupId: sessionMuscleGroupId,
                startedAt: startedAt,
                completedAt: completedAt,
                isCompleted: isCompleted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String trainingSessionId,
                required String sessionMuscleGroupId,
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutSessionsCompanion.insert(
                id: id,
                trainingSessionId: trainingSessionId,
                sessionMuscleGroupId: sessionMuscleGroupId,
                startedAt: startedAt,
                completedAt: completedAt,
                isCompleted: isCompleted,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WorkoutSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                trainingSessionId = false,
                sessionMuscleGroupId = false,
                workoutHistoriesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (workoutHistoriesRefs) db.workoutHistories,
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
                        if (trainingSessionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.trainingSessionId,
                                    referencedTable:
                                        $$WorkoutSessionsTableReferences
                                            ._trainingSessionIdTable(db),
                                    referencedColumn:
                                        $$WorkoutSessionsTableReferences
                                            ._trainingSessionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (sessionMuscleGroupId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sessionMuscleGroupId,
                                    referencedTable:
                                        $$WorkoutSessionsTableReferences
                                            ._sessionMuscleGroupIdTable(db),
                                    referencedColumn:
                                        $$WorkoutSessionsTableReferences
                                            ._sessionMuscleGroupIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (workoutHistoriesRefs)
                        await $_getPrefetchedData<
                          WorkoutSession,
                          $WorkoutSessionsTable,
                          WorkoutHistory
                        >(
                          currentTable: table,
                          referencedTable: $$WorkoutSessionsTableReferences
                              ._workoutHistoriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WorkoutSessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).workoutHistoriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.workoutSessionId == item.id,
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

typedef $$WorkoutSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutSessionsTable,
      WorkoutSession,
      $$WorkoutSessionsTableFilterComposer,
      $$WorkoutSessionsTableOrderingComposer,
      $$WorkoutSessionsTableAnnotationComposer,
      $$WorkoutSessionsTableCreateCompanionBuilder,
      $$WorkoutSessionsTableUpdateCompanionBuilder,
      (WorkoutSession, $$WorkoutSessionsTableReferences),
      WorkoutSession,
      PrefetchHooks Function({
        bool trainingSessionId,
        bool sessionMuscleGroupId,
        bool workoutHistoriesRefs,
      })
    >;
typedef $$WorkoutHistoriesTableCreateCompanionBuilder =
    WorkoutHistoriesCompanion Function({
      required String id,
      required String workoutSessionId,
      required String exerciseId,
      required int completedSeries,
      Value<double?> maxWeightKg,
      Value<double> totalVolumeLoad,
      Value<DateTime> completedAt,
      Value<int> rowid,
    });
typedef $$WorkoutHistoriesTableUpdateCompanionBuilder =
    WorkoutHistoriesCompanion Function({
      Value<String> id,
      Value<String> workoutSessionId,
      Value<String> exerciseId,
      Value<int> completedSeries,
      Value<double?> maxWeightKg,
      Value<double> totalVolumeLoad,
      Value<DateTime> completedAt,
      Value<int> rowid,
    });

final class $$WorkoutHistoriesTableReferences
    extends
        BaseReferences<_$AppDatabase, $WorkoutHistoriesTable, WorkoutHistory> {
  $$WorkoutHistoriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WorkoutSessionsTable _workoutSessionIdTable(_$AppDatabase db) =>
      db.workoutSessions.createAlias(
        $_aliasNameGenerator(
          db.workoutHistories.workoutSessionId,
          db.workoutSessions.id,
        ),
      );

  $$WorkoutSessionsTableProcessedTableManager get workoutSessionId {
    final $_column = $_itemColumn<String>('workout_session_id')!;

    final manager = $$WorkoutSessionsTableTableManager(
      $_db,
      $_db.workoutSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workoutSessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
        $_aliasNameGenerator(db.workoutHistories.exerciseId, db.exercises.id),
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

  static MultiTypedResultKey<$WorkoutHistorySetsTable, List<WorkoutHistorySet>>
  _workoutHistorySetsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.workoutHistorySets,
        aliasName: $_aliasNameGenerator(
          db.workoutHistories.id,
          db.workoutHistorySets.workoutHistoryId,
        ),
      );

  $$WorkoutHistorySetsTableProcessedTableManager get workoutHistorySetsRefs {
    final manager =
        $$WorkoutHistorySetsTableTableManager(
          $_db,
          $_db.workoutHistorySets,
        ).filter(
          (f) => f.workoutHistoryId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _workoutHistorySetsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WorkoutHistoriesTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutHistoriesTable> {
  $$WorkoutHistoriesTableFilterComposer({
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

  ColumnFilters<int> get completedSeries => $composableBuilder(
    column: $table.completedSeries,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxWeightKg => $composableBuilder(
    column: $table.maxWeightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalVolumeLoad => $composableBuilder(
    column: $table.totalVolumeLoad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$WorkoutSessionsTableFilterComposer get workoutSessionId {
    final $$WorkoutSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workoutSessionId,
      referencedTable: $db.workoutSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSessionsTableFilterComposer(
            $db: $db,
            $table: $db.workoutSessions,
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

  Expression<bool> workoutHistorySetsRefs(
    Expression<bool> Function($$WorkoutHistorySetsTableFilterComposer f) f,
  ) {
    final $$WorkoutHistorySetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutHistorySets,
      getReferencedColumn: (t) => t.workoutHistoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutHistorySetsTableFilterComposer(
            $db: $db,
            $table: $db.workoutHistorySets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WorkoutHistoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutHistoriesTable> {
  $$WorkoutHistoriesTableOrderingComposer({
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

  ColumnOrderings<int> get completedSeries => $composableBuilder(
    column: $table.completedSeries,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxWeightKg => $composableBuilder(
    column: $table.maxWeightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalVolumeLoad => $composableBuilder(
    column: $table.totalVolumeLoad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$WorkoutSessionsTableOrderingComposer get workoutSessionId {
    final $$WorkoutSessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workoutSessionId,
      referencedTable: $db.workoutSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSessionsTableOrderingComposer(
            $db: $db,
            $table: $db.workoutSessions,
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

class $$WorkoutHistoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutHistoriesTable> {
  $$WorkoutHistoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get completedSeries => $composableBuilder(
    column: $table.completedSeries,
    builder: (column) => column,
  );

  GeneratedColumn<double> get maxWeightKg => $composableBuilder(
    column: $table.maxWeightKg,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalVolumeLoad => $composableBuilder(
    column: $table.totalVolumeLoad,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  $$WorkoutSessionsTableAnnotationComposer get workoutSessionId {
    final $$WorkoutSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workoutSessionId,
      referencedTable: $db.workoutSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.workoutSessions,
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

  Expression<T> workoutHistorySetsRefs<T extends Object>(
    Expression<T> Function($$WorkoutHistorySetsTableAnnotationComposer a) f,
  ) {
    final $$WorkoutHistorySetsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.workoutHistorySets,
          getReferencedColumn: (t) => t.workoutHistoryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WorkoutHistorySetsTableAnnotationComposer(
                $db: $db,
                $table: $db.workoutHistorySets,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$WorkoutHistoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutHistoriesTable,
          WorkoutHistory,
          $$WorkoutHistoriesTableFilterComposer,
          $$WorkoutHistoriesTableOrderingComposer,
          $$WorkoutHistoriesTableAnnotationComposer,
          $$WorkoutHistoriesTableCreateCompanionBuilder,
          $$WorkoutHistoriesTableUpdateCompanionBuilder,
          (WorkoutHistory, $$WorkoutHistoriesTableReferences),
          WorkoutHistory,
          PrefetchHooks Function({
            bool workoutSessionId,
            bool exerciseId,
            bool workoutHistorySetsRefs,
          })
        > {
  $$WorkoutHistoriesTableTableManager(
    _$AppDatabase db,
    $WorkoutHistoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutHistoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutHistoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutHistoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> workoutSessionId = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<int> completedSeries = const Value.absent(),
                Value<double?> maxWeightKg = const Value.absent(),
                Value<double> totalVolumeLoad = const Value.absent(),
                Value<DateTime> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutHistoriesCompanion(
                id: id,
                workoutSessionId: workoutSessionId,
                exerciseId: exerciseId,
                completedSeries: completedSeries,
                maxWeightKg: maxWeightKg,
                totalVolumeLoad: totalVolumeLoad,
                completedAt: completedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String workoutSessionId,
                required String exerciseId,
                required int completedSeries,
                Value<double?> maxWeightKg = const Value.absent(),
                Value<double> totalVolumeLoad = const Value.absent(),
                Value<DateTime> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutHistoriesCompanion.insert(
                id: id,
                workoutSessionId: workoutSessionId,
                exerciseId: exerciseId,
                completedSeries: completedSeries,
                maxWeightKg: maxWeightKg,
                totalVolumeLoad: totalVolumeLoad,
                completedAt: completedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WorkoutHistoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                workoutSessionId = false,
                exerciseId = false,
                workoutHistorySetsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (workoutHistorySetsRefs) db.workoutHistorySets,
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
                        if (workoutSessionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.workoutSessionId,
                                    referencedTable:
                                        $$WorkoutHistoriesTableReferences
                                            ._workoutSessionIdTable(db),
                                    referencedColumn:
                                        $$WorkoutHistoriesTableReferences
                                            ._workoutSessionIdTable(db)
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
                                        $$WorkoutHistoriesTableReferences
                                            ._exerciseIdTable(db),
                                    referencedColumn:
                                        $$WorkoutHistoriesTableReferences
                                            ._exerciseIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (workoutHistorySetsRefs)
                        await $_getPrefetchedData<
                          WorkoutHistory,
                          $WorkoutHistoriesTable,
                          WorkoutHistorySet
                        >(
                          currentTable: table,
                          referencedTable: $$WorkoutHistoriesTableReferences
                              ._workoutHistorySetsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WorkoutHistoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).workoutHistorySetsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.workoutHistoryId == item.id,
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

typedef $$WorkoutHistoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutHistoriesTable,
      WorkoutHistory,
      $$WorkoutHistoriesTableFilterComposer,
      $$WorkoutHistoriesTableOrderingComposer,
      $$WorkoutHistoriesTableAnnotationComposer,
      $$WorkoutHistoriesTableCreateCompanionBuilder,
      $$WorkoutHistoriesTableUpdateCompanionBuilder,
      (WorkoutHistory, $$WorkoutHistoriesTableReferences),
      WorkoutHistory,
      PrefetchHooks Function({
        bool workoutSessionId,
        bool exerciseId,
        bool workoutHistorySetsRefs,
      })
    >;
typedef $$MuscleRecoveriesTableCreateCompanionBuilder =
    MuscleRecoveriesCompanion Function({
      required String id,
      required String muscleGroupId,
      Value<bool> isRecovered,
      Value<DateTime?> lastWorkoutDate,
      Value<DateTime?> recoveredAt,
      Value<int> rowid,
    });
typedef $$MuscleRecoveriesTableUpdateCompanionBuilder =
    MuscleRecoveriesCompanion Function({
      Value<String> id,
      Value<String> muscleGroupId,
      Value<bool> isRecovered,
      Value<DateTime?> lastWorkoutDate,
      Value<DateTime?> recoveredAt,
      Value<int> rowid,
    });

final class $$MuscleRecoveriesTableReferences
    extends
        BaseReferences<_$AppDatabase, $MuscleRecoveriesTable, MuscleRecovery> {
  $$MuscleRecoveriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MuscleGroupsTable _muscleGroupIdTable(_$AppDatabase db) =>
      db.muscleGroups.createAlias(
        $_aliasNameGenerator(
          db.muscleRecoveries.muscleGroupId,
          db.muscleGroups.id,
        ),
      );

  $$MuscleGroupsTableProcessedTableManager get muscleGroupId {
    final $_column = $_itemColumn<String>('muscle_group_id')!;

    final manager = $$MuscleGroupsTableTableManager(
      $_db,
      $_db.muscleGroups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_muscleGroupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MuscleRecoveriesTableFilterComposer
    extends Composer<_$AppDatabase, $MuscleRecoveriesTable> {
  $$MuscleRecoveriesTableFilterComposer({
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

  ColumnFilters<bool> get isRecovered => $composableBuilder(
    column: $table.isRecovered,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastWorkoutDate => $composableBuilder(
    column: $table.lastWorkoutDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recoveredAt => $composableBuilder(
    column: $table.recoveredAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MuscleGroupsTableFilterComposer get muscleGroupId {
    final $$MuscleGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.muscleGroupId,
      referencedTable: $db.muscleGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MuscleGroupsTableFilterComposer(
            $db: $db,
            $table: $db.muscleGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MuscleRecoveriesTableOrderingComposer
    extends Composer<_$AppDatabase, $MuscleRecoveriesTable> {
  $$MuscleRecoveriesTableOrderingComposer({
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

  ColumnOrderings<bool> get isRecovered => $composableBuilder(
    column: $table.isRecovered,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastWorkoutDate => $composableBuilder(
    column: $table.lastWorkoutDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recoveredAt => $composableBuilder(
    column: $table.recoveredAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MuscleGroupsTableOrderingComposer get muscleGroupId {
    final $$MuscleGroupsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.muscleGroupId,
      referencedTable: $db.muscleGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MuscleGroupsTableOrderingComposer(
            $db: $db,
            $table: $db.muscleGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MuscleRecoveriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MuscleRecoveriesTable> {
  $$MuscleRecoveriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isRecovered => $composableBuilder(
    column: $table.isRecovered,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastWorkoutDate => $composableBuilder(
    column: $table.lastWorkoutDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get recoveredAt => $composableBuilder(
    column: $table.recoveredAt,
    builder: (column) => column,
  );

  $$MuscleGroupsTableAnnotationComposer get muscleGroupId {
    final $$MuscleGroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.muscleGroupId,
      referencedTable: $db.muscleGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MuscleGroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.muscleGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MuscleRecoveriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MuscleRecoveriesTable,
          MuscleRecovery,
          $$MuscleRecoveriesTableFilterComposer,
          $$MuscleRecoveriesTableOrderingComposer,
          $$MuscleRecoveriesTableAnnotationComposer,
          $$MuscleRecoveriesTableCreateCompanionBuilder,
          $$MuscleRecoveriesTableUpdateCompanionBuilder,
          (MuscleRecovery, $$MuscleRecoveriesTableReferences),
          MuscleRecovery,
          PrefetchHooks Function({bool muscleGroupId})
        > {
  $$MuscleRecoveriesTableTableManager(
    _$AppDatabase db,
    $MuscleRecoveriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MuscleRecoveriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MuscleRecoveriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MuscleRecoveriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> muscleGroupId = const Value.absent(),
                Value<bool> isRecovered = const Value.absent(),
                Value<DateTime?> lastWorkoutDate = const Value.absent(),
                Value<DateTime?> recoveredAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MuscleRecoveriesCompanion(
                id: id,
                muscleGroupId: muscleGroupId,
                isRecovered: isRecovered,
                lastWorkoutDate: lastWorkoutDate,
                recoveredAt: recoveredAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String muscleGroupId,
                Value<bool> isRecovered = const Value.absent(),
                Value<DateTime?> lastWorkoutDate = const Value.absent(),
                Value<DateTime?> recoveredAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MuscleRecoveriesCompanion.insert(
                id: id,
                muscleGroupId: muscleGroupId,
                isRecovered: isRecovered,
                lastWorkoutDate: lastWorkoutDate,
                recoveredAt: recoveredAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MuscleRecoveriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({muscleGroupId = false}) {
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
                    if (muscleGroupId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.muscleGroupId,
                                referencedTable:
                                    $$MuscleRecoveriesTableReferences
                                        ._muscleGroupIdTable(db),
                                referencedColumn:
                                    $$MuscleRecoveriesTableReferences
                                        ._muscleGroupIdTable(db)
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

typedef $$MuscleRecoveriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MuscleRecoveriesTable,
      MuscleRecovery,
      $$MuscleRecoveriesTableFilterComposer,
      $$MuscleRecoveriesTableOrderingComposer,
      $$MuscleRecoveriesTableAnnotationComposer,
      $$MuscleRecoveriesTableCreateCompanionBuilder,
      $$MuscleRecoveriesTableUpdateCompanionBuilder,
      (MuscleRecovery, $$MuscleRecoveriesTableReferences),
      MuscleRecovery,
      PrefetchHooks Function({bool muscleGroupId})
    >;
typedef $$WorkoutHistorySetsTableCreateCompanionBuilder =
    WorkoutHistorySetsCompanion Function({
      required String id,
      required String workoutHistoryId,
      required int reps,
      required double weightKg,
      required int seriesOrder,
      Value<String?> feedback,
      Value<int> rowid,
    });
typedef $$WorkoutHistorySetsTableUpdateCompanionBuilder =
    WorkoutHistorySetsCompanion Function({
      Value<String> id,
      Value<String> workoutHistoryId,
      Value<int> reps,
      Value<double> weightKg,
      Value<int> seriesOrder,
      Value<String?> feedback,
      Value<int> rowid,
    });

final class $$WorkoutHistorySetsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $WorkoutHistorySetsTable,
          WorkoutHistorySet
        > {
  $$WorkoutHistorySetsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WorkoutHistoriesTable _workoutHistoryIdTable(_$AppDatabase db) =>
      db.workoutHistories.createAlias(
        $_aliasNameGenerator(
          db.workoutHistorySets.workoutHistoryId,
          db.workoutHistories.id,
        ),
      );

  $$WorkoutHistoriesTableProcessedTableManager get workoutHistoryId {
    final $_column = $_itemColumn<String>('workout_history_id')!;

    final manager = $$WorkoutHistoriesTableTableManager(
      $_db,
      $_db.workoutHistories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workoutHistoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WorkoutHistorySetsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutHistorySetsTable> {
  $$WorkoutHistorySetsTableFilterComposer({
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

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get seriesOrder => $composableBuilder(
    column: $table.seriesOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get feedback => $composableBuilder(
    column: $table.feedback,
    builder: (column) => ColumnFilters(column),
  );

  $$WorkoutHistoriesTableFilterComposer get workoutHistoryId {
    final $$WorkoutHistoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workoutHistoryId,
      referencedTable: $db.workoutHistories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutHistoriesTableFilterComposer(
            $db: $db,
            $table: $db.workoutHistories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkoutHistorySetsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutHistorySetsTable> {
  $$WorkoutHistorySetsTableOrderingComposer({
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

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get seriesOrder => $composableBuilder(
    column: $table.seriesOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get feedback => $composableBuilder(
    column: $table.feedback,
    builder: (column) => ColumnOrderings(column),
  );

  $$WorkoutHistoriesTableOrderingComposer get workoutHistoryId {
    final $$WorkoutHistoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workoutHistoryId,
      referencedTable: $db.workoutHistories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutHistoriesTableOrderingComposer(
            $db: $db,
            $table: $db.workoutHistories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkoutHistorySetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutHistorySetsTable> {
  $$WorkoutHistorySetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<int> get seriesOrder => $composableBuilder(
    column: $table.seriesOrder,
    builder: (column) => column,
  );

  GeneratedColumn<String> get feedback =>
      $composableBuilder(column: $table.feedback, builder: (column) => column);

  $$WorkoutHistoriesTableAnnotationComposer get workoutHistoryId {
    final $$WorkoutHistoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workoutHistoryId,
      referencedTable: $db.workoutHistories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutHistoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.workoutHistories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkoutHistorySetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutHistorySetsTable,
          WorkoutHistorySet,
          $$WorkoutHistorySetsTableFilterComposer,
          $$WorkoutHistorySetsTableOrderingComposer,
          $$WorkoutHistorySetsTableAnnotationComposer,
          $$WorkoutHistorySetsTableCreateCompanionBuilder,
          $$WorkoutHistorySetsTableUpdateCompanionBuilder,
          (WorkoutHistorySet, $$WorkoutHistorySetsTableReferences),
          WorkoutHistorySet,
          PrefetchHooks Function({bool workoutHistoryId})
        > {
  $$WorkoutHistorySetsTableTableManager(
    _$AppDatabase db,
    $WorkoutHistorySetsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutHistorySetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutHistorySetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutHistorySetsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> workoutHistoryId = const Value.absent(),
                Value<int> reps = const Value.absent(),
                Value<double> weightKg = const Value.absent(),
                Value<int> seriesOrder = const Value.absent(),
                Value<String?> feedback = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutHistorySetsCompanion(
                id: id,
                workoutHistoryId: workoutHistoryId,
                reps: reps,
                weightKg: weightKg,
                seriesOrder: seriesOrder,
                feedback: feedback,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String workoutHistoryId,
                required int reps,
                required double weightKg,
                required int seriesOrder,
                Value<String?> feedback = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutHistorySetsCompanion.insert(
                id: id,
                workoutHistoryId: workoutHistoryId,
                reps: reps,
                weightKg: weightKg,
                seriesOrder: seriesOrder,
                feedback: feedback,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WorkoutHistorySetsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({workoutHistoryId = false}) {
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
                    if (workoutHistoryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.workoutHistoryId,
                                referencedTable:
                                    $$WorkoutHistorySetsTableReferences
                                        ._workoutHistoryIdTable(db),
                                referencedColumn:
                                    $$WorkoutHistorySetsTableReferences
                                        ._workoutHistoryIdTable(db)
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

typedef $$WorkoutHistorySetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutHistorySetsTable,
      WorkoutHistorySet,
      $$WorkoutHistorySetsTableFilterComposer,
      $$WorkoutHistorySetsTableOrderingComposer,
      $$WorkoutHistorySetsTableAnnotationComposer,
      $$WorkoutHistorySetsTableCreateCompanionBuilder,
      $$WorkoutHistorySetsTableUpdateCompanionBuilder,
      (WorkoutHistorySet, $$WorkoutHistorySetsTableReferences),
      WorkoutHistorySet,
      PrefetchHooks Function({bool workoutHistoryId})
    >;
typedef $$DailyContextsTableCreateCompanionBuilder =
    DailyContextsCompanion Function({
      required String id,
      required DateTime date,
      required String sleepTags,
      required String nutritionTags,
      required String stressTags,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$DailyContextsTableUpdateCompanionBuilder =
    DailyContextsCompanion Function({
      Value<String> id,
      Value<DateTime> date,
      Value<String> sleepTags,
      Value<String> nutritionTags,
      Value<String> stressTags,
      Value<String?> notes,
      Value<int> rowid,
    });

class $$DailyContextsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyContextsTable> {
  $$DailyContextsTableFilterComposer({
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

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sleepTags => $composableBuilder(
    column: $table.sleepTags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nutritionTags => $composableBuilder(
    column: $table.nutritionTags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stressTags => $composableBuilder(
    column: $table.stressTags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyContextsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyContextsTable> {
  $$DailyContextsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sleepTags => $composableBuilder(
    column: $table.sleepTags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nutritionTags => $composableBuilder(
    column: $table.nutritionTags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stressTags => $composableBuilder(
    column: $table.stressTags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyContextsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyContextsTable> {
  $$DailyContextsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get sleepTags =>
      $composableBuilder(column: $table.sleepTags, builder: (column) => column);

  GeneratedColumn<String> get nutritionTags => $composableBuilder(
    column: $table.nutritionTags,
    builder: (column) => column,
  );

  GeneratedColumn<String> get stressTags => $composableBuilder(
    column: $table.stressTags,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$DailyContextsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyContextsTable,
          DailyContext,
          $$DailyContextsTableFilterComposer,
          $$DailyContextsTableOrderingComposer,
          $$DailyContextsTableAnnotationComposer,
          $$DailyContextsTableCreateCompanionBuilder,
          $$DailyContextsTableUpdateCompanionBuilder,
          (
            DailyContext,
            BaseReferences<_$AppDatabase, $DailyContextsTable, DailyContext>,
          ),
          DailyContext,
          PrefetchHooks Function()
        > {
  $$DailyContextsTableTableManager(_$AppDatabase db, $DailyContextsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyContextsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyContextsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyContextsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> sleepTags = const Value.absent(),
                Value<String> nutritionTags = const Value.absent(),
                Value<String> stressTags = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyContextsCompanion(
                id: id,
                date: date,
                sleepTags: sleepTags,
                nutritionTags: nutritionTags,
                stressTags: stressTags,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime date,
                required String sleepTags,
                required String nutritionTags,
                required String stressTags,
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyContextsCompanion.insert(
                id: id,
                date: date,
                sleepTags: sleepTags,
                nutritionTags: nutritionTags,
                stressTags: stressTags,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyContextsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyContextsTable,
      DailyContext,
      $$DailyContextsTableFilterComposer,
      $$DailyContextsTableOrderingComposer,
      $$DailyContextsTableAnnotationComposer,
      $$DailyContextsTableCreateCompanionBuilder,
      $$DailyContextsTableUpdateCompanionBuilder,
      (
        DailyContext,
        BaseReferences<_$AppDatabase, $DailyContextsTable, DailyContext>,
      ),
      DailyContext,
      PrefetchHooks Function()
    >;
typedef $$RecoveryHistoryLogsTableCreateCompanionBuilder =
    RecoveryHistoryLogsCompanion Function({
      required String id,
      required String muscleGroupId,
      required DateTime fatigueDate,
      required DateTime recoveredDate,
      required int durationInHours,
      Value<int> rowid,
    });
typedef $$RecoveryHistoryLogsTableUpdateCompanionBuilder =
    RecoveryHistoryLogsCompanion Function({
      Value<String> id,
      Value<String> muscleGroupId,
      Value<DateTime> fatigueDate,
      Value<DateTime> recoveredDate,
      Value<int> durationInHours,
      Value<int> rowid,
    });

final class $$RecoveryHistoryLogsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RecoveryHistoryLogsTable,
          RecoveryHistoryLog
        > {
  $$RecoveryHistoryLogsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MuscleGroupsTable _muscleGroupIdTable(_$AppDatabase db) =>
      db.muscleGroups.createAlias(
        $_aliasNameGenerator(
          db.recoveryHistoryLogs.muscleGroupId,
          db.muscleGroups.id,
        ),
      );

  $$MuscleGroupsTableProcessedTableManager get muscleGroupId {
    final $_column = $_itemColumn<String>('muscle_group_id')!;

    final manager = $$MuscleGroupsTableTableManager(
      $_db,
      $_db.muscleGroups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_muscleGroupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecoveryHistoryLogsTableFilterComposer
    extends Composer<_$AppDatabase, $RecoveryHistoryLogsTable> {
  $$RecoveryHistoryLogsTableFilterComposer({
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

  ColumnFilters<DateTime> get fatigueDate => $composableBuilder(
    column: $table.fatigueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recoveredDate => $composableBuilder(
    column: $table.recoveredDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationInHours => $composableBuilder(
    column: $table.durationInHours,
    builder: (column) => ColumnFilters(column),
  );

  $$MuscleGroupsTableFilterComposer get muscleGroupId {
    final $$MuscleGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.muscleGroupId,
      referencedTable: $db.muscleGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MuscleGroupsTableFilterComposer(
            $db: $db,
            $table: $db.muscleGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecoveryHistoryLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $RecoveryHistoryLogsTable> {
  $$RecoveryHistoryLogsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get fatigueDate => $composableBuilder(
    column: $table.fatigueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recoveredDate => $composableBuilder(
    column: $table.recoveredDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationInHours => $composableBuilder(
    column: $table.durationInHours,
    builder: (column) => ColumnOrderings(column),
  );

  $$MuscleGroupsTableOrderingComposer get muscleGroupId {
    final $$MuscleGroupsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.muscleGroupId,
      referencedTable: $db.muscleGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MuscleGroupsTableOrderingComposer(
            $db: $db,
            $table: $db.muscleGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecoveryHistoryLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecoveryHistoryLogsTable> {
  $$RecoveryHistoryLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get fatigueDate => $composableBuilder(
    column: $table.fatigueDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get recoveredDate => $composableBuilder(
    column: $table.recoveredDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationInHours => $composableBuilder(
    column: $table.durationInHours,
    builder: (column) => column,
  );

  $$MuscleGroupsTableAnnotationComposer get muscleGroupId {
    final $$MuscleGroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.muscleGroupId,
      referencedTable: $db.muscleGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MuscleGroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.muscleGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecoveryHistoryLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecoveryHistoryLogsTable,
          RecoveryHistoryLog,
          $$RecoveryHistoryLogsTableFilterComposer,
          $$RecoveryHistoryLogsTableOrderingComposer,
          $$RecoveryHistoryLogsTableAnnotationComposer,
          $$RecoveryHistoryLogsTableCreateCompanionBuilder,
          $$RecoveryHistoryLogsTableUpdateCompanionBuilder,
          (RecoveryHistoryLog, $$RecoveryHistoryLogsTableReferences),
          RecoveryHistoryLog,
          PrefetchHooks Function({bool muscleGroupId})
        > {
  $$RecoveryHistoryLogsTableTableManager(
    _$AppDatabase db,
    $RecoveryHistoryLogsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecoveryHistoryLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecoveryHistoryLogsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$RecoveryHistoryLogsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> muscleGroupId = const Value.absent(),
                Value<DateTime> fatigueDate = const Value.absent(),
                Value<DateTime> recoveredDate = const Value.absent(),
                Value<int> durationInHours = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecoveryHistoryLogsCompanion(
                id: id,
                muscleGroupId: muscleGroupId,
                fatigueDate: fatigueDate,
                recoveredDate: recoveredDate,
                durationInHours: durationInHours,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String muscleGroupId,
                required DateTime fatigueDate,
                required DateTime recoveredDate,
                required int durationInHours,
                Value<int> rowid = const Value.absent(),
              }) => RecoveryHistoryLogsCompanion.insert(
                id: id,
                muscleGroupId: muscleGroupId,
                fatigueDate: fatigueDate,
                recoveredDate: recoveredDate,
                durationInHours: durationInHours,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RecoveryHistoryLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({muscleGroupId = false}) {
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
                    if (muscleGroupId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.muscleGroupId,
                                referencedTable:
                                    $$RecoveryHistoryLogsTableReferences
                                        ._muscleGroupIdTable(db),
                                referencedColumn:
                                    $$RecoveryHistoryLogsTableReferences
                                        ._muscleGroupIdTable(db)
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

typedef $$RecoveryHistoryLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecoveryHistoryLogsTable,
      RecoveryHistoryLog,
      $$RecoveryHistoryLogsTableFilterComposer,
      $$RecoveryHistoryLogsTableOrderingComposer,
      $$RecoveryHistoryLogsTableAnnotationComposer,
      $$RecoveryHistoryLogsTableCreateCompanionBuilder,
      $$RecoveryHistoryLogsTableUpdateCompanionBuilder,
      (RecoveryHistoryLog, $$RecoveryHistoryLogsTableReferences),
      RecoveryHistoryLog,
      PrefetchHooks Function({bool muscleGroupId})
    >;
typedef $$MealsTableCreateCompanionBuilder =
    MealsCompanion Function({
      required String id,
      required DateTime date,
      required int mealIndex,
      Value<double> calories,
      Value<double> carbs,
      Value<double> protein,
      Value<double> totalFat,
      Value<double> saturatedFat,
      Value<double> fiber,
      Value<double> sodium,
      Value<double> calcium,
      Value<int> rowid,
    });
typedef $$MealsTableUpdateCompanionBuilder =
    MealsCompanion Function({
      Value<String> id,
      Value<DateTime> date,
      Value<int> mealIndex,
      Value<double> calories,
      Value<double> carbs,
      Value<double> protein,
      Value<double> totalFat,
      Value<double> saturatedFat,
      Value<double> fiber,
      Value<double> sodium,
      Value<double> calcium,
      Value<int> rowid,
    });

class $$MealsTableFilterComposer extends Composer<_$AppDatabase, $MealsTable> {
  $$MealsTableFilterComposer({
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

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mealIndex => $composableBuilder(
    column: $table.mealIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get calories => $composableBuilder(
    column: $table.calories,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbs => $composableBuilder(
    column: $table.carbs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get protein => $composableBuilder(
    column: $table.protein,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalFat => $composableBuilder(
    column: $table.totalFat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get saturatedFat => $composableBuilder(
    column: $table.saturatedFat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fiber => $composableBuilder(
    column: $table.fiber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sodium => $composableBuilder(
    column: $table.sodium,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get calcium => $composableBuilder(
    column: $table.calcium,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MealsTableOrderingComposer
    extends Composer<_$AppDatabase, $MealsTable> {
  $$MealsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mealIndex => $composableBuilder(
    column: $table.mealIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get calories => $composableBuilder(
    column: $table.calories,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbs => $composableBuilder(
    column: $table.carbs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get protein => $composableBuilder(
    column: $table.protein,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalFat => $composableBuilder(
    column: $table.totalFat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get saturatedFat => $composableBuilder(
    column: $table.saturatedFat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fiber => $composableBuilder(
    column: $table.fiber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sodium => $composableBuilder(
    column: $table.sodium,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get calcium => $composableBuilder(
    column: $table.calcium,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MealsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealsTable> {
  $$MealsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get mealIndex =>
      $composableBuilder(column: $table.mealIndex, builder: (column) => column);

  GeneratedColumn<double> get calories =>
      $composableBuilder(column: $table.calories, builder: (column) => column);

  GeneratedColumn<double> get carbs =>
      $composableBuilder(column: $table.carbs, builder: (column) => column);

  GeneratedColumn<double> get protein =>
      $composableBuilder(column: $table.protein, builder: (column) => column);

  GeneratedColumn<double> get totalFat =>
      $composableBuilder(column: $table.totalFat, builder: (column) => column);

  GeneratedColumn<double> get saturatedFat => $composableBuilder(
    column: $table.saturatedFat,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fiber =>
      $composableBuilder(column: $table.fiber, builder: (column) => column);

  GeneratedColumn<double> get sodium =>
      $composableBuilder(column: $table.sodium, builder: (column) => column);

  GeneratedColumn<double> get calcium =>
      $composableBuilder(column: $table.calcium, builder: (column) => column);
}

class $$MealsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MealsTable,
          Meal,
          $$MealsTableFilterComposer,
          $$MealsTableOrderingComposer,
          $$MealsTableAnnotationComposer,
          $$MealsTableCreateCompanionBuilder,
          $$MealsTableUpdateCompanionBuilder,
          (Meal, BaseReferences<_$AppDatabase, $MealsTable, Meal>),
          Meal,
          PrefetchHooks Function()
        > {
  $$MealsTableTableManager(_$AppDatabase db, $MealsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> mealIndex = const Value.absent(),
                Value<double> calories = const Value.absent(),
                Value<double> carbs = const Value.absent(),
                Value<double> protein = const Value.absent(),
                Value<double> totalFat = const Value.absent(),
                Value<double> saturatedFat = const Value.absent(),
                Value<double> fiber = const Value.absent(),
                Value<double> sodium = const Value.absent(),
                Value<double> calcium = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MealsCompanion(
                id: id,
                date: date,
                mealIndex: mealIndex,
                calories: calories,
                carbs: carbs,
                protein: protein,
                totalFat: totalFat,
                saturatedFat: saturatedFat,
                fiber: fiber,
                sodium: sodium,
                calcium: calcium,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime date,
                required int mealIndex,
                Value<double> calories = const Value.absent(),
                Value<double> carbs = const Value.absent(),
                Value<double> protein = const Value.absent(),
                Value<double> totalFat = const Value.absent(),
                Value<double> saturatedFat = const Value.absent(),
                Value<double> fiber = const Value.absent(),
                Value<double> sodium = const Value.absent(),
                Value<double> calcium = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MealsCompanion.insert(
                id: id,
                date: date,
                mealIndex: mealIndex,
                calories: calories,
                carbs: carbs,
                protein: protein,
                totalFat: totalFat,
                saturatedFat: saturatedFat,
                fiber: fiber,
                sodium: sodium,
                calcium: calcium,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MealsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MealsTable,
      Meal,
      $$MealsTableFilterComposer,
      $$MealsTableOrderingComposer,
      $$MealsTableAnnotationComposer,
      $$MealsTableCreateCompanionBuilder,
      $$MealsTableUpdateCompanionBuilder,
      (Meal, BaseReferences<_$AppDatabase, $MealsTable, Meal>),
      Meal,
      PrefetchHooks Function()
    >;
typedef $$UserGoalsTableCreateCompanionBuilder =
    UserGoalsCompanion Function({
      required String id,
      Value<double> caloriesTarget,
      Value<double> carbsTarget,
      Value<double> proteinTarget,
      Value<double> fatTarget,
      Value<int> rowid,
    });
typedef $$UserGoalsTableUpdateCompanionBuilder =
    UserGoalsCompanion Function({
      Value<String> id,
      Value<double> caloriesTarget,
      Value<double> carbsTarget,
      Value<double> proteinTarget,
      Value<double> fatTarget,
      Value<int> rowid,
    });

class $$UserGoalsTableFilterComposer
    extends Composer<_$AppDatabase, $UserGoalsTable> {
  $$UserGoalsTableFilterComposer({
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

  ColumnFilters<double> get caloriesTarget => $composableBuilder(
    column: $table.caloriesTarget,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbsTarget => $composableBuilder(
    column: $table.carbsTarget,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinTarget => $composableBuilder(
    column: $table.proteinTarget,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatTarget => $composableBuilder(
    column: $table.fatTarget,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserGoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserGoalsTable> {
  $$UserGoalsTableOrderingComposer({
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

  ColumnOrderings<double> get caloriesTarget => $composableBuilder(
    column: $table.caloriesTarget,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbsTarget => $composableBuilder(
    column: $table.carbsTarget,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinTarget => $composableBuilder(
    column: $table.proteinTarget,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatTarget => $composableBuilder(
    column: $table.fatTarget,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserGoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserGoalsTable> {
  $$UserGoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get caloriesTarget => $composableBuilder(
    column: $table.caloriesTarget,
    builder: (column) => column,
  );

  GeneratedColumn<double> get carbsTarget => $composableBuilder(
    column: $table.carbsTarget,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinTarget => $composableBuilder(
    column: $table.proteinTarget,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fatTarget =>
      $composableBuilder(column: $table.fatTarget, builder: (column) => column);
}

class $$UserGoalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserGoalsTable,
          UserGoal,
          $$UserGoalsTableFilterComposer,
          $$UserGoalsTableOrderingComposer,
          $$UserGoalsTableAnnotationComposer,
          $$UserGoalsTableCreateCompanionBuilder,
          $$UserGoalsTableUpdateCompanionBuilder,
          (UserGoal, BaseReferences<_$AppDatabase, $UserGoalsTable, UserGoal>),
          UserGoal,
          PrefetchHooks Function()
        > {
  $$UserGoalsTableTableManager(_$AppDatabase db, $UserGoalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserGoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserGoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserGoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<double> caloriesTarget = const Value.absent(),
                Value<double> carbsTarget = const Value.absent(),
                Value<double> proteinTarget = const Value.absent(),
                Value<double> fatTarget = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserGoalsCompanion(
                id: id,
                caloriesTarget: caloriesTarget,
                carbsTarget: carbsTarget,
                proteinTarget: proteinTarget,
                fatTarget: fatTarget,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<double> caloriesTarget = const Value.absent(),
                Value<double> carbsTarget = const Value.absent(),
                Value<double> proteinTarget = const Value.absent(),
                Value<double> fatTarget = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserGoalsCompanion.insert(
                id: id,
                caloriesTarget: caloriesTarget,
                carbsTarget: carbsTarget,
                proteinTarget: proteinTarget,
                fatTarget: fatTarget,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserGoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserGoalsTable,
      UserGoal,
      $$UserGoalsTableFilterComposer,
      $$UserGoalsTableOrderingComposer,
      $$UserGoalsTableAnnotationComposer,
      $$UserGoalsTableCreateCompanionBuilder,
      $$UserGoalsTableUpdateCompanionBuilder,
      (UserGoal, BaseReferences<_$AppDatabase, $UserGoalsTable, UserGoal>),
      UserGoal,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MuscleGroupsTableTableManager get muscleGroups =>
      $$MuscleGroupsTableTableManager(_db, _db.muscleGroups);
  $$TrainingSessionsTableTableManager get trainingSessions =>
      $$TrainingSessionsTableTableManager(_db, _db.trainingSessions);
  $$SessionMuscleGroupsTableTableManager get sessionMuscleGroups =>
      $$SessionMuscleGroupsTableTableManager(_db, _db.sessionMuscleGroups);
  $$ExercisesTableTableManager get exercises =>
      $$ExercisesTableTableManager(_db, _db.exercises);
  $$ExerciseSeriesListTableTableManager get exerciseSeriesList =>
      $$ExerciseSeriesListTableTableManager(_db, _db.exerciseSeriesList);
  $$WorkoutSessionsTableTableManager get workoutSessions =>
      $$WorkoutSessionsTableTableManager(_db, _db.workoutSessions);
  $$WorkoutHistoriesTableTableManager get workoutHistories =>
      $$WorkoutHistoriesTableTableManager(_db, _db.workoutHistories);
  $$MuscleRecoveriesTableTableManager get muscleRecoveries =>
      $$MuscleRecoveriesTableTableManager(_db, _db.muscleRecoveries);
  $$WorkoutHistorySetsTableTableManager get workoutHistorySets =>
      $$WorkoutHistorySetsTableTableManager(_db, _db.workoutHistorySets);
  $$DailyContextsTableTableManager get dailyContexts =>
      $$DailyContextsTableTableManager(_db, _db.dailyContexts);
  $$RecoveryHistoryLogsTableTableManager get recoveryHistoryLogs =>
      $$RecoveryHistoryLogsTableTableManager(_db, _db.recoveryHistoryLogs);
  $$MealsTableTableManager get meals =>
      $$MealsTableTableManager(_db, _db.meals);
  $$UserGoalsTableTableManager get userGoals =>
      $$UserGoalsTableTableManager(_db, _db.userGoals);
}
