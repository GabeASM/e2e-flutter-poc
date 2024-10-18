import 'package:end2endpoc/home/models/message.dart';
import 'package:end2endpoc/home/services/form_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

class FormDecryptMessageScreen extends StatefulWidget {
  const FormDecryptMessageScreen({super.key});

  @override
  State<FormDecryptMessageScreen> createState() =>
      _FormDecryptMessageScreenState();
}

class _FormDecryptMessageScreenState extends State<FormDecryptMessageScreen> {
  final TextEditingController textController = TextEditingController();
  final TextEditingController keyController = TextEditingController();
  final FormService _formService = GetIt.I<FormService>();

  void _create() async {
    String text = textController.text;
    String key = keyController.text;

    DecrypMessage data = DecrypMessage(
      encryptedText: text,
      key: key,
    );

    String decryptedMessage = await _formService.getMessageDecrypted(data);

    _showDecryptedMessageDialog(decryptedMessage);

    textController.clear();
    keyController.clear();
  }

  void _showDecryptedMessageDialog(String decryptedMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Texto Encriptado'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SelectableText(decryptedMessage),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                key: const Key('copyDecryptedMessage'),
                icon: const Icon(Icons.copy),
                label: const Text('Copiar al Portapapeles'),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: decryptedMessage));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Texto copiado al portapapeles')),
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Dencrypt Form '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              key: const Key('textDecrypt'),
              controller: textController,
              decoration: const InputDecoration(labelText: 'Text'),
            ),
            TextField(
              key: const Key('keyDecrypt'),
              controller: keyController,
              decoration: const InputDecoration(labelText: 'Key'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              key: const Key('decryptButton'),
              onPressed: _create,
              child: const Text('Descifrar'),
            ),
          ],
        ),
      ),
    );
  }
}
