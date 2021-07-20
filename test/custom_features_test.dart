@TestOn('!chrome')

import 'package:data_table_2/data_table_2.dart';
import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_utils.dart';

void main() {
  group('DataTable2', () {
    testWidgets('Default column size is applied to header cells',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Material(child: buildTable()),
      ));

      await _defaultColumnSizeApplied(tester, true);
    });

    testWidgets('Default column size is applied to data cells',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Material(child: buildTable()),
      ));

      await _defaultColumnSizeApplied(tester, false);
    });

    testWidgets('Default S, M, L column sizes are applied to header cells',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Material(child: buildTable(columns: smlColumns)),
      ));

      await _smlColumnSizeApplied(tester, true);
    });

    testWidgets('Default S, M, L column sizes are applied to data cells',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Material(child: buildTable(columns: smlColumns)),
      ));

      await _smlColumnSizeApplied(tester, false);
    });

    testWidgets('Overidden S, M, L column sizes are applied to header cells',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Material(
            child: buildTable(columns: smlColumns, overrideSizes: true)),
      ));

      await _smlOverridenColumnSizeApplied(tester, true);
    });

    testWidgets('Overidden S, M, L column sizes are applied to data cells',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Material(
            child: buildTable(columns: smlColumns, overrideSizes: true)),
      ));

      await _smlOverridenColumnSizeApplied(tester, false);
    });

    testWidgets('minWidth is respected', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(Size(250, 500));
      await tester.pumpWidget(MaterialApp(
        home: Material(child: buildTable(minWidth: 350)),
      ));

      var s1 = tester.getSize(find.byType(Column).last);
      print('${s1.width} ${s1.height} ');

      expect(s1.width > 349 && s1.width < 351, true);
    });
  });

  group('PaginatedDataTable2', () {
    testWidgets('Default column size is applied to header cells',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Material(
            child: buildPaginatedTable(showPage: false, showGeneration: false)),
      ));

      await _defaultColumnSizeApplied(tester, true);
    });

    testWidgets('Default column size is applied to data cells',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Material(
            child: buildPaginatedTable(showPage: false, showGeneration: false)),
      ));

      await _defaultColumnSizeApplied(tester, false);
    });

    testWidgets('Default S, M, L column sizes are applied to header cells',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Material(
            child: buildPaginatedTable(
                showPage: false, showGeneration: false, columns: smlColumns)),
      ));

      await _smlColumnSizeApplied(tester, true);
    });

    testWidgets('Default S, M, L column sizes are applied to data cells',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Material(
            child: buildPaginatedTable(
                showPage: false, showGeneration: false, columns: smlColumns)),
      ));

      await _smlColumnSizeApplied(tester, false);
    });

    testWidgets('Overidden S, M, L column sizes are applied to header cells',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Material(
            child: buildPaginatedTable(
                showPage: false,
                showGeneration: false,
                columns: smlColumns,
                overrideSizes: true)),
      ));

      await _smlOverridenColumnSizeApplied(tester, true);
    });

    testWidgets('Overidden S, M, L column sizes are applied to data cells',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Material(
            child: buildPaginatedTable(
                showPage: false,
                showGeneration: false,
                columns: smlColumns,
                overrideSizes: true)),
      ));

      await _smlOverridenColumnSizeApplied(tester, false);
    });

    testWidgets('autoRowsToHeight WITHOUT headers works fine',
        (WidgetTester tester) async {
      const height = 300.0;
      await tester.binding.setSurfaceSize(Size(1000, height));
      await tester.pumpWidget(MaterialApp(
        home: Material(
            child: buildPaginatedTable(
                showPage: false,
                showGeneration: false,
                showHeader: false,
                autoRowsToHeight: true)),
      ));

      var s1 = tester.getSize(find.byType(PaginatedDataTable2).first);
      print('${s1.width} ${s1.height} ');

      expect(find.byType(Checkbox),
          findsNWidgets(((height - 56 - 56) / 48).floor() + 1));
      // - header row - footer
      // +1 - checkbox in header

      await tester.binding.setSurfaceSize(Size(1000, height * 2));
      await tester.pumpAndSettle();
      s1 = tester.getSize(find.byType(PaginatedDataTable2).first);
      print('${s1.width} ${s1.height} ');

      expect(find.byType(Checkbox),
          findsNWidgets(((2 * height - 56 - 56) / 48).floor() + 1));
    });

    testWidgets('autoRowsToHeight WITH headers works fine',
        (WidgetTester tester) async {
      const height = 300.0;
      await tester.binding.setSurfaceSize(Size(1000, height));
      await tester.pumpWidget(MaterialApp(
        home: Material(
            child: buildPaginatedTable(
                showPage: false,
                showGeneration: false,
                showHeader: true,
                autoRowsToHeight: true)),
      ));

      var s1 = tester.getSize(find.byType(PaginatedDataTable2).first);
      print('${s1.width} ${s1.height} ');

      expect(find.byType(Checkbox),
          findsNWidgets(((height - 64 - 56 - 56) / 48).floor() + 1));
      // - header - header row - footer
      // +1 - checkbox in header

      await tester.binding.setSurfaceSize(Size(1000, height * 2));
      await tester.pumpAndSettle();
      s1 = tester.getSize(find.byType(PaginatedDataTable2).first);
      print('${s1.width} ${s1.height} ');

      expect(find.byType(Checkbox),
          findsNWidgets(((2 * height - 64 - 56 - 56) / 48).floor() + 1));
    });

    testWidgets('autoRowsToHeight WITH headers AND card works fine',
        (WidgetTester tester) async {
      const height = 300.0;
      await tester.binding.setSurfaceSize(Size(1000, height));
      await tester.pumpWidget(MaterialApp(
        home: Material(
            child: buildPaginatedTable(
                showPage: false,
                showGeneration: false,
                showHeader: true,
                wrapInCard: true,
                autoRowsToHeight: true)),
      ));

      var s1 = tester.getSize(find.byType(PaginatedDataTable2).first);
      print('${s1.width} ${s1.height} ');

      expect(find.byType(Checkbox),
          findsNWidgets(((height - 64 - 56 - 56 - 8) / 48).floor() + 1));
      // - header - header row - footer
      // +1 - checkbox in header

      await tester.binding.setSurfaceSize(Size(1000, height * 2));
      await tester.pumpAndSettle();
      s1 = tester.getSize(find.byType(PaginatedDataTable2).first);
      print('${s1.width} ${s1.height} ');

      expect(find.byType(Checkbox),
          findsNWidgets(((2 * height - 64 - 56 - 56 - 8) / 48).floor() + 1));
    });

    testWidgets('autoRowsToHeight doesn\'t allow setting page size',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(Size(1000, 300));
      await tester.pumpWidget(MaterialApp(
        home: Material(
            child: buildPaginatedTable(
                showPage: false,
                showGeneration: false,
                showPageSizeSelector: true,
                autoRowsToHeight: true)),
      ));

      expect(find.text('Rows per page:'), findsNothing);
    });

    testWidgets('minWidth is respected', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(Size(200, 300));
      await tester.pumpWidget(MaterialApp(
        home: Material(
            child: buildPaginatedTable(
                showPage: false, showGeneration: false, minWidth: 350)),
      ));

      var s1 = tester.getSize(find.byType(Column).last);
      print('${s1.width} ${s1.height} ');

      expect(s1.width > 349 && s1.width < 351, true);
    });
  });
}

Finder findFirstContainerFor(String text) =>
    find.widgetWithText(Container, text).first;

class Tripple<T> {
  Tripple(this.v1, this.v2, this.v3);
  final T v1;
  final T v2;
  final T v3;
}

Tripple<Size> _getColumnSizes(WidgetTester tester, bool header) {
  var s0 = tester.getSize(find.byType(DataTable2));

  var c = findFirstContainerFor(header ? 'Name' : 'Frozen yogurt');
  var s1 = tester.getSize(c);

  c = findFirstContainerFor(header ? 'Calories' : '159');
  expect(c, findsOneWidget);
  var s2 = tester.getSize(c);

  c = findFirstContainerFor(header ? 'Carbs' : '24');
  expect(c, findsOneWidget);
  var s3 = tester.getSize(c);

  print('${s0.width} ${s1.width} ${s2.width} ${s3.width}');

  return Tripple(s1, s2, s3);
}

Future<void> _defaultColumnSizeApplied(WidgetTester tester, bool header) async {
  await tester.binding.setSurfaceSize(Size(1000, 200));
  var s = _getColumnSizes(tester, header);

  // Firsrt column is half margin greater than the  second one.
  // 24p margin is split between check box (zero) column and second column
  expect((s.v1.width - 12 - s.v2.width).abs() < 0.01, true);

  // Last column is margin greater (24p) than the middle one.
  expect((s.v3.width - 24 - s.v2.width).abs() < 0.01, true);
}

Future<void> _smlColumnSizeApplied(WidgetTester tester, bool header) async {
  await tester.binding.setSurfaceSize(Size(1000, 200));
  var s = _getColumnSizes(tester, header);

  // Firsrt column is half margin greater than the  second one.
  // 24p margin is split between check box (zero) column and second column
  expect(((s.v1.width - 12) / s.v2.width - 0.67).abs() < 0.01, true);

  // Last column is margin greater (24p) than the middle one.
  expect(((s.v3.width - 24) / s.v2.width - 1.2).abs() < 0.01, true);
}

Future<void> _smlOverridenColumnSizeApplied(
    WidgetTester tester, bool header) async {
  await tester.binding.setSurfaceSize(Size(1000, 200));
  var s = _getColumnSizes(tester, header);

  // Firsrt column is half margin greater than the  second one.
  // 24p margin is split between check box (zero) column and second column
  expect(((s.v1.width - 12) / s.v2.width - 0.5).abs() < 0.01, true);

  // Last column is margin greater (24p) than the middle one.
  expect(((s.v3.width - 24) / s.v2.width - 1.5).abs() < 0.01, true);
}