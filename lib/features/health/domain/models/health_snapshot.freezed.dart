// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'health_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HealthSnapshot {

 String get id; String get userId;/// Heart Rate Variability (SDNN) in milliseconds.
/// Typical athlete range: 40–100ms. Lower = more fatigued.
 double? get hrvMs;/// Resting Heart Rate in BPM.
/// Typical athlete range: 45–65. Higher = more fatigued.
 int? get restingHr;/// Normalized sleep quality score (0.0 = terrible, 1.0 = perfect).
/// Derived from sleep stage distribution + total duration.
 double? get sleepScore;/// Total sleep duration in minutes.
 int? get sleepDurationMinutes;/// The platform that provided this data.
 HealthSyncSource get syncSource;/// When the platform reported this data (e.g. "last night 6am").
 DateTime get syncedAt;/// When this row was inserted into the local cache.
 DateTime get createdAt;
/// Create a copy of HealthSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HealthSnapshotCopyWith<HealthSnapshot> get copyWith => _$HealthSnapshotCopyWithImpl<HealthSnapshot>(this as HealthSnapshot, _$identity);

  /// Serializes this HealthSnapshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HealthSnapshot&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.hrvMs, hrvMs) || other.hrvMs == hrvMs)&&(identical(other.restingHr, restingHr) || other.restingHr == restingHr)&&(identical(other.sleepScore, sleepScore) || other.sleepScore == sleepScore)&&(identical(other.sleepDurationMinutes, sleepDurationMinutes) || other.sleepDurationMinutes == sleepDurationMinutes)&&(identical(other.syncSource, syncSource) || other.syncSource == syncSource)&&(identical(other.syncedAt, syncedAt) || other.syncedAt == syncedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,hrvMs,restingHr,sleepScore,sleepDurationMinutes,syncSource,syncedAt,createdAt);

@override
String toString() {
  return 'HealthSnapshot(id: $id, userId: $userId, hrvMs: $hrvMs, restingHr: $restingHr, sleepScore: $sleepScore, sleepDurationMinutes: $sleepDurationMinutes, syncSource: $syncSource, syncedAt: $syncedAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $HealthSnapshotCopyWith<$Res>  {
  factory $HealthSnapshotCopyWith(HealthSnapshot value, $Res Function(HealthSnapshot) _then) = _$HealthSnapshotCopyWithImpl;
@useResult
$Res call({
 String id, String userId, double? hrvMs, int? restingHr, double? sleepScore, int? sleepDurationMinutes, HealthSyncSource syncSource, DateTime syncedAt, DateTime createdAt
});




}
/// @nodoc
class _$HealthSnapshotCopyWithImpl<$Res>
    implements $HealthSnapshotCopyWith<$Res> {
  _$HealthSnapshotCopyWithImpl(this._self, this._then);

  final HealthSnapshot _self;
  final $Res Function(HealthSnapshot) _then;

/// Create a copy of HealthSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? hrvMs = freezed,Object? restingHr = freezed,Object? sleepScore = freezed,Object? sleepDurationMinutes = freezed,Object? syncSource = null,Object? syncedAt = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,hrvMs: freezed == hrvMs ? _self.hrvMs : hrvMs // ignore: cast_nullable_to_non_nullable
as double?,restingHr: freezed == restingHr ? _self.restingHr : restingHr // ignore: cast_nullable_to_non_nullable
as int?,sleepScore: freezed == sleepScore ? _self.sleepScore : sleepScore // ignore: cast_nullable_to_non_nullable
as double?,sleepDurationMinutes: freezed == sleepDurationMinutes ? _self.sleepDurationMinutes : sleepDurationMinutes // ignore: cast_nullable_to_non_nullable
as int?,syncSource: null == syncSource ? _self.syncSource : syncSource // ignore: cast_nullable_to_non_nullable
as HealthSyncSource,syncedAt: null == syncedAt ? _self.syncedAt : syncedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [HealthSnapshot].
extension HealthSnapshotPatterns on HealthSnapshot {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HealthSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HealthSnapshot() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HealthSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _HealthSnapshot():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HealthSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _HealthSnapshot() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  double? hrvMs,  int? restingHr,  double? sleepScore,  int? sleepDurationMinutes,  HealthSyncSource syncSource,  DateTime syncedAt,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HealthSnapshot() when $default != null:
return $default(_that.id,_that.userId,_that.hrvMs,_that.restingHr,_that.sleepScore,_that.sleepDurationMinutes,_that.syncSource,_that.syncedAt,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  double? hrvMs,  int? restingHr,  double? sleepScore,  int? sleepDurationMinutes,  HealthSyncSource syncSource,  DateTime syncedAt,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _HealthSnapshot():
return $default(_that.id,_that.userId,_that.hrvMs,_that.restingHr,_that.sleepScore,_that.sleepDurationMinutes,_that.syncSource,_that.syncedAt,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  double? hrvMs,  int? restingHr,  double? sleepScore,  int? sleepDurationMinutes,  HealthSyncSource syncSource,  DateTime syncedAt,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _HealthSnapshot() when $default != null:
return $default(_that.id,_that.userId,_that.hrvMs,_that.restingHr,_that.sleepScore,_that.sleepDurationMinutes,_that.syncSource,_that.syncedAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HealthSnapshot extends HealthSnapshot {
  const _HealthSnapshot({required this.id, required this.userId, this.hrvMs, this.restingHr, this.sleepScore, this.sleepDurationMinutes, required this.syncSource, required this.syncedAt, required this.createdAt}): super._();
  factory _HealthSnapshot.fromJson(Map<String, dynamic> json) => _$HealthSnapshotFromJson(json);

@override final  String id;
@override final  String userId;
/// Heart Rate Variability (SDNN) in milliseconds.
/// Typical athlete range: 40–100ms. Lower = more fatigued.
@override final  double? hrvMs;
/// Resting Heart Rate in BPM.
/// Typical athlete range: 45–65. Higher = more fatigued.
@override final  int? restingHr;
/// Normalized sleep quality score (0.0 = terrible, 1.0 = perfect).
/// Derived from sleep stage distribution + total duration.
@override final  double? sleepScore;
/// Total sleep duration in minutes.
@override final  int? sleepDurationMinutes;
/// The platform that provided this data.
@override final  HealthSyncSource syncSource;
/// When the platform reported this data (e.g. "last night 6am").
@override final  DateTime syncedAt;
/// When this row was inserted into the local cache.
@override final  DateTime createdAt;

/// Create a copy of HealthSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HealthSnapshotCopyWith<_HealthSnapshot> get copyWith => __$HealthSnapshotCopyWithImpl<_HealthSnapshot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HealthSnapshotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HealthSnapshot&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.hrvMs, hrvMs) || other.hrvMs == hrvMs)&&(identical(other.restingHr, restingHr) || other.restingHr == restingHr)&&(identical(other.sleepScore, sleepScore) || other.sleepScore == sleepScore)&&(identical(other.sleepDurationMinutes, sleepDurationMinutes) || other.sleepDurationMinutes == sleepDurationMinutes)&&(identical(other.syncSource, syncSource) || other.syncSource == syncSource)&&(identical(other.syncedAt, syncedAt) || other.syncedAt == syncedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,hrvMs,restingHr,sleepScore,sleepDurationMinutes,syncSource,syncedAt,createdAt);

@override
String toString() {
  return 'HealthSnapshot(id: $id, userId: $userId, hrvMs: $hrvMs, restingHr: $restingHr, sleepScore: $sleepScore, sleepDurationMinutes: $sleepDurationMinutes, syncSource: $syncSource, syncedAt: $syncedAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$HealthSnapshotCopyWith<$Res> implements $HealthSnapshotCopyWith<$Res> {
  factory _$HealthSnapshotCopyWith(_HealthSnapshot value, $Res Function(_HealthSnapshot) _then) = __$HealthSnapshotCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, double? hrvMs, int? restingHr, double? sleepScore, int? sleepDurationMinutes, HealthSyncSource syncSource, DateTime syncedAt, DateTime createdAt
});




}
/// @nodoc
class __$HealthSnapshotCopyWithImpl<$Res>
    implements _$HealthSnapshotCopyWith<$Res> {
  __$HealthSnapshotCopyWithImpl(this._self, this._then);

  final _HealthSnapshot _self;
  final $Res Function(_HealthSnapshot) _then;

/// Create a copy of HealthSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? hrvMs = freezed,Object? restingHr = freezed,Object? sleepScore = freezed,Object? sleepDurationMinutes = freezed,Object? syncSource = null,Object? syncedAt = null,Object? createdAt = null,}) {
  return _then(_HealthSnapshot(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,hrvMs: freezed == hrvMs ? _self.hrvMs : hrvMs // ignore: cast_nullable_to_non_nullable
as double?,restingHr: freezed == restingHr ? _self.restingHr : restingHr // ignore: cast_nullable_to_non_nullable
as int?,sleepScore: freezed == sleepScore ? _self.sleepScore : sleepScore // ignore: cast_nullable_to_non_nullable
as double?,sleepDurationMinutes: freezed == sleepDurationMinutes ? _self.sleepDurationMinutes : sleepDurationMinutes // ignore: cast_nullable_to_non_nullable
as int?,syncSource: null == syncSource ? _self.syncSource : syncSource // ignore: cast_nullable_to_non_nullable
as HealthSyncSource,syncedAt: null == syncedAt ? _self.syncedAt : syncedAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
