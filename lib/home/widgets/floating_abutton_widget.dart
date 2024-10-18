import 'package:end2endpoc/home/screens/form_message_screen.dart';
import 'package:flutter/material.dart';

class CreateEncryptedMessageWidget extends StatelessWidget {
  final Color buttonColor = const Color(0xFF52B0A5);
  const CreateEncryptedMessageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: "btn1",
      backgroundColor: buttonColor,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => const FormMessageScreen()),
        );
      },
      child: const Icon(Icons.key),
    );
  }
}