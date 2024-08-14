import 'package:flutter/material.dart';
import 'package:myapp/widgets/input_title.dart';

class InputAuth extends StatelessWidget {
  const InputAuth(
      {super.key,
      required this.hint,
      required this.editingController,
      required this.title});
  final String hint;
  final TextEditingController editingController;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputTitle(x: title),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                blurRadius: 30,
                offset: const Offset(0, 6),
                color: const Color(0xffe5e7ec).withOpacity(0.5),
              ),
            ],
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: editingController,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xffA7A8b3),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(0),
            ),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
