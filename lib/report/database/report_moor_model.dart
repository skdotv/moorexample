import 'package:moor_flutter/moor_flutter.dart';

class ReportMoorModel extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text()();
  TextColumn get imagepath => text()();
  TextColumn get username => text()();

  // @override
  // Set<Column> get primaryKey => {id};
}