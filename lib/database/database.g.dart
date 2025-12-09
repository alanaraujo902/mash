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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    createdAt,
    updatedAt,
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
  const TrainingSession({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
    required this.updatedAt,
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
    };
  }

  TrainingSession copyWith({
    String? id,
    String? name,
    Value<String?> description = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => TrainingSession(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
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
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrainingSession(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrainingSession &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TrainingSessionsCompanion extends UpdateCompanion<TrainingSession> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TrainingSessionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TrainingSessionsCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<TrainingSession> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TrainingSessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return TrainingSessionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
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
  @override
  List<GeneratedColumn> get $columns => [id, sessionId, muscleGroupId, order];
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
  const SessionMuscleGroup({
    required this.id,
    required this.sessionId,
    required this.muscleGroupId,
    required this.order,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['muscle_group_id'] = Variable<String>(muscleGroupId);
    map['order'] = Variable<int>(order);
    return map;
  }

  SessionMuscleGroupsCompanion toCompanion(bool nullToAbsent) {
    return SessionMuscleGroupsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      muscleGroupId: Value(muscleGroupId),
      order: Value(order),
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
    };
  }

  SessionMuscleGroup copyWith({
    String? id,
    String? sessionId,
    String? muscleGroupId,
    int? order,
  }) => SessionMuscleGroup(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    muscleGroupId: muscleGroupId ?? this.muscleGroupId,
    order: order ?? this.order,
  );
  SessionMuscleGroup copyWithCompanion(SessionMuscleGroupsCompanion data) {
    return SessionMuscleGroup(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      muscleGroupId: data.muscleGroupId.present
          ? data.muscleGroupId.value
          : this.muscleGroupId,
      order: data.order.present ? data.order.value : this.order,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionMuscleGroup(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('muscleGroupId: $muscleGroupId, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionId, muscleGroupId, order);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionMuscleGroup &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.muscleGroupId == this.muscleGroupId &&
          other.order == this.order);
}

class SessionMuscleGroupsCompanion extends UpdateCompanion<SessionMuscleGroup> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String> muscleGroupId;
  final Value<int> order;
  final Value<int> rowid;
  const SessionMuscleGroupsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.muscleGroupId = const Value.absent(),
    this.order = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionMuscleGroupsCompanion.insert({
    required String id,
    required String sessionId,
    required String muscleGroupId,
    this.order = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sessionId = Value(sessionId),
       muscleGroupId = Value(muscleGroupId);
  static Insertable<SessionMuscleGroup> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? muscleGroupId,
    Expression<int>? order,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (muscleGroupId != null) 'muscle_group_id': muscleGroupId,
      if (order != null) 'order': order,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionMuscleGroupsCompanion copyWith({
    Value<String>? id,
    Value<String>? sessionId,
    Value<String>? muscleGroupId,
    Value<int>? order,
    Value<int>? rowid,
  }) {
    return SessionMuscleGroupsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      muscleGroupId: muscleGroupId ?? this.muscleGroupId,
      order: order ?? this.order,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    exerciseId,
    seriesNumber,
    actualReps,
    weightKg,
    completedAt,
    isCompleted,
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
  const ExerciseSeries({
    required this.id,
    required this.exerciseId,
    required this.seriesNumber,
    this.actualReps,
    this.weightKg,
    this.completedAt,
    required this.isCompleted,
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
  }) => ExerciseSeries(
    id: id ?? this.id,
    exerciseId: exerciseId ?? this.exerciseId,
    seriesNumber: seriesNumber ?? this.seriesNumber,
    actualReps: actualReps.present ? actualReps.value : this.actualReps,
    weightKg: weightKg.present ? weightKg.value : this.weightKg,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    isCompleted: isCompleted ?? this.isCompleted,
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
          ..write('isCompleted: $isCompleted')
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
          other.isCompleted == this.isCompleted);
}

class ExerciseSeriesListCompanion extends UpdateCompanion<ExerciseSeries> {
  final Value<String> id;
  final Value<String> exerciseId;
  final Value<int> seriesNumber;
  final Value<int?> actualReps;
  final Value<double?> weightKg;
  final Value<DateTime?> completedAt;
  final Value<bool> isCompleted;
  final Value<int> rowid;
  const ExerciseSeriesListCompanion({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.seriesNumber = const Value.absent(),
    this.actualReps = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.isCompleted = const Value.absent(),
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    workoutHistoryId,
    reps,
    weightKg,
    seriesOrder,
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
  const WorkoutHistorySet({
    required this.id,
    required this.workoutHistoryId,
    required this.reps,
    required this.weightKg,
    required this.seriesOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workout_history_id'] = Variable<String>(workoutHistoryId);
    map['reps'] = Variable<int>(reps);
    map['weight_kg'] = Variable<double>(weightKg);
    map['series_order'] = Variable<int>(seriesOrder);
    return map;
  }

  WorkoutHistorySetsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutHistorySetsCompanion(
      id: Value(id),
      workoutHistoryId: Value(workoutHistoryId),
      reps: Value(reps),
      weightKg: Value(weightKg),
      seriesOrder: Value(seriesOrder),
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
    };
  }

  WorkoutHistorySet copyWith({
    String? id,
    String? workoutHistoryId,
    int? reps,
    double? weightKg,
    int? seriesOrder,
  }) => WorkoutHistorySet(
    id: id ?? this.id,
    workoutHistoryId: workoutHistoryId ?? this.workoutHistoryId,
    reps: reps ?? this.reps,
    weightKg: weightKg ?? this.weightKg,
    seriesOrder: seriesOrder ?? this.seriesOrder,
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
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutHistorySet(')
          ..write('id: $id, ')
          ..write('workoutHistoryId: $workoutHistoryId, ')
          ..write('reps: $reps, ')
          ..write('weightKg: $weightKg, ')
          ..write('seriesOrder: $seriesOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, workoutHistoryId, reps, weightKg, seriesOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutHistorySet &&
          other.id == this.id &&
          other.workoutHistoryId == this.workoutHistoryId &&
          other.reps == this.reps &&
          other.weightKg == this.weightKg &&
          other.seriesOrder == this.seriesOrder);
}

class WorkoutHistorySetsCompanion extends UpdateCompanion<WorkoutHistorySet> {
  final Value<String> id;
  final Value<String> workoutHistoryId;
  final Value<int> reps;
  final Value<double> weightKg;
  final Value<int> seriesOrder;
  final Value<int> rowid;
  const WorkoutHistorySetsCompanion({
    this.id = const Value.absent(),
    this.workoutHistoryId = const Value.absent(),
    this.reps = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.seriesOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutHistorySetsCompanion.insert({
    required String id,
    required String workoutHistoryId,
    required int reps,
    required double weightKg,
    required int seriesOrder,
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
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workoutHistoryId != null) 'workout_history_id': workoutHistoryId,
      if (reps != null) 'reps': reps,
      if (weightKg != null) 'weight_kg': weightKg,
      if (seriesOrder != null) 'series_order': seriesOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutHistorySetsCompanion copyWith({
    Value<String>? id,
    Value<String>? workoutHistoryId,
    Value<int>? reps,
    Value<double>? weightKg,
    Value<int>? seriesOrder,
    Value<int>? rowid,
  }) {
    return WorkoutHistorySetsCompanion(
      id: id ?? this.id,
      workoutHistoryId: workoutHistoryId ?? this.workoutHistoryId,
      reps: reps ?? this.reps,
      weightKg: weightKg ?? this.weightKg,
      seriesOrder: seriesOrder ?? this.seriesOrder,
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
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (sessionMuscleGroupsRefs) db.sessionMuscleGroups,
                    if (muscleRecoveriesRefs) db.muscleRecoveries,
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
      })
    >;
typedef $$TrainingSessionsTableCreateCompanionBuilder =
    TrainingSessionsCompanion Function({
      required String id,
      required String name,
      Value<String?> description,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$TrainingSessionsTableUpdateCompanionBuilder =
    TrainingSessionsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> description,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
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
                Value<int> rowid = const Value.absent(),
              }) => TrainingSessionsCompanion(
                id: id,
                name: name,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrainingSessionsCompanion.insert(
                id: id,
                name: name,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
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
      Value<int> rowid,
    });
typedef $$SessionMuscleGroupsTableUpdateCompanionBuilder =
    SessionMuscleGroupsCompanion Function({
      Value<String> id,
      Value<String> sessionId,
      Value<String> muscleGroupId,
      Value<int> order,
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
                Value<int> rowid = const Value.absent(),
              }) => SessionMuscleGroupsCompanion(
                id: id,
                sessionId: sessionId,
                muscleGroupId: muscleGroupId,
                order: order,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sessionId,
                required String muscleGroupId,
                Value<int> order = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionMuscleGroupsCompanion.insert(
                id: id,
                sessionId: sessionId,
                muscleGroupId: muscleGroupId,
                order: order,
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
                Value<int> rowid = const Value.absent(),
              }) => ExerciseSeriesListCompanion(
                id: id,
                exerciseId: exerciseId,
                seriesNumber: seriesNumber,
                actualReps: actualReps,
                weightKg: weightKg,
                completedAt: completedAt,
                isCompleted: isCompleted,
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
                Value<int> rowid = const Value.absent(),
              }) => ExerciseSeriesListCompanion.insert(
                id: id,
                exerciseId: exerciseId,
                seriesNumber: seriesNumber,
                actualReps: actualReps,
                weightKg: weightKg,
                completedAt: completedAt,
                isCompleted: isCompleted,
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
      Value<int> rowid,
    });
typedef $$WorkoutHistorySetsTableUpdateCompanionBuilder =
    WorkoutHistorySetsCompanion Function({
      Value<String> id,
      Value<String> workoutHistoryId,
      Value<int> reps,
      Value<double> weightKg,
      Value<int> seriesOrder,
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
                Value<int> rowid = const Value.absent(),
              }) => WorkoutHistorySetsCompanion(
                id: id,
                workoutHistoryId: workoutHistoryId,
                reps: reps,
                weightKg: weightKg,
                seriesOrder: seriesOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String workoutHistoryId,
                required int reps,
                required double weightKg,
                required int seriesOrder,
                Value<int> rowid = const Value.absent(),
              }) => WorkoutHistorySetsCompanion.insert(
                id: id,
                workoutHistoryId: workoutHistoryId,
                reps: reps,
                weightKg: weightKg,
                seriesOrder: seriesOrder,
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
}
