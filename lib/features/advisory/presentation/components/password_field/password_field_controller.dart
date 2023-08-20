part of 'bio_password_field.dart';

class PasswordFieldController extends StateNotifier<PasswordFieldState> {
  final TextEditingController _textController;
  final TextEditingController _emailController;

  PasswordFieldController({String? email})
      : _textController = TextEditingController(),
        _emailController = TextEditingController(text: email),
        super(
          PasswordFieldState(
            isPasswordVisible: false,
            minEightChar: false,
            hasCapLetter: false,
            hasNumber: false,
            hasLowerLetter: false,
            hasSpecialCharacter: false,
            isPasswordValid: false,
          ),
        ) {
    _initPasswordListener();
  }

  String get password => _textController.text.trim();

  bool _passwordVisible = false;

  bool get isPasswordVisible => _passwordVisible;

  void changeVisibility() {
    _passwordVisible = !_passwordVisible;
    changeState();
  }

  void clearPassword() {
    _textController.clear();
    changeState();
  }

  bool _minEightChar = false;
  bool _hasCapLetter = false;
  bool _hasNumber = false;
  bool _hasLowerLetter = false;
  bool _hasSpecialCharacter = false;
  bool _isPasswordValid = false;

  bool get minEightChar => _minEightChar;

  bool get hasCapLetter => _hasCapLetter;

  bool get hasNumber => _hasNumber;

  bool get hasSpecialChar => _hasSpecialCharacter;

  bool get hasLowerLetter => _hasLowerLetter;

  bool get isPasswordValid => _isPasswordValid;

  void _initPasswordListener() {
    _textController.addListener(() {
      final capRegEx = RegExp(r'(?=.*[A-Z])\w+');
      final lowRegEx = RegExp(r'(?=.*[a-z])\w+');
      final numRegEx = RegExp('[0-9]');
      final specialCharRegEx = RegExp(r'[!@#$%^&*+(),.?":{}|<>]');

      _hasNumber = password.contains(numRegEx);
      _hasCapLetter = password.contains(capRegEx);
      _hasLowerLetter = password.contains(lowRegEx);
      _hasSpecialCharacter = password.contains(specialCharRegEx);
      _minEightChar = password.length >= 8;
      _isPasswordValid = _hasNumber &&
          _hasCapLetter &&
          _hasLowerLetter &&
          _minEightChar &&
          _hasSpecialCharacter;

      changeState();
    });
  }

  void changeState() {
    state = PasswordFieldState(
      isPasswordVisible: _passwordVisible,
      minEightChar: _minEightChar,
      hasCapLetter: _hasCapLetter,
      hasNumber: _hasNumber,
      hasLowerLetter: _hasLowerLetter,
      hasSpecialCharacter: _hasSpecialCharacter,
      isPasswordValid: _isPasswordValid,
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

final passwordFieldController = StateNotifierProvider.autoDispose<PasswordFieldController, PasswordFieldState>((ref) => PasswordFieldController());
