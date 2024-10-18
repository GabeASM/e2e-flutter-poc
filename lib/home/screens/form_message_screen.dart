import 'package:end2endpoc/home/models/message.dart';
import 'package:end2endpoc/home/services/form_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

class FormMessageScreen extends StatefulWidget {
  const FormMessageScreen({super.key});

  @override
  State<FormMessageScreen> createState() => _FormMessageScreenState();
}

class _FormMessageScreenState extends State<FormMessageScreen> {
  final TextEditingController textController = TextEditingController();
  final TextEditingController keyController = TextEditingController();
  final TextEditingController keywordController = TextEditingController();
  final FormService _formService = GetIt.I<FormService>();

  void _create() async {
    String text = textController.text;
    String key = keyController.text;
    String keyword = keywordController.text;
    
    EncryptMessage data = EncryptMessage(
      text: text,
      key: key,
      keyword: keyword,
    );
    String encryptedMessage = await _formService.getEncrypteText(data);
    
    _showEncryptedMessageDialog(encryptedMessage);

    textController.clear();
    keyController.clear();
    keywordController.clear();
  }

  void _showEncryptedMessageDialog(String encryptedMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Texto Encriptado'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SelectableText(encryptedMessage),
              const SizedBox(height: 20),
              ElevatedButton.icon(
              key: const Key('IconButtonCopyMessage'),
                icon: const Icon(Icons.copy),
                label: const Text('Copiar al Portapapeles'),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: encryptedMessage) );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Texto copiado al portapapeles')),
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
        title: const Text('Formulario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              key: const Key('textField'),
              controller: textController,
              decoration: const InputDecoration(labelText: 'Text'),
            ),
            TextField(
              key: const Key('KeyField'),

              controller: keyController,
              decoration: const InputDecoration(labelText: 'Key'),
            ),
            TextField(
              key: const Key('KeywordField'),

              controller: keywordController,
              decoration: const InputDecoration(labelText: 'Keyword'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _create,
              key: const Key('createButton'),
              child: const Text('Crear', ),
            ),
          ],
        ),
      ),
    );
  }
}
