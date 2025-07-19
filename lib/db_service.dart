// Copyright (c) 2025 Shopping Bill App Project
// SPDX-License-Identifier: MIT
/// Very small in-memory database used for unit tests.
///
/// The real application will use Drift/SQLite, but this lightweight
/// implementation lets us exercise DB access logic in tests without
/// additional setup.
class InMemoryDb {
  final Map<String, String> _store = <String, String>{};

  /// Inserts a key/value pair.
  void insert(String key, String value) => _store[key] = value;

  /// Retrieves a value by [key]. Returns `null` if absent.
  String? read(String key) => _store[key];
}
