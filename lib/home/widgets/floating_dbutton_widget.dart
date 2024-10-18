import 'package:end2endpoc/home/screens/form_decrypt_message_screen.dart';
import 'package:flutter/material.dart';

class DecryptFloatingActionButtonWidget extends StatelessWidget {
  final Color buttonColor = const Color.fromARGB(255, 142, 194, 187);
  const DecryptFloatingActionButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: "btn2",
      backgroundColor: buttonColor,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => const FormDecryptMessageScreen()),
        );
      },
      child: const Icon(Icons.no_encryption),
    );
  }
}