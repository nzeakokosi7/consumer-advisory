class PasswordFieldState {
  final bool isPasswordVisible;
  final bool minEightChar;
  final bool hasCapLetter;
  final bool hasNumber;
  final bool hasLowerLetter;
  final bool hasSpecialCharacter;
  final bool isPasswordValid;

  PasswordFieldState({
    required this.isPasswordVisible,
    required this.minEightChar,
    required this.hasCapLetter,
    required this.hasNumber,
    required this.hasLowerLetter,
    required this.hasSpecialCharacter,
    required this.isPasswordValid,
  });
}
