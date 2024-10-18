import 'package:end2endpoc/home/models/message.dart';
import 'package:end2endpoc/home/services/form_service.dart';
import 'package:end2endpoc/home/widgets/floating_abutton_widget.dart';
import 'package:end2endpoc/home/widgets/floating_dbutton_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  late Future<List<EncryptedData>> _futureMessages;
  final FormService _formService = GetIt.I<FormService>();

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() {
    setState(() {
      _futureMessages = _formService.getAllMessages();
    });
  }
  Future<void> _refreshMessages() async {
    _loadMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Mensajes Encriptados'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshMessages,
        child: FutureBuilder<List<EncryptedData>>(
          future: _futureMessages,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay mensajes disponibles'));
            } else if (snapshot.hasData) {
              final messages = snapshot.data!;

              return ListView.builder(
                key: const Key('messagesList'),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return ListTile(
                    key: const Key('listTileMessage'),
                    title: Text('Mensaje ${message.id}'),
                    subtitle: Text('Palabra clave: ${message.kerWord}'),
                    trailing: ElevatedButton(
                      key: const Key('elevatedButtonMessage'),
                      onPressed: () {
                        _showEncryptedMessageDialog(context, message.textEncrypted);
                      },
                      child: const Text('Detalles'),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('No se encontraron datos'));
            }
          },
        ),
      ),
      floatingActionButton: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: CreateEncryptedMessageWidget(key: Key('encryptbutton'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: DecryptFloatingActionButtonWidget(key: Key('decryptbutton'))),
          ],
        )
    );
  }

  void _showEncryptedMessageDialog(BuildContext context, String encryptedMessage) {
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
                key: const Key('eleveatedButtonCopyMessageEncrypted'),
                icon: const Icon(Icons.copy),
                label: const Text('Copiar al Portapapeles'),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: encryptedMessage));
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
}
