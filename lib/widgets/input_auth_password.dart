import 'package:flutter/material.dart';
import 'package:myapp/widgets/input_title.dart';

class InputAuthPassword extends StatefulWidget {
  const InputAuthPassword(
      {super.key,
      required this.hint,
      required this.editingController,
      required this.title});
  final String hint;
  final TextEditingController editingController;
  final String title;

  @override
  State<InputAuthPassword> createState() => _InputAuthPasswordState();
}

class _InputAuthPasswordState extends State<InputAuthPassword> {
  bool hide = true;
  setHide() {
    hide = !hide;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputTitle(x: widget.title),
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
          padding: const EdgeInsets.only(left: 20, right: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  obscureText: hide,
                  controller: widget.editingController,
                  decoration: InputDecoration(
                    hintText: widget.hint,
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
              IconButton(
                onPressed: setHide,
                icon: ImageIcon(AssetImage(
                  hide ? 'assets/ic_eye_closed.png' : 'assets/ic_eye_open.png',
                )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
