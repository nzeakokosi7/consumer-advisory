// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_bio_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HealthBioEntity _$$_HealthBioEntityFromJson(Map<String, dynamic> json) =>
    _$_HealthBioEntity(
      age: json['age'] as int,
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      gender: json['gender'] as String,
      genotype: json['genotype'] as String,
      bloodGroup: json['bloodGroup'] as String,
      stds: json['stds'] as String? ?? "",
      diseases: json['diseases'] as String? ?? "",
      allergies: json['allergies'] as String? ?? "",
      isPregnant: json['isPregnant'] as bool,
      isLactating: json['isLactating'] as bool,
      isAMother: json['isAMother'] as bool,
    );

Map<String, dynamic> _$$_HealthBioEntityToJson(_$_HealthBioEntity instance) =>
    <String, dynamic>{
      'age': instance.age,
      'height': instance.height,
      'weight': instance.weight,
      'gender': instance.gender,
      'genotype': instance.genotype,
      'bloodGroup': instance.bloodGroup,
      'stds': instance.stds,
      'diseases': instance.diseases,
      'allergies': instance.allergies,
      'isPregnant': instance.isPregnant,
      'isLactating': instance.isLactating,
      'isAMother': instance.isAMother,
    };
