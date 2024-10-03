import 'package:flutter/material.dart';
import 'package:studie/components/SButton';
import 'package:studie/components/mytexts.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //signing user in
  void signUserUp() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 248, 244, 244),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                //logo
                const Icon(
                  Icons.lock,
                  size: 50,
                ),
                const SizedBox(height: 0),

                //username
                Mytexts(
                  controller: usernameController,
                  hintText: 'enter email',
                  obscureText: false,
                ),
                const SizedBox(height: 20),

                //password
                Mytexts(
                  controller: passwordController,
                  hintText: 'enter password',
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                //password
                Mytexts(
                  controller: passwordController,
                  hintText: 'confirm password',
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                //sign in button
                SButton(
                  onTap: signUserUp,
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ));
  }
}
