class EncryptMessage {
  final String text;
  final String key;
  final String keyword;

  EncryptMessage({required this.text, required this.key, required this.keyword});
}
class DecrypMessage{
  final String encryptedText;
  final String key;

  DecrypMessage({required this.encryptedText, required this.key});
}

class EncryptedData {
  final int id;
  final String textEncrypted;
  final String kerWord;

  EncryptedData({
    required this.id,
    required this.textEncrypted,
    required this.kerWord,
  });

  factory EncryptedData.fromJson(Map<String, dynamic> json) {
    return EncryptedData(
      id: json['id'] as int,
      textEncrypted: json['textEncrypted'] as String,
      kerWord: json['kerWord'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'textEncrypted': textEncrypted,
      'kerWord': kerWord,
    };
  }
}
