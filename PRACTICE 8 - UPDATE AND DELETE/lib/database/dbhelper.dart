import 'package:sqflite/sqflite.dart' as sql;

class DBHelper {
  static Future<sql.Database> database() async {
    return sql.openDatabase(
      'pegawai.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTable(database);
      },
    );
  }

  static Future<void> createTable(sql.Database database) async {
    await database.execute("""
      CREATE TABLE Employee (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstName TEXT NOT NULL,
        lastName TEXT NOT NULL,
        mobileNo TEXT NOT NULL
      )
      """);
  }

  static Future<int> saveEmployee(String firstName, String lastName, String mobileNo) async {
    final db = await DBHelper.database();
    final data = {
      'firstName': firstName,
      'lastName': lastName,
      'mobileNo': mobileNo,
    };
    return await db.insert("Employee", data);
  }

  // static Future<int> deleteEmployee(int id) async {
  //   final db = await DBHelper.database();
  //   return await db.delete("Employee", where: "id = ?", whereArgs: [id]);
  // }
  

  static Future<List<Map<String, dynamic>>> getEmployee() async {
    final db = await DBHelper.database();
    return db.query("Employee");
  }

  static Future<int> updateEmployee(int id, String firstName, String lastName, String mobileNo) async {
    final db = await DBHelper.database();
    final data = {
      'firstName': firstName,
      'lastName': lastName,
      'mobileNo': mobileNo,
    };
    return await db.update('Employee', data, where: "id = ?", whereArgs: [id]);
  }
}
