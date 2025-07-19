import 'dart:convert';
import 'dart:math';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

/// Drift table containing shopping cart items.
class Items extends Table {
  /// Unique identifier for the item.
  TextColumn get id => text()();

  /// Timestamp when the item was created or scanned.
  DateTimeColumn get ts => dateTime()();

  /// Unit price of the item.
  RealColumn get priceUnit => real()();

  /// Quantity purchased.
  RealColumn get quantity => real()();

  /// Encoded discount rule, if any.
  TextColumn get discountRule => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Application database configured with SQLCipher encryption.
@DriftDatabase(tables: [Items])
class AppDatabase extends _$AppDatabase {
  /// Creates the database using a lazily initialized executor.
  AppDatabase({QueryExecutor? executor, bool logStatements = false})
      : super(executor ?? _openConnection(logStatements));

  /// Internal constructor for testing with an in-memory [QueryExecutor].
  AppDatabase.forTesting(QueryExecutor executor)
      : super(executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async => m.createAll(),
        onUpgrade: (m, from, to) async {},
      );
}

LazyDatabase _openConnection(bool logStatements) {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'app.sqlite'));

    const storage = FlutterSecureStorage();
    var key = await storage.read(key: 'db_key');
    key ??= await _generateAndStoreKey(storage);

    final db = NativeDatabase(
      file,
      logStatements: logStatements,
      setup: (database) async {
        await database.execute("PRAGMA key = '$key';");
      },
    );
    return db;
  });
}

Future<String> _generateAndStoreKey(FlutterSecureStorage storage) async {
  final rnd = Random.secure();
  final bytes = List<int>.generate(32, (_) => rnd.nextInt(256));
  final key = base64Url.encode(bytes);
  await storage.write(key: 'db_key', value: key);
  return key;
}
