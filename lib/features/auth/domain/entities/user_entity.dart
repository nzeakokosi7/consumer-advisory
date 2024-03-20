import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String firstName,
    required String lastName,
    required int age,
    required double height,
    required double weight,
    required String bloodGroup,
    required String genotype,
    required bool isPregnant,
    required bool isLactating,
    required bool isParent,
    @Default([]) List<String> stds,
    @Default([]) List<String> allergies,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, Object?> json) =>
      _$UserEntityFromJson(json);
}
