import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSignInAvailable {
  final bool isAvailable;

  AppleSignInAvailable(this.isAvailable);

  static Future<bool?> check() async {
    return await SignInWithApple.isAvailable();
  }
}
