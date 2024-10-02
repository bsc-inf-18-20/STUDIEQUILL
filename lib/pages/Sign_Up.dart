import 'package:flutter/material.dart';
import 'package:studie/components/my_button.dart';
import 'package:studie/components/mytexts.dart';
// import 'package:studie/components/squar_tile.dart';

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
                const SizedBox(height: 60),

                //logo
                const Icon(
                  Icons.lock,
                  size: 70,
                ),
                const SizedBox(height: 50),

                //wellcom
                Text(
                  'STUDIE APP ',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),

                //username
                Mytexts(
                  controller: usernameController,
                  hintText: 'enter username',
                  obscureText: false,
                ),
                const SizedBox(height: 10),

                //password
                Mytexts(
                  controller: passwordController,
                  hintText: 'enter password',
                  obscureText: true,
                ),

                //sign in button
                MyButton(
                  onTap: signUserUp,
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ));
  }
}

//class SignUp extends StatefulWidget {
//const SignUp({super.key});

//@override
//Widget build(BuildContext context) {
// return Scaffold();
//}
//}
