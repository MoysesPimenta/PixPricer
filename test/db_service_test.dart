import 'package:flutter_test/flutter_test.dart';
import 'package:pix_pricer/db_service.dart';

void main() {
  test('insert and read returns stored value', () {
    final db = InMemoryDb();
    db.insert('foo', 'bar');
    expect(db.read('foo'), 'bar');
  });

  test('read of missing key returns null', () {
    final db = InMemoryDb();
    expect(db.read('missing'), isNull);
  });
}
