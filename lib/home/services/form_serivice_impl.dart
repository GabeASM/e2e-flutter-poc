import 'package:end2endpoc/home/models/message.dart';
import 'package:end2endpoc/home/repository/form_repository.dart';
import 'package:end2endpoc/home/services/form_service.dart';

class FormServiceImpl implements FormService{

  final FormRepository _formRepository;

  FormServiceImpl(this._formRepository);
  

  @override
  Future<List<EncryptedData>> getAllMessages() async {
    final result = await _formRepository.getAllMessages();
    return result;
  }

  @override
  Future<String> getEncrypteText(EncryptMessage message) async {
    final result = await _formRepository.getEncrypteText(message);
    return result;
  }

  @override
  Future<String> getMessageDecrypted(DecrypMessage message) async {
    final result = await _formRepository.getMessageDecrypted(message);
    return result;
  }
}