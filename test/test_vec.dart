import 'package:flutter/cupertino.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite_vector/sqlite_vector.dart';

void main() {
  sqlite3.loadSqliteVectorExtension();
  debugPrint("OK");
}
