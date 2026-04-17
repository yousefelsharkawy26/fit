// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'biometric_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BiometricProfile {

 ExperienceLevel? get experienceLevel; PrimaryGoal? get primaryGoal; List<String> get availableEquipmentIds; double? get weight; double? get height; int? get age;
/// Create a copy of BiometricProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BiometricProfileCopyWith<BiometricProfile> get copyWith => _$BiometricProfileCopyWithImpl<BiometricProfile>(this as BiometricProfile, _$identity);

  /// Serializes this BiometricProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BiometricProfile&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&(identical(other.primaryGoal, primaryGoal) || other.primaryGoal == primaryGoal)&&const DeepCollectionEquality().equals(other.availableEquipmentIds, availableEquipmentIds)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.height, height) || other.height == height)&&(identical(other.age, age) || other.age == age));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,experienceLevel,primaryGoal,const DeepCollectionEquality().hash(availableEquipmentIds),weight,height,age);

@override
String toString() {
  return 'BiometricProfile(experienceLevel: $experienceLevel, primaryGoal: $primaryGoal, availableEquipmentIds: $availableEquipmentIds, weight: $weight, height: $height, age: $age)';
}


}

/// @nodoc
abstract mixin class $BiometricProfileCopyWith<$Res>  {
  factory $BiometricProfileCopyWith(BiometricProfile value, $Res Function(BiometricProfile) _then) = _$BiometricProfileCopyWithImpl;
@useResult
$Res call({
 ExperienceLevel? experienceLevel, PrimaryGoal? primaryGoal, List<String> availableEquipmentIds, double? weight, double? height, int? age
});




}
/// @nodoc
class _$BiometricProfileCopyWithImpl<$Res>
    implements $BiometricProfileCopyWith<$Res> {
  _$BiometricProfileCopyWithImpl(this._self, this._then);

  final BiometricProfile _self;
  final $Res Function(BiometricProfile) _then;

/// Create a copy of BiometricProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? experienceLevel = freezed,Object? primaryGoal = freezed,Object? availableEquipmentIds = null,Object? weight = freezed,Object? height = freezed,Object? age = freezed,}) {
  return _then(_self.copyWith(
experienceLevel: freezed == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as ExperienceLevel?,primaryGoal: freezed == primaryGoal ? _self.primaryGoal : primaryGoal // ignore: cast_nullable_to_non_nullable
as PrimaryGoal?,availableEquipmentIds: null == availableEquipmentIds ? _self.availableEquipmentIds : availableEquipmentIds // ignore: cast_nullable_to_non_nullable
as List<String>,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [BiometricProfile].
extension BiometricProfilePatterns on BiometricProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BiometricProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BiometricProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BiometricProfile value)  $default,){
final _that = this;
switch (_that) {
case _BiometricProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BiometricProfile value)?  $default,){
final _that = this;
switch (_that) {
case _BiometricProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ExperienceLevel? experienceLevel,  PrimaryGoal? primaryGoal,  List<String> availableEquipmentIds,  double? weight,  double? height,  int? age)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BiometricProfile() when $default != null:
return $default(_that.experienceLevel,_that.primaryGoal,_that.availableEquipmentIds,_that.weight,_that.height,_that.age);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ExperienceLevel? experienceLevel,  PrimaryGoal? primaryGoal,  List<String> availableEquipmentIds,  double? weight,  double? height,  int? age)  $default,) {final _that = this;
switch (_that) {
case _BiometricProfile():
return $default(_that.experienceLevel,_that.primaryGoal,_that.availableEquipmentIds,_that.weight,_that.height,_that.age);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ExperienceLevel? experienceLevel,  PrimaryGoal? primaryGoal,  List<String> availableEquipmentIds,  double? weight,  double? height,  int? age)?  $default,) {final _that = this;
switch (_that) {
case _BiometricProfile() when $default != null:
return $default(_that.experienceLevel,_that.primaryGoal,_that.availableEquipmentIds,_that.weight,_that.height,_that.age);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BiometricProfile implements BiometricProfile {
  const _BiometricProfile({this.experienceLevel, this.primaryGoal, final  List<String> availableEquipmentIds = const [], this.weight, this.height, this.age}): _availableEquipmentIds = availableEquipmentIds;
  factory _BiometricProfile.fromJson(Map<String, dynamic> json) => _$BiometricProfileFromJson(json);

@override final  ExperienceLevel? experienceLevel;
@override final  PrimaryGoal? primaryGoal;
 final  List<String> _availableEquipmentIds;
@override@JsonKey() List<String> get availableEquipmentIds {
  if (_availableEquipmentIds is EqualUnmodifiableListView) return _availableEquipmentIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableEquipmentIds);
}

@override final  double? weight;
@override final  double? height;
@override final  int? age;

/// Create a copy of BiometricProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BiometricProfileCopyWith<_BiometricProfile> get copyWith => __$BiometricProfileCopyWithImpl<_BiometricProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BiometricProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BiometricProfile&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&(identical(other.primaryGoal, primaryGoal) || other.primaryGoal == primaryGoal)&&const DeepCollectionEquality().equals(other._availableEquipmentIds, _availableEquipmentIds)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.height, height) || other.height == height)&&(identical(other.age, age) || other.age == age));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,experienceLevel,primaryGoal,const DeepCollectionEquality().hash(_availableEquipmentIds),weight,height,age);

@override
String toString() {
  return 'BiometricProfile(experienceLevel: $experienceLevel, primaryGoal: $primaryGoal, availableEquipmentIds: $availableEquipmentIds, weight: $weight, height: $height, age: $age)';
}


}

/// @nodoc
abstract mixin class _$BiometricProfileCopyWith<$Res> implements $BiometricProfileCopyWith<$Res> {
  factory _$BiometricProfileCopyWith(_BiometricProfile value, $Res Function(_BiometricProfile) _then) = __$BiometricProfileCopyWithImpl;
@override @useResult
$Res call({
 ExperienceLevel? experienceLevel, PrimaryGoal? primaryGoal, List<String> availableEquipmentIds, double? weight, double? height, int? age
});




}
/// @nodoc
class __$BiometricProfileCopyWithImpl<$Res>
    implements _$BiometricProfileCopyWith<$Res> {
  __$BiometricProfileCopyWithImpl(this._self, this._then);

  final _BiometricProfile _self;
  final $Res Function(_BiometricProfile) _then;

/// Create a copy of BiometricProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? experienceLevel = freezed,Object? primaryGoal = freezed,Object? availableEquipmentIds = null,Object? weight = freezed,Object? height = freezed,Object? age = freezed,}) {
  return _then(_BiometricProfile(
experienceLevel: freezed == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as ExperienceLevel?,primaryGoal: freezed == primaryGoal ? _self.primaryGoal : primaryGoal // ignore: cast_nullable_to_non_nullable
as PrimaryGoal?,availableEquipmentIds: null == availableEquipmentIds ? _self._availableEquipmentIds : availableEquipmentIds // ignore: cast_nullable_to_non_nullable
as List<String>,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
