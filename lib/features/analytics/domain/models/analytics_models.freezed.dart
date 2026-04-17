// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analytics_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BiomechanicalLoadSummary {

 Map<String, double> get movementPatternBalance;// pattern -> volume
 List<CnsLoadSnapshot> get cnsFatigueTrend; Map<String, double> get muscleIntensity;// muscleId -> intensity (0.0 - 1.0+)
 List<PerformanceTrendPoint> get volumeTrend; List<PerformanceTrendPoint> get intensityTrend; List<PerformanceSnapshot> get topExercises; double get weeklyVolumeLoad;// Total kg moved
 int get sessionCount; String get recoveryStatus;
/// Create a copy of BiomechanicalLoadSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BiomechanicalLoadSummaryCopyWith<BiomechanicalLoadSummary> get copyWith => _$BiomechanicalLoadSummaryCopyWithImpl<BiomechanicalLoadSummary>(this as BiomechanicalLoadSummary, _$identity);

  /// Serializes this BiomechanicalLoadSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BiomechanicalLoadSummary&&const DeepCollectionEquality().equals(other.movementPatternBalance, movementPatternBalance)&&const DeepCollectionEquality().equals(other.cnsFatigueTrend, cnsFatigueTrend)&&const DeepCollectionEquality().equals(other.muscleIntensity, muscleIntensity)&&const DeepCollectionEquality().equals(other.volumeTrend, volumeTrend)&&const DeepCollectionEquality().equals(other.intensityTrend, intensityTrend)&&const DeepCollectionEquality().equals(other.topExercises, topExercises)&&(identical(other.weeklyVolumeLoad, weeklyVolumeLoad) || other.weeklyVolumeLoad == weeklyVolumeLoad)&&(identical(other.sessionCount, sessionCount) || other.sessionCount == sessionCount)&&(identical(other.recoveryStatus, recoveryStatus) || other.recoveryStatus == recoveryStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(movementPatternBalance),const DeepCollectionEquality().hash(cnsFatigueTrend),const DeepCollectionEquality().hash(muscleIntensity),const DeepCollectionEquality().hash(volumeTrend),const DeepCollectionEquality().hash(intensityTrend),const DeepCollectionEquality().hash(topExercises),weeklyVolumeLoad,sessionCount,recoveryStatus);

@override
String toString() {
  return 'BiomechanicalLoadSummary(movementPatternBalance: $movementPatternBalance, cnsFatigueTrend: $cnsFatigueTrend, muscleIntensity: $muscleIntensity, volumeTrend: $volumeTrend, intensityTrend: $intensityTrend, topExercises: $topExercises, weeklyVolumeLoad: $weeklyVolumeLoad, sessionCount: $sessionCount, recoveryStatus: $recoveryStatus)';
}


}

/// @nodoc
abstract mixin class $BiomechanicalLoadSummaryCopyWith<$Res>  {
  factory $BiomechanicalLoadSummaryCopyWith(BiomechanicalLoadSummary value, $Res Function(BiomechanicalLoadSummary) _then) = _$BiomechanicalLoadSummaryCopyWithImpl;
@useResult
$Res call({
 Map<String, double> movementPatternBalance, List<CnsLoadSnapshot> cnsFatigueTrend, Map<String, double> muscleIntensity, List<PerformanceTrendPoint> volumeTrend, List<PerformanceTrendPoint> intensityTrend, List<PerformanceSnapshot> topExercises, double weeklyVolumeLoad, int sessionCount, String recoveryStatus
});




}
/// @nodoc
class _$BiomechanicalLoadSummaryCopyWithImpl<$Res>
    implements $BiomechanicalLoadSummaryCopyWith<$Res> {
  _$BiomechanicalLoadSummaryCopyWithImpl(this._self, this._then);

  final BiomechanicalLoadSummary _self;
  final $Res Function(BiomechanicalLoadSummary) _then;

/// Create a copy of BiomechanicalLoadSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? movementPatternBalance = null,Object? cnsFatigueTrend = null,Object? muscleIntensity = null,Object? volumeTrend = null,Object? intensityTrend = null,Object? topExercises = null,Object? weeklyVolumeLoad = null,Object? sessionCount = null,Object? recoveryStatus = null,}) {
  return _then(_self.copyWith(
movementPatternBalance: null == movementPatternBalance ? _self.movementPatternBalance : movementPatternBalance // ignore: cast_nullable_to_non_nullable
as Map<String, double>,cnsFatigueTrend: null == cnsFatigueTrend ? _self.cnsFatigueTrend : cnsFatigueTrend // ignore: cast_nullable_to_non_nullable
as List<CnsLoadSnapshot>,muscleIntensity: null == muscleIntensity ? _self.muscleIntensity : muscleIntensity // ignore: cast_nullable_to_non_nullable
as Map<String, double>,volumeTrend: null == volumeTrend ? _self.volumeTrend : volumeTrend // ignore: cast_nullable_to_non_nullable
as List<PerformanceTrendPoint>,intensityTrend: null == intensityTrend ? _self.intensityTrend : intensityTrend // ignore: cast_nullable_to_non_nullable
as List<PerformanceTrendPoint>,topExercises: null == topExercises ? _self.topExercises : topExercises // ignore: cast_nullable_to_non_nullable
as List<PerformanceSnapshot>,weeklyVolumeLoad: null == weeklyVolumeLoad ? _self.weeklyVolumeLoad : weeklyVolumeLoad // ignore: cast_nullable_to_non_nullable
as double,sessionCount: null == sessionCount ? _self.sessionCount : sessionCount // ignore: cast_nullable_to_non_nullable
as int,recoveryStatus: null == recoveryStatus ? _self.recoveryStatus : recoveryStatus // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BiomechanicalLoadSummary].
extension BiomechanicalLoadSummaryPatterns on BiomechanicalLoadSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BiomechanicalLoadSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BiomechanicalLoadSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BiomechanicalLoadSummary value)  $default,){
final _that = this;
switch (_that) {
case _BiomechanicalLoadSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BiomechanicalLoadSummary value)?  $default,){
final _that = this;
switch (_that) {
case _BiomechanicalLoadSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, double> movementPatternBalance,  List<CnsLoadSnapshot> cnsFatigueTrend,  Map<String, double> muscleIntensity,  List<PerformanceTrendPoint> volumeTrend,  List<PerformanceTrendPoint> intensityTrend,  List<PerformanceSnapshot> topExercises,  double weeklyVolumeLoad,  int sessionCount,  String recoveryStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BiomechanicalLoadSummary() when $default != null:
return $default(_that.movementPatternBalance,_that.cnsFatigueTrend,_that.muscleIntensity,_that.volumeTrend,_that.intensityTrend,_that.topExercises,_that.weeklyVolumeLoad,_that.sessionCount,_that.recoveryStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, double> movementPatternBalance,  List<CnsLoadSnapshot> cnsFatigueTrend,  Map<String, double> muscleIntensity,  List<PerformanceTrendPoint> volumeTrend,  List<PerformanceTrendPoint> intensityTrend,  List<PerformanceSnapshot> topExercises,  double weeklyVolumeLoad,  int sessionCount,  String recoveryStatus)  $default,) {final _that = this;
switch (_that) {
case _BiomechanicalLoadSummary():
return $default(_that.movementPatternBalance,_that.cnsFatigueTrend,_that.muscleIntensity,_that.volumeTrend,_that.intensityTrend,_that.topExercises,_that.weeklyVolumeLoad,_that.sessionCount,_that.recoveryStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, double> movementPatternBalance,  List<CnsLoadSnapshot> cnsFatigueTrend,  Map<String, double> muscleIntensity,  List<PerformanceTrendPoint> volumeTrend,  List<PerformanceTrendPoint> intensityTrend,  List<PerformanceSnapshot> topExercises,  double weeklyVolumeLoad,  int sessionCount,  String recoveryStatus)?  $default,) {final _that = this;
switch (_that) {
case _BiomechanicalLoadSummary() when $default != null:
return $default(_that.movementPatternBalance,_that.cnsFatigueTrend,_that.muscleIntensity,_that.volumeTrend,_that.intensityTrend,_that.topExercises,_that.weeklyVolumeLoad,_that.sessionCount,_that.recoveryStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BiomechanicalLoadSummary implements BiomechanicalLoadSummary {
  const _BiomechanicalLoadSummary({required final  Map<String, double> movementPatternBalance, required final  List<CnsLoadSnapshot> cnsFatigueTrend, required final  Map<String, double> muscleIntensity, required final  List<PerformanceTrendPoint> volumeTrend, required final  List<PerformanceTrendPoint> intensityTrend, required final  List<PerformanceSnapshot> topExercises, required this.weeklyVolumeLoad, required this.sessionCount, required this.recoveryStatus}): _movementPatternBalance = movementPatternBalance,_cnsFatigueTrend = cnsFatigueTrend,_muscleIntensity = muscleIntensity,_volumeTrend = volumeTrend,_intensityTrend = intensityTrend,_topExercises = topExercises;
  factory _BiomechanicalLoadSummary.fromJson(Map<String, dynamic> json) => _$BiomechanicalLoadSummaryFromJson(json);

 final  Map<String, double> _movementPatternBalance;
@override Map<String, double> get movementPatternBalance {
  if (_movementPatternBalance is EqualUnmodifiableMapView) return _movementPatternBalance;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_movementPatternBalance);
}

// pattern -> volume
 final  List<CnsLoadSnapshot> _cnsFatigueTrend;
// pattern -> volume
@override List<CnsLoadSnapshot> get cnsFatigueTrend {
  if (_cnsFatigueTrend is EqualUnmodifiableListView) return _cnsFatigueTrend;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cnsFatigueTrend);
}

 final  Map<String, double> _muscleIntensity;
@override Map<String, double> get muscleIntensity {
  if (_muscleIntensity is EqualUnmodifiableMapView) return _muscleIntensity;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_muscleIntensity);
}

// muscleId -> intensity (0.0 - 1.0+)
 final  List<PerformanceTrendPoint> _volumeTrend;
// muscleId -> intensity (0.0 - 1.0+)
@override List<PerformanceTrendPoint> get volumeTrend {
  if (_volumeTrend is EqualUnmodifiableListView) return _volumeTrend;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_volumeTrend);
}

 final  List<PerformanceTrendPoint> _intensityTrend;
@override List<PerformanceTrendPoint> get intensityTrend {
  if (_intensityTrend is EqualUnmodifiableListView) return _intensityTrend;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_intensityTrend);
}

 final  List<PerformanceSnapshot> _topExercises;
@override List<PerformanceSnapshot> get topExercises {
  if (_topExercises is EqualUnmodifiableListView) return _topExercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topExercises);
}

@override final  double weeklyVolumeLoad;
// Total kg moved
@override final  int sessionCount;
@override final  String recoveryStatus;

/// Create a copy of BiomechanicalLoadSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BiomechanicalLoadSummaryCopyWith<_BiomechanicalLoadSummary> get copyWith => __$BiomechanicalLoadSummaryCopyWithImpl<_BiomechanicalLoadSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BiomechanicalLoadSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BiomechanicalLoadSummary&&const DeepCollectionEquality().equals(other._movementPatternBalance, _movementPatternBalance)&&const DeepCollectionEquality().equals(other._cnsFatigueTrend, _cnsFatigueTrend)&&const DeepCollectionEquality().equals(other._muscleIntensity, _muscleIntensity)&&const DeepCollectionEquality().equals(other._volumeTrend, _volumeTrend)&&const DeepCollectionEquality().equals(other._intensityTrend, _intensityTrend)&&const DeepCollectionEquality().equals(other._topExercises, _topExercises)&&(identical(other.weeklyVolumeLoad, weeklyVolumeLoad) || other.weeklyVolumeLoad == weeklyVolumeLoad)&&(identical(other.sessionCount, sessionCount) || other.sessionCount == sessionCount)&&(identical(other.recoveryStatus, recoveryStatus) || other.recoveryStatus == recoveryStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_movementPatternBalance),const DeepCollectionEquality().hash(_cnsFatigueTrend),const DeepCollectionEquality().hash(_muscleIntensity),const DeepCollectionEquality().hash(_volumeTrend),const DeepCollectionEquality().hash(_intensityTrend),const DeepCollectionEquality().hash(_topExercises),weeklyVolumeLoad,sessionCount,recoveryStatus);

@override
String toString() {
  return 'BiomechanicalLoadSummary(movementPatternBalance: $movementPatternBalance, cnsFatigueTrend: $cnsFatigueTrend, muscleIntensity: $muscleIntensity, volumeTrend: $volumeTrend, intensityTrend: $intensityTrend, topExercises: $topExercises, weeklyVolumeLoad: $weeklyVolumeLoad, sessionCount: $sessionCount, recoveryStatus: $recoveryStatus)';
}


}

/// @nodoc
abstract mixin class _$BiomechanicalLoadSummaryCopyWith<$Res> implements $BiomechanicalLoadSummaryCopyWith<$Res> {
  factory _$BiomechanicalLoadSummaryCopyWith(_BiomechanicalLoadSummary value, $Res Function(_BiomechanicalLoadSummary) _then) = __$BiomechanicalLoadSummaryCopyWithImpl;
@override @useResult
$Res call({
 Map<String, double> movementPatternBalance, List<CnsLoadSnapshot> cnsFatigueTrend, Map<String, double> muscleIntensity, List<PerformanceTrendPoint> volumeTrend, List<PerformanceTrendPoint> intensityTrend, List<PerformanceSnapshot> topExercises, double weeklyVolumeLoad, int sessionCount, String recoveryStatus
});




}
/// @nodoc
class __$BiomechanicalLoadSummaryCopyWithImpl<$Res>
    implements _$BiomechanicalLoadSummaryCopyWith<$Res> {
  __$BiomechanicalLoadSummaryCopyWithImpl(this._self, this._then);

  final _BiomechanicalLoadSummary _self;
  final $Res Function(_BiomechanicalLoadSummary) _then;

/// Create a copy of BiomechanicalLoadSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? movementPatternBalance = null,Object? cnsFatigueTrend = null,Object? muscleIntensity = null,Object? volumeTrend = null,Object? intensityTrend = null,Object? topExercises = null,Object? weeklyVolumeLoad = null,Object? sessionCount = null,Object? recoveryStatus = null,}) {
  return _then(_BiomechanicalLoadSummary(
movementPatternBalance: null == movementPatternBalance ? _self._movementPatternBalance : movementPatternBalance // ignore: cast_nullable_to_non_nullable
as Map<String, double>,cnsFatigueTrend: null == cnsFatigueTrend ? _self._cnsFatigueTrend : cnsFatigueTrend // ignore: cast_nullable_to_non_nullable
as List<CnsLoadSnapshot>,muscleIntensity: null == muscleIntensity ? _self._muscleIntensity : muscleIntensity // ignore: cast_nullable_to_non_nullable
as Map<String, double>,volumeTrend: null == volumeTrend ? _self._volumeTrend : volumeTrend // ignore: cast_nullable_to_non_nullable
as List<PerformanceTrendPoint>,intensityTrend: null == intensityTrend ? _self._intensityTrend : intensityTrend // ignore: cast_nullable_to_non_nullable
as List<PerformanceTrendPoint>,topExercises: null == topExercises ? _self._topExercises : topExercises // ignore: cast_nullable_to_non_nullable
as List<PerformanceSnapshot>,weeklyVolumeLoad: null == weeklyVolumeLoad ? _self.weeklyVolumeLoad : weeklyVolumeLoad // ignore: cast_nullable_to_non_nullable
as double,sessionCount: null == sessionCount ? _self.sessionCount : sessionCount // ignore: cast_nullable_to_non_nullable
as int,recoveryStatus: null == recoveryStatus ? _self.recoveryStatus : recoveryStatus // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PerformanceTrendPoint {

 DateTime get date; double get value;
/// Create a copy of PerformanceTrendPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceTrendPointCopyWith<PerformanceTrendPoint> get copyWith => _$PerformanceTrendPointCopyWithImpl<PerformanceTrendPoint>(this as PerformanceTrendPoint, _$identity);

  /// Serializes this PerformanceTrendPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceTrendPoint&&(identical(other.date, date) || other.date == date)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,value);

@override
String toString() {
  return 'PerformanceTrendPoint(date: $date, value: $value)';
}


}

/// @nodoc
abstract mixin class $PerformanceTrendPointCopyWith<$Res>  {
  factory $PerformanceTrendPointCopyWith(PerformanceTrendPoint value, $Res Function(PerformanceTrendPoint) _then) = _$PerformanceTrendPointCopyWithImpl;
@useResult
$Res call({
 DateTime date, double value
});




}
/// @nodoc
class _$PerformanceTrendPointCopyWithImpl<$Res>
    implements $PerformanceTrendPointCopyWith<$Res> {
  _$PerformanceTrendPointCopyWithImpl(this._self, this._then);

  final PerformanceTrendPoint _self;
  final $Res Function(PerformanceTrendPoint) _then;

/// Create a copy of PerformanceTrendPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? value = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PerformanceTrendPoint].
extension PerformanceTrendPointPatterns on PerformanceTrendPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PerformanceTrendPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PerformanceTrendPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PerformanceTrendPoint value)  $default,){
final _that = this;
switch (_that) {
case _PerformanceTrendPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PerformanceTrendPoint value)?  $default,){
final _that = this;
switch (_that) {
case _PerformanceTrendPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  double value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PerformanceTrendPoint() when $default != null:
return $default(_that.date,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  double value)  $default,) {final _that = this;
switch (_that) {
case _PerformanceTrendPoint():
return $default(_that.date,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  double value)?  $default,) {final _that = this;
switch (_that) {
case _PerformanceTrendPoint() when $default != null:
return $default(_that.date,_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PerformanceTrendPoint implements PerformanceTrendPoint {
  const _PerformanceTrendPoint({required this.date, required this.value});
  factory _PerformanceTrendPoint.fromJson(Map<String, dynamic> json) => _$PerformanceTrendPointFromJson(json);

@override final  DateTime date;
@override final  double value;

/// Create a copy of PerformanceTrendPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PerformanceTrendPointCopyWith<_PerformanceTrendPoint> get copyWith => __$PerformanceTrendPointCopyWithImpl<_PerformanceTrendPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PerformanceTrendPointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PerformanceTrendPoint&&(identical(other.date, date) || other.date == date)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,value);

@override
String toString() {
  return 'PerformanceTrendPoint(date: $date, value: $value)';
}


}

/// @nodoc
abstract mixin class _$PerformanceTrendPointCopyWith<$Res> implements $PerformanceTrendPointCopyWith<$Res> {
  factory _$PerformanceTrendPointCopyWith(_PerformanceTrendPoint value, $Res Function(_PerformanceTrendPoint) _then) = __$PerformanceTrendPointCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, double value
});




}
/// @nodoc
class __$PerformanceTrendPointCopyWithImpl<$Res>
    implements _$PerformanceTrendPointCopyWith<$Res> {
  __$PerformanceTrendPointCopyWithImpl(this._self, this._then);

  final _PerformanceTrendPoint _self;
  final $Res Function(_PerformanceTrendPoint) _then;

/// Create a copy of PerformanceTrendPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? value = null,}) {
  return _then(_PerformanceTrendPoint(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
