import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';

class CsvTools {
  CsvTools._();

  static List<List> load(
    String filename, {
    String? eol,
    bool removeHeader = false,
    bool parseNumbers = true,
  }) {
    final file = File(filename);
    final converter = _converter(eol, parseNumbers);
    final raw = file.readAsStringSync();
    final csv = converter.convert(raw);

    if (removeHeader) {
      csv.removeAt(0);
    }

    return csv;
  }

  static List<Map> loadAsMap(
    String filename, {
    String? eol,
    bool parseNumbers = true,
  }) {
    final data = load(filename, eol: eol, parseNumbers: parseNumbers);
    final headers = data.removeAt(0);

    return data.map((row) {
      final json = <dynamic, dynamic>{};
      for (int i = 0; i < row.length; i++) {
        final cell = row[i];
        final column = headers[i];

        json[column] = cell is String && cell.isEmpty ? null : cell;
      }

      return json;
    }).toList(growable: false);
  }

  static void writeJsonListToCsv({
    required List<Map> jsonObjects,
    required String fileName,
  }) {
    final csv = <List>[];
    final keys = jsonObjects.first.keys.toList();
    csv.add(keys);

    for (final json in jsonObjects) {
      final row = keys.map((key) => json[key]).toList();
      csv.add(row);
    }

    final converter = ListToCsvConverter();
    final data = converter.convert(csv);
    File(fileName).writeAsStringSync(data);
  }

  static CsvToListConverter _converter(String? eol, bool parseNumbers) {
    final converter = CsvToListConverter(
      eol: eol,
      shouldParseNumbers: parseNumbers,
    );
    return converter;
  }

  static Stream<List> streamCsv(
    String filename, {
    String? eol,
    bool parseNumbers = true,
  }) {
    final file = File(filename);
    final converter = _converter(eol, parseNumbers);

    return file.openRead().transform(utf8.decoder).transform(converter);
  }
}
