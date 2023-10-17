import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool isLogin = true;
  String error = '';
  String snsString = 'SNS Login';

  setItemState({bool isLogin = true, error = '', snsString = 'SNS Login'}) {
    setState(() {
      this.isLogin = isLogin;
      this.snsString = snsString;
      this.error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: sizeSm, right: sizeSm),
        child: Center(
          child: SizedBox(
            height: size.height * .3,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.only(left: sizeSm, right: sizeSm),
                child: Column(
                  children: [
                    const SizedBox(height: sizeSm),
                    Text(
                      snsString,
                      style: textTheme.headlineMedium!,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: sizeSm, right: sizeSm),
                      child: Column(
                        children: [
                          TextField(
                            controller: email,
                            decoration: InputDecoration(
                              label: Text(
                                'Email',
                                style: textTheme.labelMedium!,
                              ),
                            ),
                          ),
                          TextField(
                            controller: password,
                            decoration: InputDecoration(
                              label: Text(
                                'Password',
                                style: textTheme.labelMedium!,
                              ),
                            ),
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    if (isLogin) _loginRegisterButtons() else _registerCancelButtons(),
                    const SizedBox(height: sizeSm),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row _registerCancelButtons() {
    return Row(
      children: [
        const Spacer(),
        Text(error),
        const Spacer(),
        TextButton(
          onPressed: () {
            setItemState(isLogin: true);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            try {
              await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text);
            } on FirebaseAuthException catch (fe) {
              if (fe.code == 'invalid-email') {
                setState(() {
                  error = 'Invalid Email';
                });
              }
              if (fe.code == 'weak-password') {
                setState(() {
                  error = 'Weak Password';
                });
              }
              debugPrint(fe.code);
            }
          },
          child: const Text('Register'),
        ),
      ],
    );
  }

  Row _loginRegisterButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(width: sizeSm),
        Text(
          error,
          style: TextStyle(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            setState(() {
              setItemState(isLogin: false, snsString: 'SNS Register');
            });
          },
          child: const Text('Register'),
        ),
        ElevatedButton(
          onPressed: () async {
            try {
              await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text).then(
                    (value) => debugPrint(
                      value.toString(),
                    ),
                  );
            } on FirebaseAuthException catch (fe) {
              if (fe.code == 'invalid-email') {
                setState(() {
                  error = 'Invalid Email';
                });
              }
              if (fe.code == 'wrong-password') {
                setState(() {
                  error = 'Wrong Password';
                });
              }
              if (fe.code == 'user-not-found') {
                setState(() {
                  error = 'User does not exist';
                });
              }
            }
          },
          child: const Text('Login'),
        ),
      ],
    );
  }
}
