// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserEntity _$$_UserEntityFromJson(Map<String, dynamic> json) =>
    _$_UserEntity(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      age: json['age'] as int,
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      bloodGroup: json['bloodGroup'] as String,
      genotype: json['genotype'] as String,
      isPregnant: json['isPregnant'] as bool,
      isLactating: json['isLactating'] as bool,
      isParent: json['isParent'] as bool,
      stds:
          (json['stds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      allergies: (json['allergies'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_UserEntityToJson(_$_UserEntity instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'age': instance.age,
      'height': instance.height,
      'weight': instance.weight,
      'bloodGroup': instance.bloodGroup,
      'genotype': instance.genotype,
      'isPregnant': instance.isPregnant,
      'isLactating': instance.isLactating,
      'isParent': instance.isParent,
      'stds': instance.stds,
      'allergies': instance.allergies,
    };
