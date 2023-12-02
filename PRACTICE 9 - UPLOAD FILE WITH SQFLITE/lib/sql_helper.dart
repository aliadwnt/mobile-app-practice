import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<sql.Database> db() async {
    return sql.openDatabase("catatan.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTable(database);
    });
  }

  static Future<void> createTable(sql.Database database) async {
    await database.execute("""
      CREATE TABLE catatan(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        judul TEXT,
        deskripsi TEXT,
        gambar TEXT
      )
      """);
  }

  static Future<int> tambahCatatan(String judul, String deskripsi, String gambar) async {
    final db = await SQLHelper.db();
    final data = {'judul': judul, 'deskripsi': deskripsi, 'gambar': gambar};
    return await db.insert("catatan", data);
  }

  static Future<void> hapusCatatan(int id) async {
    final db = await SQLHelper.db();
    await db.delete("catatan", where: "id=$id");
  }

  static Future<List<Map<String, dynamic>>> getCatatan() async {
    final db = await SQLHelper.db();
    return db.query("catatan");
  }

  static Future<int> ubahCatatan(int id, String judul, String deskripsi, String gambar) async {
    final db = await SQLHelper.db();
    final data = {'judul': judul, 'deskripsi': deskripsi, 'gambar': gambar};
    return await db.update('catatan', data, where: "id = $id");
  }
}