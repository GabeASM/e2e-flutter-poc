import 'package:dio/dio.dart';
import 'package:end2endpoc/home/models/message.dart';
import 'package:end2endpoc/home/repository/form_repository.dart';
import 'package:end2endpoc/global.dart' as global;

class FormRepositoryImpl implements FormRepository {
  final Dio _dio = Dio();
  final String baseUrl = 'http://${global.ipNetwork}:3000/';
  final String ipBase = global.ipNetwork;
  FormRepositoryImpl() {
    _dio.options.baseUrl = baseUrl;
  }

  @override
  Future<List<EncryptedData>> getAllMessages() async {
    try {
      final response = await _dio.get('/cypher');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data as List<dynamic>;

        List<EncryptedData> messages =
            data.map((item) => EncryptedData.fromJson(item)).toList();

        return messages;
      } else {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } on DioException catch (error) {
      print('Error al obtener mensajes: $error');
      throw Exception('Error en la conexión al servidor');
    } catch (error) {
      print('Error inesperado: $error');
      throw Exception('Error inesperado al obtener mensajes');
    }
  }

  @override
  Future<String> getEncrypteText(EncryptMessage message) async {
    try {
      print('preparando data');
      Map<String, dynamic> sendData = {
        'text': message.text,
        'key': message.key,
        'keyword': message.keyword
      };
      print('enviando data');

      final response = await _dio.post('cypher/encrypt', data: sendData);
      print('data enviada');

      if (response.statusCode == 201) {
        print('respuesta correcta');

        return response.data['encryptedText'] as String;
      } else {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } on DioException catch (error) {
      print('Error en la conexión: $error');
      throw Exception('Error en la conexión al servidor');
    } catch (error) {
      print('Error inesperado: $error');
      throw Exception('Error inesperado al cifrar el texto');
    }
  }

  @override
  Future<String> getMessageDecrypted(DecrypMessage message) async {
    try {
      Map<String, dynamic> sendData = {
        'encryptedText':
            message.encryptedText, 
        'key': message.key,
      };
      final response = await _dio.post('cypher/decrypt', data: sendData);
      if (response.statusCode == 201) {
        return response.data['decryptedText'] as String;
      } else {
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } on DioException catch (error) {
      print('Error en la conexión: $error');
      throw Exception('Error en la conexión al servidor');
    } catch (error) {
      print('Error inesperado: $error');
      throw Exception('Error inesperado al descifrar el texto');
    }
  }
}
