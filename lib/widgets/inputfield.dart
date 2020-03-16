import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final bool obscure;
  final Stream<String> stream;
  final Function(String) onChanged;

  InputField({
    @required this.icon,
    @required this.hint,
    @required this.obscure,
    @required this.stream,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        return TextField(
          onChanged: onChanged,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            errorText: snapshot.hasError ? snapshot.error : null,
            icon: Icon(
              icon,
              color: Colors.white,
            ),
            hintText: hint,
            hintStyle: TextStyle(fontSize: 16, color: Colors.white),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
            contentPadding: const EdgeInsets.only(
              left: 5,
              right: 30,
              bottom: 20,
              top: 30,
            ),
          ),
          obscureText: obscure,
        );
      },
    );
  }
}
