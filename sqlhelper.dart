import 'package:sqflite/sqflite.dart' as sql;


class sqlhelper{

  static Future<void>createtable(sql.Database database)async{
    await database.execute("CREATE TABLE stud(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,name TEXT,email TEXT,pho TEXT,gender Text,hooby TEXT)");
  }

  static Future<sql.Database>open()async{
    return sql.openDatabase('sms.db',
        version: 1,
        onCreate: (sql.Database database, int version)async{
        await createtable(database);
    });
  }
  static Future<int>addstudent(String? name,String? email,String? pho,String? gen,String? hobby)async{

    final db=await sqlhelper.open();
    final data ={'name':name,'email':email,'pho':pho,'gender':gen,'hooby':hobby};
    final id=db.insert('stud', data);
    return id;
  }

  static Future<List<Map<String,dynamic>>>getdata()async{
    final db=await sqlhelper.open();
    return db.query('stud',orderBy: 'id');
  }

  static Future<int>update(int id,String name,String email)async{

    final db=await sqlhelper.open();
    final data={'name':name,'email':email};
    final result=db.update('stud',data,where: "id=?",whereArgs: [id]);
    return result;
  }

  static Future<int>deletedata(int id)async{
      final db=await sqlhelper.open();
      final result=db.delete('stud',where: "id=?",whereArgs: [id]);
      return result;
  }


}