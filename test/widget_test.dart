import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:catatanqu/main.dart';

void main() {
  testWidgets('main note flow supports add and delete', (tester) async {
    tester.view.physicalSize = const Size(720, 1600);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const CatatanKuApp());
    expect(find.text('CatatanKu'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 2500));
    await tester.pumpAndSettle();
    expect(find.text('Masuk untuk melanjutkan'), findsOneWidget);

    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();
    expect(find.text('Halo, Ivan Mahendra'), findsOneWidget);
    expect(find.text('Ide Aplikasi'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Ide Aplikasi');
    await tester.pump();
    expect(find.text('Ide Aplikasi'), findsNWidgets(2));
    expect(find.text('Rencana Mingguan'), findsNothing);
    await tester.enterText(find.byType(TextField), '');
    await tester.pump();
    await tester.tap(find.text('Pribadi'));
    await tester.pump();
    expect(find.text('Catatan Kuliah'), findsOneWidget);
    expect(find.text('Ide Aplikasi'), findsNothing);
    await tester.tap(find.text('Semua'));
    await tester.pump();

    await tester.tap(find.byTooltip('Tambah catatan'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byWidgetPredicate(
        (widget) =>
            widget is TextField &&
            widget.decoration?.hintText == 'Masukkan judul catatan',
      ),
      'Catatan Baru',
    );
    await tester.enterText(
      find.byWidgetPredicate(
        (widget) =>
            widget is TextField &&
            widget.decoration?.hintText == 'Tulis catatan Anda di sini…',
      ),
      'Isi catatan baru.',
    );
    await tester.ensureVisible(find.text('Simpan'));
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();
    expect(find.text('Catatan disimpan'), findsOneWidget);
    expect(find.text('Catatan Baru'), findsOneWidget);

    await tester.tap(find.text('Catatan Baru'));
    await tester.pumpAndSettle();
    expect(find.text('Isi catatan baru.'), findsOneWidget);
    await tester.tap(find.byTooltip('Hapus catatan'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Hapus'));
    await tester.pumpAndSettle();
    expect(find.text('Catatan Baru'), findsNothing);
  });
}
