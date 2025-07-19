// Copyright (c) 2025 Shopping Bill App Project
// SPDX-License-Identifier: MIT
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'package:pix_pricer/src/infrastructure/db/app_database.dart';

void main() {
  test('initial schema is created', () async {
    final executor = NativeDatabase.memory();
    final db = AppDatabase.forTesting(executor);

    final result = await db.customSelect(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='items';",
    ).get();

    expect(result, isNotEmpty);
    await db.close();
  });
}
