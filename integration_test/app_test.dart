import 'package:end2endpoc/home/repository/form_repository.dart';
import 'package:end2endpoc/home/repository/form_repository_impl.dart';
import 'package:end2endpoc/home/services/form_serivice_impl.dart';
import 'package:end2endpoc/home/services/form_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';
import 'package:end2endpoc/main.dart' as app;
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    GetIt.I.reset();  
    GetIt.I.registerSingleton<FormRepository>(FormRepositoryImpl());
    GetIt.I.registerFactory<FormService>(
        () => FormServiceImpl(GetIt.I<FormRepository>()));
  });

  tearDown(() {
    GetIt.I.reset(); 
  });

  group('Pruebas e2e - Cifrado de mensaje', () {
    testWidgets('Probar flujo de cifrado de mensaje', (WidgetTester tester) async {
      app.main();  
      await tester.pumpAndSettle();

      final Finder encryptButton = find.byKey(const Key('encryptbutton'));
      expect(encryptButton, findsOneWidget);
      await tester.tap(encryptButton);
      await tester.pumpAndSettle();

      final Finder textField = find.byKey(const Key('textField'));
      final Finder keyField = find.byKey(const Key('KeyField'));
      final Finder keywordField = find.byKey(const Key('KeywordField'));

      await tester.enterText(textField, 'TextoACifrar');
      await tester.enterText(keyField, 'Clave123');
      await tester.enterText(keywordField, 'PalabraClave');
      await tester.pumpAndSettle();

      final Finder createButton = find.byKey(const Key('createButton'));
      expect(createButton, findsOneWidget);
      await tester.tap(createButton);
      await tester.pumpAndSettle();

      final Finder encryptedDialogTitle = find.text('Texto Encriptado');
      expect(encryptedDialogTitle, findsOneWidget);

      final Finder encryptedMessageText = find.byType(SelectableText);
      expect(encryptedMessageText, findsOneWidget);

      final Finder copyButton = find.byKey(const Key('IconButtonCopyMessage'));
      await tester.tap(copyButton);
      await tester.pumpAndSettle();

      expect(find.text('Texto copiado al portapapeles'), findsOneWidget);
      final Finder closeButton = find.text('Cerrar');
      await tester.tap(closeButton);
      await tester.pumpAndSettle();
    });
  });

  group('Pruebas e2e - Copiar mensaje encriptado', () {
    testWidgets(
        'Ver lista de mensajes, seleccionar uno y copiar mensaje encriptado',
        (WidgetTester tester) async {
      app.main();  
      await tester.pumpAndSettle();
      final Finder messagesList = find.byKey(const Key('messagesList'));
      expect(messagesList, findsOneWidget);


      final Finder listTileMessage =
          find.byKey(const Key('listTileMessage')).first;
      expect(listTileMessage,
          findsWidgets); 

      final Finder elevatedButtonMessage =
          find.byKey(const Key('elevatedButtonMessage')).first;
      await tester.tap(elevatedButtonMessage);
      await tester.pumpAndSettle();

      final Finder encryptedDialogTitle = find.text('Texto Encriptado');
      expect(encryptedDialogTitle, findsOneWidget);

      final Finder encryptedMessageText = find.byType(SelectableText);
      expect(encryptedMessageText, findsOneWidget);


      final Finder copyButton =
          find.byKey(const Key('eleveatedButtonCopyMessageEncrypted'));
      await tester.tap(copyButton);
      await tester.pumpAndSettle();


      expect(find.text('Texto copiado al portapapeles'), findsOneWidget);

      final Finder closeButton = find.text('Cerrar');
      await tester.tap(closeButton);
      await tester.pumpAndSettle();
    });
  });

 group('Pruebas e2e - Cifrar y descifrar mensaje', () {
    testWidgets('Seleccionar mensaje encriptado, descifrarlo y copiarlo', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final Finder messagesList = find.byKey(const Key('messagesList'));
      expect(messagesList, findsOneWidget);

      final Finder listTileMessage = find.byKey(const Key('listTileMessage')).first;
      expect(listTileMessage, findsWidgets); 

      final Finder elevatedButtonMessage = find.byKey(const Key('elevatedButtonMessage')).first;
      await tester.tap(elevatedButtonMessage);
      await tester.pumpAndSettle();
      final Finder encryptedDialogTitle = find.text('Texto Encriptado');
      expect(encryptedDialogTitle, findsOneWidget);

      final Finder encryptedMessageText = find.byType(SelectableText);
      expect(encryptedMessageText, findsOneWidget);

      final Finder copyButton = find.byKey(const Key('eleveatedButtonCopyMessageEncrypted'));
      await tester.tap(copyButton);
      await tester.pumpAndSettle();

      final String encryptedMessage = (encryptedMessageText.evaluate().single.widget as SelectableText).data ?? '';

      expect(find.text('Texto copiado al portapapeles'), findsOneWidget);

      final Finder closeButton = find.text('Cerrar');
      await tester.tap(closeButton);
      await tester.pumpAndSettle();

      final Finder decryptButton = find.byKey(const Key('decryptbutton'));
      expect(decryptButton, findsOneWidget);
      await tester.tap(decryptButton);
      await tester.pumpAndSettle();

      final Finder textFieldDecrypt = find.byKey(const Key('textDecrypt'));
      final Finder keyFieldDecrypt = find.byKey(const Key('keyDecrypt'));
      expect(textFieldDecrypt, findsOneWidget);
      expect(keyFieldDecrypt, findsOneWidget);

      await tester.enterText(textFieldDecrypt, encryptedMessage); 
      await tester.enterText(keyFieldDecrypt, 'Clave123');
      await tester.pumpAndSettle();

      final Finder decryptSubmitButton = find.byKey(const Key('decryptButton'));
      expect(decryptSubmitButton, findsOneWidget);
      await tester.tap(decryptSubmitButton);
      await tester.pumpAndSettle();

      final Finder decryptedDialogTitle = find.text('Texto Encriptado');
      expect(decryptedDialogTitle, findsOneWidget);

      final Finder decryptedMessageText = find.byType(SelectableText);
      expect(decryptedMessageText, findsOneWidget);

      final Finder copyDecryptedButton = find.byKey(const Key('copyDecryptedMessage'));
      await tester.tap(copyDecryptedButton);
      await tester.pumpAndSettle();

      expect(find.text('Texto copiado al portapapeles'), findsOneWidget);

      final Finder closeDecryptedButton = find.text('Cerrar');
      await tester.tap(closeDecryptedButton);
      await tester.pumpAndSettle();
    });
  });
}
