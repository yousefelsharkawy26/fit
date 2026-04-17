// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coaching_context.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CoachingContext {

 List<MuscleVolume> get weeklyVolume; List<MovementPatternVolume> get movementPatternVolumes; List<PerformanceSnapshot> get topExercises; List<String> get activeInjuries; Map<String, double> get fatigueScores;// MuscleRegion name -> Fatigue score
 List<CardioSessionMetric> get cardioSessions; double get totalCnsFatigue; List<CnsLoadSnapshot> get cnsLoadTrend;// ═══ V2: Wearable Bio-Signals (P1 Health Sync) ═══
/// Heart Rate Variability (SDNN) in ms. Lower = more fatigued.
 double? get hrvMs;/// Resting Heart Rate in BPM. Higher = more fatigued.
 int? get restingHr;/// Normalized sleep quality score (0.0–1.0). Lower = more fatigued.
 double? get sleepScore;
/// Create a copy of CoachingContext
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoachingContextCopyWith<CoachingContext> get copyWith => _$CoachingContextCopyWithImpl<CoachingContext>(this as CoachingContext, _$identity);

  /// Serializes this CoachingContext to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoachingContext&&const DeepCollectionEquality().equals(other.weeklyVolume, weeklyVolume)&&const DeepCollectionEquality().equals(other.movementPatternVolumes, movementPatternVolumes)&&const DeepCollectionEquality().equals(other.topExercises, topExercises)&&const DeepCollectionEquality().equals(other.activeInjuries, activeInjuries)&&const DeepCollectionEquality().equals(other.fatigueScores, fatigueScores)&&const DeepCollectionEquality().equals(other.cardioSessions, cardioSessions)&&(identical(other.totalCnsFatigue, totalCnsFatigue) || other.totalCnsFatigue == totalCnsFatigue)&&const DeepCollectionEquality().equals(other.cnsLoadTrend, cnsLoadTrend)&&(identical(other.hrvMs, hrvMs) || other.hrvMs == hrvMs)&&(identical(other.restingHr, restingHr) || other.restingHr == restingHr)&&(identical(other.sleepScore, sleepScore) || other.sleepScore == sleepScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(weeklyVolume),const DeepCollectionEquality().hash(movementPatternVolumes),const DeepCollectionEquality().hash(topExercises),const DeepCollectionEquality().hash(activeInjuries),const DeepCollectionEquality().hash(fatigueScores),const DeepCollectionEquality().hash(cardioSessions),totalCnsFatigue,const DeepCollectionEquality().hash(cnsLoadTrend),hrvMs,restingHr,sleepScore);

@override
String toString() {
  return 'CoachingContext(weeklyVolume: $weeklyVolume, movementPatternVolumes: $movementPatternVolumes, topExercises: $topExercises, activeInjuries: $activeInjuries, fatigueScores: $fatigueScores, cardioSessions: $cardioSessions, totalCnsFatigue: $totalCnsFatigue, cnsLoadTrend: $cnsLoadTrend, hrvMs: $hrvMs, restingHr: $restingHr, sleepScore: $sleepScore)';
}


}

/// @nodoc
abstract mixin class $CoachingContextCopyWith<$Res>  {
  factory $CoachingContextCopyWith(CoachingContext value, $Res Function(CoachingContext) _then) = _$CoachingContextCopyWithImpl;
@useResult
$Res call({
 List<MuscleVolume> weeklyVolume, List<MovementPatternVolume> movementPatternVolumes, List<PerformanceSnapshot> topExercises, List<String> activeInjuries, Map<String, double> fatigueScores, List<CardioSessionMetric> cardioSessions, double totalCnsFatigue, List<CnsLoadSnapshot> cnsLoadTrend, double? hrvMs, int? restingHr, double? sleepScore
});




}
/// @nodoc
class _$CoachingContextCopyWithImpl<$Res>
    implements $CoachingContextCopyWith<$Res> {
  _$CoachingContextCopyWithImpl(this._self, this._then);

  final CoachingContext _self;
  final $Res Function(CoachingContext) _then;

/// Create a copy of CoachingContext
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weeklyVolume = null,Object? movementPatternVolumes = null,Object? topExercises = null,Object? activeInjuries = null,Object? fatigueScores = null,Object? cardioSessions = null,Object? totalCnsFatigue = null,Object? cnsLoadTrend = null,Object? hrvMs = freezed,Object? restingHr = freezed,Object? sleepScore = freezed,}) {
  return _then(_self.copyWith(
weeklyVolume: null == weeklyVolume ? _self.weeklyVolume : weeklyVolume // ignore: cast_nullable_to_non_nullable
as List<MuscleVolume>,movementPatternVolumes: null == movementPatternVolumes ? _self.movementPatternVolumes : movementPatternVolumes // ignore: cast_nullable_to_non_nullable
as List<MovementPatternVolume>,topExercises: null == topExercises ? _self.topExercises : topExercises // ignore: cast_nullable_to_non_nullable
as List<PerformanceSnapshot>,activeInjuries: null == activeInjuries ? _self.activeInjuries : activeInjuries // ignore: cast_nullable_to_non_nullable
as List<String>,fatigueScores: null == fatigueScores ? _self.fatigueScores : fatigueScores // ignore: cast_nullable_to_non_nullable
as Map<String, double>,cardioSessions: null == cardioSessions ? _self.cardioSessions : cardioSessions // ignore: cast_nullable_to_non_nullable
as List<CardioSessionMetric>,totalCnsFatigue: null == totalCnsFatigue ? _self.totalCnsFatigue : totalCnsFatigue // ignore: cast_nullable_to_non_nullable
as double,cnsLoadTrend: null == cnsLoadTrend ? _self.cnsLoadTrend : cnsLoadTrend // ignore: cast_nullable_to_non_nullable
as List<CnsLoadSnapshot>,hrvMs: freezed == hrvMs ? _self.hrvMs : hrvMs // ignore: cast_nullable_to_non_nullable
as double?,restingHr: freezed == restingHr ? _self.restingHr : restingHr // ignore: cast_nullable_to_non_nullable
as int?,sleepScore: freezed == sleepScore ? _self.sleepScore : sleepScore // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [CoachingContext].
extension CoachingContextPatterns on CoachingContext {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoachingContext value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoachingContext() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoachingContext value)  $default,){
final _that = this;
switch (_that) {
case _CoachingContext():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoachingContext value)?  $default,){
final _that = this;
switch (_that) {
case _CoachingContext() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<MuscleVolume> weeklyVolume,  List<MovementPatternVolume> movementPatternVolumes,  List<PerformanceSnapshot> topExercises,  List<String> activeInjuries,  Map<String, double> fatigueScores,  List<CardioSessionMetric> cardioSessions,  double totalCnsFatigue,  List<CnsLoadSnapshot> cnsLoadTrend,  double? hrvMs,  int? restingHr,  double? sleepScore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoachingContext() when $default != null:
return $default(_that.weeklyVolume,_that.movementPatternVolumes,_that.topExercises,_that.activeInjuries,_that.fatigueScores,_that.cardioSessions,_that.totalCnsFatigue,_that.cnsLoadTrend,_that.hrvMs,_that.restingHr,_that.sleepScore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<MuscleVolume> weeklyVolume,  List<MovementPatternVolume> movementPatternVolumes,  List<PerformanceSnapshot> topExercises,  List<String> activeInjuries,  Map<String, double> fatigueScores,  List<CardioSessionMetric> cardioSessions,  double totalCnsFatigue,  List<CnsLoadSnapshot> cnsLoadTrend,  double? hrvMs,  int? restingHr,  double? sleepScore)  $default,) {final _that = this;
switch (_that) {
case _CoachingContext():
return $default(_that.weeklyVolume,_that.movementPatternVolumes,_that.topExercises,_that.activeInjuries,_that.fatigueScores,_that.cardioSessions,_that.totalCnsFatigue,_that.cnsLoadTrend,_that.hrvMs,_that.restingHr,_that.sleepScore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<MuscleVolume> weeklyVolume,  List<MovementPatternVolume> movementPatternVolumes,  List<PerformanceSnapshot> topExercises,  List<String> activeInjuries,  Map<String, double> fatigueScores,  List<CardioSessionMetric> cardioSessions,  double totalCnsFatigue,  List<CnsLoadSnapshot> cnsLoadTrend,  double? hrvMs,  int? restingHr,  double? sleepScore)?  $default,) {final _that = this;
switch (_that) {
case _CoachingContext() when $default != null:
return $default(_that.weeklyVolume,_that.movementPatternVolumes,_that.topExercises,_that.activeInjuries,_that.fatigueScores,_that.cardioSessions,_that.totalCnsFatigue,_that.cnsLoadTrend,_that.hrvMs,_that.restingHr,_that.sleepScore);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CoachingContext implements CoachingContext {
  const _CoachingContext({required final  List<MuscleVolume> weeklyVolume, required final  List<MovementPatternVolume> movementPatternVolumes, required final  List<PerformanceSnapshot> topExercises, required final  List<String> activeInjuries, required final  Map<String, double> fatigueScores, required final  List<CardioSessionMetric> cardioSessions, required this.totalCnsFatigue, required final  List<CnsLoadSnapshot> cnsLoadTrend, this.hrvMs, this.restingHr, this.sleepScore}): _weeklyVolume = weeklyVolume,_movementPatternVolumes = movementPatternVolumes,_topExercises = topExercises,_activeInjuries = activeInjuries,_fatigueScores = fatigueScores,_cardioSessions = cardioSessions,_cnsLoadTrend = cnsLoadTrend;
  factory _CoachingContext.fromJson(Map<String, dynamic> json) => _$CoachingContextFromJson(json);

 final  List<MuscleVolume> _weeklyVolume;
@override List<MuscleVolume> get weeklyVolume {
  if (_weeklyVolume is EqualUnmodifiableListView) return _weeklyVolume;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weeklyVolume);
}

 final  List<MovementPatternVolume> _movementPatternVolumes;
@override List<MovementPatternVolume> get movementPatternVolumes {
  if (_movementPatternVolumes is EqualUnmodifiableListView) return _movementPatternVolumes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_movementPatternVolumes);
}

 final  List<PerformanceSnapshot> _topExercises;
@override List<PerformanceSnapshot> get topExercises {
  if (_topExercises is EqualUnmodifiableListView) return _topExercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topExercises);
}

 final  List<String> _activeInjuries;
@override List<String> get activeInjuries {
  if (_activeInjuries is EqualUnmodifiableListView) return _activeInjuries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activeInjuries);
}

 final  Map<String, double> _fatigueScores;
@override Map<String, double> get fatigueScores {
  if (_fatigueScores is EqualUnmodifiableMapView) return _fatigueScores;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_fatigueScores);
}

// MuscleRegion name -> Fatigue score
 final  List<CardioSessionMetric> _cardioSessions;
// MuscleRegion name -> Fatigue score
@override List<CardioSessionMetric> get cardioSessions {
  if (_cardioSessions is EqualUnmodifiableListView) return _cardioSessions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cardioSessions);
}

@override final  double totalCnsFatigue;
 final  List<CnsLoadSnapshot> _cnsLoadTrend;
@override List<CnsLoadSnapshot> get cnsLoadTrend {
  if (_cnsLoadTrend is EqualUnmodifiableListView) return _cnsLoadTrend;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cnsLoadTrend);
}

// ═══ V2: Wearable Bio-Signals (P1 Health Sync) ═══
/// Heart Rate Variability (SDNN) in ms. Lower = more fatigued.
@override final  double? hrvMs;
/// Resting Heart Rate in BPM. Higher = more fatigued.
@override final  int? restingHr;
/// Normalized sleep quality score (0.0–1.0). Lower = more fatigued.
@override final  double? sleepScore;

/// Create a copy of CoachingContext
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoachingContextCopyWith<_CoachingContext> get copyWith => __$CoachingContextCopyWithImpl<_CoachingContext>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoachingContextToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoachingContext&&const DeepCollectionEquality().equals(other._weeklyVolume, _weeklyVolume)&&const DeepCollectionEquality().equals(other._movementPatternVolumes, _movementPatternVolumes)&&const DeepCollectionEquality().equals(other._topExercises, _topExercises)&&const DeepCollectionEquality().equals(other._activeInjuries, _activeInjuries)&&const DeepCollectionEquality().equals(other._fatigueScores, _fatigueScores)&&const DeepCollectionEquality().equals(other._cardioSessions, _cardioSessions)&&(identical(other.totalCnsFatigue, totalCnsFatigue) || other.totalCnsFatigue == totalCnsFatigue)&&const DeepCollectionEquality().equals(other._cnsLoadTrend, _cnsLoadTrend)&&(identical(other.hrvMs, hrvMs) || other.hrvMs == hrvMs)&&(identical(other.restingHr, restingHr) || other.restingHr == restingHr)&&(identical(other.sleepScore, sleepScore) || other.sleepScore == sleepScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_weeklyVolume),const DeepCollectionEquality().hash(_movementPatternVolumes),const DeepCollectionEquality().hash(_topExercises),const DeepCollectionEquality().hash(_activeInjuries),const DeepCollectionEquality().hash(_fatigueScores),const DeepCollectionEquality().hash(_cardioSessions),totalCnsFatigue,const DeepCollectionEquality().hash(_cnsLoadTrend),hrvMs,restingHr,sleepScore);

@override
String toString() {
  return 'CoachingContext(weeklyVolume: $weeklyVolume, movementPatternVolumes: $movementPatternVolumes, topExercises: $topExercises, activeInjuries: $activeInjuries, fatigueScores: $fatigueScores, cardioSessions: $cardioSessions, totalCnsFatigue: $totalCnsFatigue, cnsLoadTrend: $cnsLoadTrend, hrvMs: $hrvMs, restingHr: $restingHr, sleepScore: $sleepScore)';
}


}

/// @nodoc
abstract mixin class _$CoachingContextCopyWith<$Res> implements $CoachingContextCopyWith<$Res> {
  factory _$CoachingContextCopyWith(_CoachingContext value, $Res Function(_CoachingContext) _then) = __$CoachingContextCopyWithImpl;
@override @useResult
$Res call({
 List<MuscleVolume> weeklyVolume, List<MovementPatternVolume> movementPatternVolumes, List<PerformanceSnapshot> topExercises, List<String> activeInjuries, Map<String, double> fatigueScores, List<CardioSessionMetric> cardioSessions, double totalCnsFatigue, List<CnsLoadSnapshot> cnsLoadTrend, double? hrvMs, int? restingHr, double? sleepScore
});




}
/// @nodoc
class __$CoachingContextCopyWithImpl<$Res>
    implements _$CoachingContextCopyWith<$Res> {
  __$CoachingContextCopyWithImpl(this._self, this._then);

  final _CoachingContext _self;
  final $Res Function(_CoachingContext) _then;

/// Create a copy of CoachingContext
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weeklyVolume = null,Object? movementPatternVolumes = null,Object? topExercises = null,Object? activeInjuries = null,Object? fatigueScores = null,Object? cardioSessions = null,Object? totalCnsFatigue = null,Object? cnsLoadTrend = null,Object? hrvMs = freezed,Object? restingHr = freezed,Object? sleepScore = freezed,}) {
  return _then(_CoachingContext(
weeklyVolume: null == weeklyVolume ? _self._weeklyVolume : weeklyVolume // ignore: cast_nullable_to_non_nullable
as List<MuscleVolume>,movementPatternVolumes: null == movementPatternVolumes ? _self._movementPatternVolumes : movementPatternVolumes // ignore: cast_nullable_to_non_nullable
as List<MovementPatternVolume>,topExercises: null == topExercises ? _self._topExercises : topExercises // ignore: cast_nullable_to_non_nullable
as List<PerformanceSnapshot>,activeInjuries: null == activeInjuries ? _self._activeInjuries : activeInjuries // ignore: cast_nullable_to_non_nullable
as List<String>,fatigueScores: null == fatigueScores ? _self._fatigueScores : fatigueScores // ignore: cast_nullable_to_non_nullable
as Map<String, double>,cardioSessions: null == cardioSessions ? _self._cardioSessions : cardioSessions // ignore: cast_nullable_to_non_nullable
as List<CardioSessionMetric>,totalCnsFatigue: null == totalCnsFatigue ? _self.totalCnsFatigue : totalCnsFatigue // ignore: cast_nullable_to_non_nullable
as double,cnsLoadTrend: null == cnsLoadTrend ? _self._cnsLoadTrend : cnsLoadTrend // ignore: cast_nullable_to_non_nullable
as List<CnsLoadSnapshot>,hrvMs: freezed == hrvMs ? _self.hrvMs : hrvMs // ignore: cast_nullable_to_non_nullable
as double?,restingHr: freezed == restingHr ? _self.restingHr : restingHr // ignore: cast_nullable_to_non_nullable
as int?,sleepScore: freezed == sleepScore ? _self.sleepScore : sleepScore // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$PerformanceSnapshot {

 String get exerciseName; double get oneRepMaxEstimate;// Calculated from weight/reps
 double get weeklyTrend;
/// Create a copy of PerformanceSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceSnapshotCopyWith<PerformanceSnapshot> get copyWith => _$PerformanceSnapshotCopyWithImpl<PerformanceSnapshot>(this as PerformanceSnapshot, _$identity);

  /// Serializes this PerformanceSnapshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceSnapshot&&(identical(other.exerciseName, exerciseName) || other.exerciseName == exerciseName)&&(identical(other.oneRepMaxEstimate, oneRepMaxEstimate) || other.oneRepMaxEstimate == oneRepMaxEstimate)&&(identical(other.weeklyTrend, weeklyTrend) || other.weeklyTrend == weeklyTrend));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,exerciseName,oneRepMaxEstimate,weeklyTrend);

@override
String toString() {
  return 'PerformanceSnapshot(exerciseName: $exerciseName, oneRepMaxEstimate: $oneRepMaxEstimate, weeklyTrend: $weeklyTrend)';
}


}

/// @nodoc
abstract mixin class $PerformanceSnapshotCopyWith<$Res>  {
  factory $PerformanceSnapshotCopyWith(PerformanceSnapshot value, $Res Function(PerformanceSnapshot) _then) = _$PerformanceSnapshotCopyWithImpl;
@useResult
$Res call({
 String exerciseName, double oneRepMaxEstimate, double weeklyTrend
});




}
/// @nodoc
class _$PerformanceSnapshotCopyWithImpl<$Res>
    implements $PerformanceSnapshotCopyWith<$Res> {
  _$PerformanceSnapshotCopyWithImpl(this._self, this._then);

  final PerformanceSnapshot _self;
  final $Res Function(PerformanceSnapshot) _then;

/// Create a copy of PerformanceSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? exerciseName = null,Object? oneRepMaxEstimate = null,Object? weeklyTrend = null,}) {
  return _then(_self.copyWith(
exerciseName: null == exerciseName ? _self.exerciseName : exerciseName // ignore: cast_nullable_to_non_nullable
as String,oneRepMaxEstimate: null == oneRepMaxEstimate ? _self.oneRepMaxEstimate : oneRepMaxEstimate // ignore: cast_nullable_to_non_nullable
as double,weeklyTrend: null == weeklyTrend ? _self.weeklyTrend : weeklyTrend // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PerformanceSnapshot].
extension PerformanceSnapshotPatterns on PerformanceSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PerformanceSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PerformanceSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PerformanceSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _PerformanceSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PerformanceSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _PerformanceSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String exerciseName,  double oneRepMaxEstimate,  double weeklyTrend)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PerformanceSnapshot() when $default != null:
return $default(_that.exerciseName,_that.oneRepMaxEstimate,_that.weeklyTrend);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String exerciseName,  double oneRepMaxEstimate,  double weeklyTrend)  $default,) {final _that = this;
switch (_that) {
case _PerformanceSnapshot():
return $default(_that.exerciseName,_that.oneRepMaxEstimate,_that.weeklyTrend);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String exerciseName,  double oneRepMaxEstimate,  double weeklyTrend)?  $default,) {final _that = this;
switch (_that) {
case _PerformanceSnapshot() when $default != null:
return $default(_that.exerciseName,_that.oneRepMaxEstimate,_that.weeklyTrend);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PerformanceSnapshot implements PerformanceSnapshot {
  const _PerformanceSnapshot({required this.exerciseName, required this.oneRepMaxEstimate, required this.weeklyTrend});
  factory _PerformanceSnapshot.fromJson(Map<String, dynamic> json) => _$PerformanceSnapshotFromJson(json);

@override final  String exerciseName;
@override final  double oneRepMaxEstimate;
// Calculated from weight/reps
@override final  double weeklyTrend;

/// Create a copy of PerformanceSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PerformanceSnapshotCopyWith<_PerformanceSnapshot> get copyWith => __$PerformanceSnapshotCopyWithImpl<_PerformanceSnapshot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PerformanceSnapshotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PerformanceSnapshot&&(identical(other.exerciseName, exerciseName) || other.exerciseName == exerciseName)&&(identical(other.oneRepMaxEstimate, oneRepMaxEstimate) || other.oneRepMaxEstimate == oneRepMaxEstimate)&&(identical(other.weeklyTrend, weeklyTrend) || other.weeklyTrend == weeklyTrend));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,exerciseName,oneRepMaxEstimate,weeklyTrend);

@override
String toString() {
  return 'PerformanceSnapshot(exerciseName: $exerciseName, oneRepMaxEstimate: $oneRepMaxEstimate, weeklyTrend: $weeklyTrend)';
}


}

/// @nodoc
abstract mixin class _$PerformanceSnapshotCopyWith<$Res> implements $PerformanceSnapshotCopyWith<$Res> {
  factory _$PerformanceSnapshotCopyWith(_PerformanceSnapshot value, $Res Function(_PerformanceSnapshot) _then) = __$PerformanceSnapshotCopyWithImpl;
@override @useResult
$Res call({
 String exerciseName, double oneRepMaxEstimate, double weeklyTrend
});




}
/// @nodoc
class __$PerformanceSnapshotCopyWithImpl<$Res>
    implements _$PerformanceSnapshotCopyWith<$Res> {
  __$PerformanceSnapshotCopyWithImpl(this._self, this._then);

  final _PerformanceSnapshot _self;
  final $Res Function(_PerformanceSnapshot) _then;

/// Create a copy of PerformanceSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? exerciseName = null,Object? oneRepMaxEstimate = null,Object? weeklyTrend = null,}) {
  return _then(_PerformanceSnapshot(
exerciseName: null == exerciseName ? _self.exerciseName : exerciseName // ignore: cast_nullable_to_non_nullable
as String,oneRepMaxEstimate: null == oneRepMaxEstimate ? _self.oneRepMaxEstimate : oneRepMaxEstimate // ignore: cast_nullable_to_non_nullable
as double,weeklyTrend: null == weeklyTrend ? _self.weeklyTrend : weeklyTrend // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$MuscleVolume {

 String get muscleName; double get volume;
/// Create a copy of MuscleVolume
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MuscleVolumeCopyWith<MuscleVolume> get copyWith => _$MuscleVolumeCopyWithImpl<MuscleVolume>(this as MuscleVolume, _$identity);

  /// Serializes this MuscleVolume to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MuscleVolume&&(identical(other.muscleName, muscleName) || other.muscleName == muscleName)&&(identical(other.volume, volume) || other.volume == volume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,muscleName,volume);

@override
String toString() {
  return 'MuscleVolume(muscleName: $muscleName, volume: $volume)';
}


}

/// @nodoc
abstract mixin class $MuscleVolumeCopyWith<$Res>  {
  factory $MuscleVolumeCopyWith(MuscleVolume value, $Res Function(MuscleVolume) _then) = _$MuscleVolumeCopyWithImpl;
@useResult
$Res call({
 String muscleName, double volume
});




}
/// @nodoc
class _$MuscleVolumeCopyWithImpl<$Res>
    implements $MuscleVolumeCopyWith<$Res> {
  _$MuscleVolumeCopyWithImpl(this._self, this._then);

  final MuscleVolume _self;
  final $Res Function(MuscleVolume) _then;

/// Create a copy of MuscleVolume
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? muscleName = null,Object? volume = null,}) {
  return _then(_self.copyWith(
muscleName: null == muscleName ? _self.muscleName : muscleName // ignore: cast_nullable_to_non_nullable
as String,volume: null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MuscleVolume].
extension MuscleVolumePatterns on MuscleVolume {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MuscleVolume value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MuscleVolume() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MuscleVolume value)  $default,){
final _that = this;
switch (_that) {
case _MuscleVolume():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MuscleVolume value)?  $default,){
final _that = this;
switch (_that) {
case _MuscleVolume() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String muscleName,  double volume)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MuscleVolume() when $default != null:
return $default(_that.muscleName,_that.volume);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String muscleName,  double volume)  $default,) {final _that = this;
switch (_that) {
case _MuscleVolume():
return $default(_that.muscleName,_that.volume);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String muscleName,  double volume)?  $default,) {final _that = this;
switch (_that) {
case _MuscleVolume() when $default != null:
return $default(_that.muscleName,_that.volume);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MuscleVolume implements MuscleVolume {
  const _MuscleVolume({required this.muscleName, required this.volume});
  factory _MuscleVolume.fromJson(Map<String, dynamic> json) => _$MuscleVolumeFromJson(json);

@override final  String muscleName;
@override final  double volume;

/// Create a copy of MuscleVolume
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MuscleVolumeCopyWith<_MuscleVolume> get copyWith => __$MuscleVolumeCopyWithImpl<_MuscleVolume>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MuscleVolumeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MuscleVolume&&(identical(other.muscleName, muscleName) || other.muscleName == muscleName)&&(identical(other.volume, volume) || other.volume == volume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,muscleName,volume);

@override
String toString() {
  return 'MuscleVolume(muscleName: $muscleName, volume: $volume)';
}


}

/// @nodoc
abstract mixin class _$MuscleVolumeCopyWith<$Res> implements $MuscleVolumeCopyWith<$Res> {
  factory _$MuscleVolumeCopyWith(_MuscleVolume value, $Res Function(_MuscleVolume) _then) = __$MuscleVolumeCopyWithImpl;
@override @useResult
$Res call({
 String muscleName, double volume
});




}
/// @nodoc
class __$MuscleVolumeCopyWithImpl<$Res>
    implements _$MuscleVolumeCopyWith<$Res> {
  __$MuscleVolumeCopyWithImpl(this._self, this._then);

  final _MuscleVolume _self;
  final $Res Function(_MuscleVolume) _then;

/// Create a copy of MuscleVolume
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? muscleName = null,Object? volume = null,}) {
  return _then(_MuscleVolume(
muscleName: null == muscleName ? _self.muscleName : muscleName // ignore: cast_nullable_to_non_nullable
as String,volume: null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$MovementPatternVolume {

 String get pattern;// e.g., 'Horizontal Push', 'Squat'
 double get volume;
/// Create a copy of MovementPatternVolume
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MovementPatternVolumeCopyWith<MovementPatternVolume> get copyWith => _$MovementPatternVolumeCopyWithImpl<MovementPatternVolume>(this as MovementPatternVolume, _$identity);

  /// Serializes this MovementPatternVolume to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MovementPatternVolume&&(identical(other.pattern, pattern) || other.pattern == pattern)&&(identical(other.volume, volume) || other.volume == volume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pattern,volume);

@override
String toString() {
  return 'MovementPatternVolume(pattern: $pattern, volume: $volume)';
}


}

/// @nodoc
abstract mixin class $MovementPatternVolumeCopyWith<$Res>  {
  factory $MovementPatternVolumeCopyWith(MovementPatternVolume value, $Res Function(MovementPatternVolume) _then) = _$MovementPatternVolumeCopyWithImpl;
@useResult
$Res call({
 String pattern, double volume
});




}
/// @nodoc
class _$MovementPatternVolumeCopyWithImpl<$Res>
    implements $MovementPatternVolumeCopyWith<$Res> {
  _$MovementPatternVolumeCopyWithImpl(this._self, this._then);

  final MovementPatternVolume _self;
  final $Res Function(MovementPatternVolume) _then;

/// Create a copy of MovementPatternVolume
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pattern = null,Object? volume = null,}) {
  return _then(_self.copyWith(
pattern: null == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as String,volume: null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MovementPatternVolume].
extension MovementPatternVolumePatterns on MovementPatternVolume {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MovementPatternVolume value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MovementPatternVolume() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MovementPatternVolume value)  $default,){
final _that = this;
switch (_that) {
case _MovementPatternVolume():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MovementPatternVolume value)?  $default,){
final _that = this;
switch (_that) {
case _MovementPatternVolume() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String pattern,  double volume)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MovementPatternVolume() when $default != null:
return $default(_that.pattern,_that.volume);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String pattern,  double volume)  $default,) {final _that = this;
switch (_that) {
case _MovementPatternVolume():
return $default(_that.pattern,_that.volume);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String pattern,  double volume)?  $default,) {final _that = this;
switch (_that) {
case _MovementPatternVolume() when $default != null:
return $default(_that.pattern,_that.volume);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MovementPatternVolume implements MovementPatternVolume {
  const _MovementPatternVolume({required this.pattern, required this.volume});
  factory _MovementPatternVolume.fromJson(Map<String, dynamic> json) => _$MovementPatternVolumeFromJson(json);

@override final  String pattern;
// e.g., 'Horizontal Push', 'Squat'
@override final  double volume;

/// Create a copy of MovementPatternVolume
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MovementPatternVolumeCopyWith<_MovementPatternVolume> get copyWith => __$MovementPatternVolumeCopyWithImpl<_MovementPatternVolume>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MovementPatternVolumeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MovementPatternVolume&&(identical(other.pattern, pattern) || other.pattern == pattern)&&(identical(other.volume, volume) || other.volume == volume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pattern,volume);

@override
String toString() {
  return 'MovementPatternVolume(pattern: $pattern, volume: $volume)';
}


}

/// @nodoc
abstract mixin class _$MovementPatternVolumeCopyWith<$Res> implements $MovementPatternVolumeCopyWith<$Res> {
  factory _$MovementPatternVolumeCopyWith(_MovementPatternVolume value, $Res Function(_MovementPatternVolume) _then) = __$MovementPatternVolumeCopyWithImpl;
@override @useResult
$Res call({
 String pattern, double volume
});




}
/// @nodoc
class __$MovementPatternVolumeCopyWithImpl<$Res>
    implements _$MovementPatternVolumeCopyWith<$Res> {
  __$MovementPatternVolumeCopyWithImpl(this._self, this._then);

  final _MovementPatternVolume _self;
  final $Res Function(_MovementPatternVolume) _then;

/// Create a copy of MovementPatternVolume
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pattern = null,Object? volume = null,}) {
  return _then(_MovementPatternVolume(
pattern: null == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as String,volume: null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$CnsLoadSnapshot {

 DateTime get date; double get load; DateTime get timestamp;
/// Create a copy of CnsLoadSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CnsLoadSnapshotCopyWith<CnsLoadSnapshot> get copyWith => _$CnsLoadSnapshotCopyWithImpl<CnsLoadSnapshot>(this as CnsLoadSnapshot, _$identity);

  /// Serializes this CnsLoadSnapshot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CnsLoadSnapshot&&(identical(other.date, date) || other.date == date)&&(identical(other.load, load) || other.load == load)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,load,timestamp);

@override
String toString() {
  return 'CnsLoadSnapshot(date: $date, load: $load, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $CnsLoadSnapshotCopyWith<$Res>  {
  factory $CnsLoadSnapshotCopyWith(CnsLoadSnapshot value, $Res Function(CnsLoadSnapshot) _then) = _$CnsLoadSnapshotCopyWithImpl;
@useResult
$Res call({
 DateTime date, double load, DateTime timestamp
});




}
/// @nodoc
class _$CnsLoadSnapshotCopyWithImpl<$Res>
    implements $CnsLoadSnapshotCopyWith<$Res> {
  _$CnsLoadSnapshotCopyWithImpl(this._self, this._then);

  final CnsLoadSnapshot _self;
  final $Res Function(CnsLoadSnapshot) _then;

/// Create a copy of CnsLoadSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? load = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,load: null == load ? _self.load : load // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CnsLoadSnapshot].
extension CnsLoadSnapshotPatterns on CnsLoadSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CnsLoadSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CnsLoadSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CnsLoadSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _CnsLoadSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CnsLoadSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _CnsLoadSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  double load,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CnsLoadSnapshot() when $default != null:
return $default(_that.date,_that.load,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  double load,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _CnsLoadSnapshot():
return $default(_that.date,_that.load,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  double load,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _CnsLoadSnapshot() when $default != null:
return $default(_that.date,_that.load,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CnsLoadSnapshot implements CnsLoadSnapshot {
  const _CnsLoadSnapshot({required this.date, required this.load, required this.timestamp});
  factory _CnsLoadSnapshot.fromJson(Map<String, dynamic> json) => _$CnsLoadSnapshotFromJson(json);

@override final  DateTime date;
@override final  double load;
@override final  DateTime timestamp;

/// Create a copy of CnsLoadSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CnsLoadSnapshotCopyWith<_CnsLoadSnapshot> get copyWith => __$CnsLoadSnapshotCopyWithImpl<_CnsLoadSnapshot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CnsLoadSnapshotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CnsLoadSnapshot&&(identical(other.date, date) || other.date == date)&&(identical(other.load, load) || other.load == load)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,load,timestamp);

@override
String toString() {
  return 'CnsLoadSnapshot(date: $date, load: $load, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$CnsLoadSnapshotCopyWith<$Res> implements $CnsLoadSnapshotCopyWith<$Res> {
  factory _$CnsLoadSnapshotCopyWith(_CnsLoadSnapshot value, $Res Function(_CnsLoadSnapshot) _then) = __$CnsLoadSnapshotCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, double load, DateTime timestamp
});




}
/// @nodoc
class __$CnsLoadSnapshotCopyWithImpl<$Res>
    implements _$CnsLoadSnapshotCopyWith<$Res> {
  __$CnsLoadSnapshotCopyWithImpl(this._self, this._then);

  final _CnsLoadSnapshot _self;
  final $Res Function(_CnsLoadSnapshot) _then;

/// Create a copy of CnsLoadSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? load = null,Object? timestamp = null,}) {
  return _then(_CnsLoadSnapshot(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,load: null == load ? _self.load : load // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$CardioSessionMetric {

 double get distance; int get duration; int get heartRate;
/// Create a copy of CardioSessionMetric
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CardioSessionMetricCopyWith<CardioSessionMetric> get copyWith => _$CardioSessionMetricCopyWithImpl<CardioSessionMetric>(this as CardioSessionMetric, _$identity);

  /// Serializes this CardioSessionMetric to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CardioSessionMetric&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.heartRate, heartRate) || other.heartRate == heartRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,distance,duration,heartRate);

@override
String toString() {
  return 'CardioSessionMetric(distance: $distance, duration: $duration, heartRate: $heartRate)';
}


}

/// @nodoc
abstract mixin class $CardioSessionMetricCopyWith<$Res>  {
  factory $CardioSessionMetricCopyWith(CardioSessionMetric value, $Res Function(CardioSessionMetric) _then) = _$CardioSessionMetricCopyWithImpl;
@useResult
$Res call({
 double distance, int duration, int heartRate
});




}
/// @nodoc
class _$CardioSessionMetricCopyWithImpl<$Res>
    implements $CardioSessionMetricCopyWith<$Res> {
  _$CardioSessionMetricCopyWithImpl(this._self, this._then);

  final CardioSessionMetric _self;
  final $Res Function(CardioSessionMetric) _then;

/// Create a copy of CardioSessionMetric
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? distance = null,Object? duration = null,Object? heartRate = null,}) {
  return _then(_self.copyWith(
distance: null == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as double,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,heartRate: null == heartRate ? _self.heartRate : heartRate // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CardioSessionMetric].
extension CardioSessionMetricPatterns on CardioSessionMetric {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CardioSessionMetric value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CardioSessionMetric() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CardioSessionMetric value)  $default,){
final _that = this;
switch (_that) {
case _CardioSessionMetric():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CardioSessionMetric value)?  $default,){
final _that = this;
switch (_that) {
case _CardioSessionMetric() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double distance,  int duration,  int heartRate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CardioSessionMetric() when $default != null:
return $default(_that.distance,_that.duration,_that.heartRate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double distance,  int duration,  int heartRate)  $default,) {final _that = this;
switch (_that) {
case _CardioSessionMetric():
return $default(_that.distance,_that.duration,_that.heartRate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double distance,  int duration,  int heartRate)?  $default,) {final _that = this;
switch (_that) {
case _CardioSessionMetric() when $default != null:
return $default(_that.distance,_that.duration,_that.heartRate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CardioSessionMetric implements CardioSessionMetric {
  const _CardioSessionMetric({this.distance = 0.0, this.duration = 0, this.heartRate = 0});
  factory _CardioSessionMetric.fromJson(Map<String, dynamic> json) => _$CardioSessionMetricFromJson(json);

@override@JsonKey() final  double distance;
@override@JsonKey() final  int duration;
@override@JsonKey() final  int heartRate;

/// Create a copy of CardioSessionMetric
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CardioSessionMetricCopyWith<_CardioSessionMetric> get copyWith => __$CardioSessionMetricCopyWithImpl<_CardioSessionMetric>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CardioSessionMetricToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CardioSessionMetric&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.heartRate, heartRate) || other.heartRate == heartRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,distance,duration,heartRate);

@override
String toString() {
  return 'CardioSessionMetric(distance: $distance, duration: $duration, heartRate: $heartRate)';
}


}

/// @nodoc
abstract mixin class _$CardioSessionMetricCopyWith<$Res> implements $CardioSessionMetricCopyWith<$Res> {
  factory _$CardioSessionMetricCopyWith(_CardioSessionMetric value, $Res Function(_CardioSessionMetric) _then) = __$CardioSessionMetricCopyWithImpl;
@override @useResult
$Res call({
 double distance, int duration, int heartRate
});




}
/// @nodoc
class __$CardioSessionMetricCopyWithImpl<$Res>
    implements _$CardioSessionMetricCopyWith<$Res> {
  __$CardioSessionMetricCopyWithImpl(this._self, this._then);

  final _CardioSessionMetric _self;
  final $Res Function(_CardioSessionMetric) _then;

/// Create a copy of CardioSessionMetric
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? distance = null,Object? duration = null,Object? heartRate = null,}) {
  return _then(_CardioSessionMetric(
distance: null == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as double,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,heartRate: null == heartRate ? _self.heartRate : heartRate // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
