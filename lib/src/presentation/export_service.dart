import 'package:flutter/services.dart';

/// Provides methods to export and share cart data through platform channels.
class ExportService {
  /// Channel used to invoke platform methods for exporting.
  static const MethodChannel _channel = MethodChannel('com.pixpricer/export');

  /// Exports [data] as CSV via the host platform.
  Future<void> exportCsv(String data) {
    return _channel.invokeMethod<void>('exportCsv', data);
  }

  /// Exports [data] as PDF via the host platform.
  Future<void> exportPdf(String data) {
    return _channel.invokeMethod<void>('exportPdf', data);
  }

  /// Shares a file at the given [path] using the platform share sheet.
  Future<void> shareFile(String path) {
    return _channel.invokeMethod<void>('shareFile', path);
  }
}
