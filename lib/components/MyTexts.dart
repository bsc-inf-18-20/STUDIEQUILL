// import 'package:flutter/material.dart';

// class Mytexts extends StatelessWidget {
//   // ignore: prefer_typing_uninitialized_variables
//   final controller;
//   // final TextEditingController controller;
//   final String hintText;
//   final bool obscureText;

//   const Mytexts({
//     super.key,
//     required this.controller,
//     required this.hintText,
//     required this.obscureText,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 25.0),
//       child: TextField(
//         controller: controller,
//         obscureText: obscureText,
//         decoration: InputDecoration(
//           enabledBorder: const OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.white),
//           ),
//           focusedBorder: const OutlineInputBorder(
//             borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
//           ),
//           fillColor: const Color.fromARGB(255, 219, 216, 216),
//           filled: true,
//           hintText: hintText,
//           hintStyle: TextStyle(color: Colors.grey[500]),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class Mytexts extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData? icon; // Optional icon parameter

  const Mytexts({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.icon, // Initialize the icon parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon:
              icon != null ? Icon(icon) : null, // Display icon if provided
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
          ),
          fillColor: const Color.fromARGB(255, 219, 216, 216),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}
