import 'package:end2endpoc/home/models/message.dart';

abstract class FormRepository {
  Future<String> getEncrypteText(EncryptMessage message);
  Future<String> getMessageDecrypted(DecrypMessage message);
  Future<List<EncryptedData>> getAllMessages();
}