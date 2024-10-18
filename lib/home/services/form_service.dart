import 'package:end2endpoc/home/models/message.dart';

abstract class FormService {
  Future<List<EncryptedData>> getAllMessages();
  Future<String> getEncrypteText(EncryptMessage message);
  Future<String> getMessageDecrypted(DecrypMessage message);
}
