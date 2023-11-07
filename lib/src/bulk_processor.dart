import 'dart:io';

class BulkProcessor<T> {
  final List<T> data;
  final Future<void> Function(int int, T item) processor;
  final String logFileName;

  BulkProcessor({
    required this.data,
    required this.processor,
    required this.logFileName,
  });

  Future<void> go() async {
    final failureOutput = File('logs/${logFileName}_${DateTime.now()}.log');
    if (failureOutput.parent.existsSync() == false) {
      failureOutput.parent.createSync();
    }

    final failures = failureOutput.openWrite();

    final count = data.length;
    for (int i = 0; i < count; i++) {
      print('Processing ${(i / count * 100).toStringAsFixed(2)}% $i / $count');
      final row = data[i];

      try {
        await processor(i, row);
      } catch (e) {
        failures.writeln('Failed $i, $row, $e');
      }
    }

    failures.close();
    print('Done');
  }
}
