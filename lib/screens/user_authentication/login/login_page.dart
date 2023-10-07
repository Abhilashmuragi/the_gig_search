// Needed because we can't import `dart:html` into a mobile app,
// while on the flip-side access to `dart:io` throws at runtime (hence the `kIsWeb` check below)
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_gig_workers_app/main.dart';
import 'package:the_gig_workers_app/screens/user_authentication/reset_password/reset_password_page.dart';
import 'package:the_gig_workers_app/utils/values/statics.dart';

import '../../../utils/values/colors.dart';
import '../../../utils/values/numerics.dart';
import '../../../utils/values/strings.dart';
import '../../../utils/values/textStyles.dart';
import '../../../utils/widgets/components.dart';
import '../../../utils/widgets/custom_form_button.dart';
import '../../../utils/widgets/custom_input_field.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginPage extends StatefulWidget {
  static String id = '/LoginPage';

  final VoidCallback onClickLoginSignup;

  const LoginPage({super.key, required this.onClickLoginSignup});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool rememberMe = false;
  bool loginError = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, top: 61, right: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(Strings.login, textAlign: TextAlign.center, style: TextStyles.poppins28Normal()),
                                  const SizedBox(height: 28),
                                  CustomInputField(
                                      controller: _emailController,
                                      labelText: Strings.email,
                                      hintText: Strings.tempMail,
                                      validator: (textValue) {
                                        if (textValue == null || textValue.isEmpty) {
                                          return Strings.emailRequired;
                                        }
                                        if (!EmailValidator.validate(textValue)) {
                                          return Strings.enterValidMail;
                                        }
                                        return null;
                                      }),
                                  const SizedBox(height: Numerics.formFieldGap),
                                  CustomInputField(
                                    controller: _passwordController,
                                    labelText: Strings.password,
                                    hintText: Strings.yourPassword,
                                    obscureText: true,
                                    suffixIcon: true,
                                    validator: (textValue) {
                                      if (textValue == null || textValue.isEmpty) {
                                        return Strings.passwordRequired;
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: Numerics.formFieldGap),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () => navigatorKey.currentState!.pushNamed(ResetPasswordPage.id),
                                      child: Text(
                                        Strings.forgotPass,
                                        style: TextStyles.poppins12Normal(color: ColorSys.authBlue),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  CustomFormButton(
                                    innerText: Strings.login,
                                    onPressed: _handleLoginUser,
                                  ),
                                  if (loginError)
                                    Column(
                                      children: [
                                        const SizedBox(height: 18),
                                        Text(
                                          Strings.loginError,
                                          style: TextStyles.poppins14Normal(color: Colors.red),
                                        )
                                      ],
                                    ),
                                  const SizedBox(height: 52),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          height: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: Text(
                                          Strings.orContinueWith,
                                          style: TextStyles.poppins12Normal(),
                                        ),
                                      ),
                                      Flexible(
                                        child: Container(
                                          height: 1,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 52),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: signInWithGoogle,
                                        child: Image.asset(Strings.facebookLogo),
                                      ),
                                      const SizedBox(width: 24),
                                      GestureDetector(
                                        onTap: signInWithGoogle,
                                        child: Image.asset(Strings.googleLogo),
                                      ),
                                      const SizedBox(width: 24),
                                      Image.asset(Strings.linkedinLogo),
                                      if (Statics.isAppleSignInAvailable)
                                        SizedBox(height: 50, width: 100, child: SignInWithAppleButton(onPressed: signInWithApple))
                                    ],
                                  ),
                                  const SizedBox(height: Numerics.scaffoldBottomMargin),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: SizedBox(
                          width: size.width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(Strings.dontHaveAccount, style: TextStyles.poppins12Normal()),
                              GestureDetector(
                                onTap: () => {
                                  setState(() {
                                    widget.onClickLoginSignup();
                                  })
                                },
                                child: Text(Strings.signup, style: TextStyles.poppins12Normal(color: ColorSys.authBlue)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLoginUser() async {
    if (formKey.currentState!.validate() == false) return;

    //show loading circle
    showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator()));

    // login user
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      Components.showSnackBar(Strings.loginError);
      setState(() {
        loginError = true;
      });
    }

    //pop the loading circle
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credential = GoogleAuthProvider.credential(idToken: gAuth.idToken, accessToken: gAuth.accessToken);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signInWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId: 'de.lunaone.flutter.signinwithappleexample.service',

        redirectUri: Uri.parse(
          'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple',
        ),
      ),
      // TODO: Remove these if you have no need for them
      nonce: 'example-nonce',
      state: 'example-state',
    );

    // ignore: avoid_print
    print(credential);

    // This is the endpoint that will convert an authorization code obtained
    // via Sign in with Apple into a session in your system
    final signInWithAppleEndpoint = Uri(
      scheme: 'https',
      host: 'flutter-sign-in-with-apple-example.glitch.me',
      path: '/sign_in_with_apple',
      queryParameters: <String, String>{
        'code': credential.authorizationCode,
        if (credential.givenName != null) 'firstName': credential.givenName!,
        if (credential.familyName != null) 'lastName': credential.familyName!,
        'useBundleId': !kIsWeb && (Platform.isIOS || Platform.isMacOS) ? 'true' : 'false',
        if (credential.state != null) 'state': credential.state!,
      },
    );

    final session = await http.Client().post(
      signInWithAppleEndpoint,
    );

    // If we got this far, a session based on the Apple ID credential has been created in your system,
    // and you can now set this as the app's session
    // ignore: avoid_print
    print(session);

    //
    // final credential = await SignInWithApple.getAppleIDCredential
    //
    // (
    //
    // scopes: [
    // AppleIDAuthorizationScopes.email,
    // AppleIDAuthorizationScopes.fullName,
    // ],
    // // 1. perform the sign-in request
    // final result = await .performRequests(
    // [AppleIdRequest(requestedScopes: scopes)]);
    // // 2. check the result
    // switch (result.status) {
    // case AuthorizationStatus.authorized:
    // final appleIdCredential = result.credential!;
    // final oAuthProvider = OAuthProvider('apple.com');
    // final credential = oAuthProvider.credential(
    // idToken: String.fromCharCodes(appleIdCredential.identityToken!),
    // accessToken:
    // String.fromCharCodes(appleIdCredential.authorizationCode!),
    // );
    // final userCredential =
    // await FirebaseAuth.instance.signInWithCredential(credential);
    // final firebaseUser = userCredential.user!;
    // if (scopes.contains(Scope.fullName)) {
    // final fullName = appleIdCredential.fullName;
    // if (fullName != null &&
    // fullName.givenName != null &&
    // fullName.familyName != null) {
    // final displayName = '${fullName.givenName} ${fullName.familyName}';
    // await firebaseUser.updateDisplayName(displayName);
    // }
    // }
    // return firebaseUser;
    // case AuthorizationStatus.error:
    // throw PlatformException(
    // code: 'ERROR_AUTHORIZATION_DENIED',
    // message: result.error.toString(),
    // );
    //
    // case AuthorizationStatus.cancelled:
    // throw PlatformException(
    // code: 'ERROR_ABORTED_BY_USER',
    // message: 'Sign in aborted by user',
    // );
    // default:
    // throw UnimplementedError();
    // }
  }
}
