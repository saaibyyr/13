import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bottom_aierke/presentation/screen/qr_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class MockQRViewController extends Mock implements QRViewController {}

class MockBarcode extends Mock implements Barcode {}

void main() {
  group('QRScanApp Tests', () {
    late MockQRViewController mockController;
    late StreamController<Barcode> barcodeStreamController;

    setUp(() {
      mockController = MockQRViewController();
      barcodeStreamController = StreamController<Barcode>();

      when(mockController.scannedDataStream)
          .thenAnswer((_) => barcodeStreamController.stream);
    });

    tearDown(() {
      barcodeStreamController.close();
    });

    testWidgets('QRScanApp creates its state correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: QRScanApp()));

      expect(find.byType(QRView), findsOneWidget);
    });

    testWidgets('Valid QR Code scan shows correct toast',
        (WidgetTester tester) async {
      var mockBarcode = MockBarcode();
      when(mockBarcode.code).thenReturn('Valid QR Code');

      await tester.pumpWidget(MaterialApp(home: QRScanApp()));

      barcodeStreamController.add(mockBarcode);

      await tester.pumpAndSettle();
    });

    testWidgets('Empty QR Code scan shows error toast',
        (WidgetTester tester) async {
      var emptyBarcode = MockBarcode();
      when(emptyBarcode.code).thenReturn(null);

      await tester.pumpWidget(MaterialApp(home: QRScanApp()));
      barcodeStreamController.add(emptyBarcode);

      await tester.pumpAndSettle();
    });

    testWidgets('dispose method disposes controller',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: QRScanApp()));
      await tester.pumpAndSettle();

      await tester.binding.runAsync(() => barcodeStreamController.close());

      verify(mockController.dispose()).called(1);
    });
  });
}
