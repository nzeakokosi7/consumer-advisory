import 'package:freezed_annotation/freezed_annotation.dart';

part 'health_bio_entity.freezed.dart';
part 'health_bio_entity.g.dart';

@freezed
class HealthBioEntity with _$HealthBioEntity {
  const factory HealthBioEntity({
    required int age,
    required double height,
    required double weight,
    required String gender,
    required String genotype,
    required String bloodGroup,
    @Default("") String stds,
    @Default("") String diseases,
    @Default("") String allergies,
    required bool isPregnant,
    required bool isLactating,
    required bool isAMother,
  }) = _HealthBioEntity;

  factory HealthBioEntity.fromJson(Map<String, Object?> json) =>
      _$HealthBioEntityFromJson(json);
}
