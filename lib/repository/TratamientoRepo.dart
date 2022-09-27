import 'dart:core';
import 'package:gestor_recordatorios_tratamiento_medico/model/tratamieno_service.dart';
import 'package:gestor_recordatorios_tratamiento_medico/model/medicamento_service.dart';
import 'package:gestor_recordatorios_tratamiento_medico/model/dosis_services.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'dart:async';

abstract class TratamientoRepo{
  Future<List<Medicamento>> get_medicamentos(int id);
  void agregar_medicamento(Medicamento muestra, int id);
  void agregar_tratamiento(String nombre_medicamento);
  Future <List<Tratamiento>> get_tratamientos();
  Future<int?> getCount();
}

class TratamientoSqlite implements TratamientoRepo{
  static Database? _db=null;
  Future<Database?> get db async{
    if(_db != null) return _db;
    _db =await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "GestorMedico.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async{
    await db.execute(
          'CREATE TABLE "tratamientos" ("tratamiento_id"	INTEGER, "nombre"	TEXT NOT NULL, "estado"	INTEGER NOT NULL, "comentario"	TEXT, PRIMARY KEY("tratamiento_id"))'
    );
    await db.execute(
        'CREATE TABLE "medicamentos" ("medicamento_id"	INTEGER, "tratamiento_id"	INTEGER, "nombre"	TEXT NOT NULL, "presentacion"	TEXT NOT NULL, "dosis"	TEXT NOT NULL, "horarios_horas"	INTEGER NOT NULL, "numero_dosis"	INTEGER, "comentario"	TEXT, FOREIGN KEY("tratamiento_id") REFERENCES "tratamientos"("tratamiento_id"), PRIMARY KEY("medicamento_id" AUTOINCREMENT))'
    );
    await db.execute(
        'CREATE TABLE "dosis" ("tratamiento_id"	INTEGER, "medicamento_id"	INTEGER, "dosis_id"	INTEGER, "estado"	INTEGER NOT NULL, "momento"	TEXT NOT NULL, "comentario"	TEXT, FOREIGN KEY("tratamiento_id") REFERENCES "tratamientos"("tratamiento_id"), FOREIGN KEY("medicamento_id") REFERENCES "medicamentos"("medicamento_id"),PRIMARY KEY("dosis_id" AUTOINCREMENT))'
    );
  }
  @override
  void agregar_medicamento (Medicamento muestra, int id) async{
    await _db?.transaction((txn) async{
    return await txn.rawInsert(
        "INSERT INTO medicamentos(tratamiento_id,nombre,presentacion,dosis, horarios_horas) VALUES('"+id.toString()+"','"+muestra.nombre+"','"+muestra.presentacion+"','"+muestra.dosis+"','"+muestra.horario_horas.toString()+"')"
      );
    });
  }
  void agregar_medicamento_numerodosis(int numerodosis, int id_medicamento) async{
    await _db?.transaction((txn) async{
      //update medicamentos set numero_dosis=5 where medicamento_id =2

      return await txn.rawUpdate(
          'UPDATE medicamentos SET numero_dosis = ? WHERE medicamento_id = ?',
          [numerodosis,id_medicamento]);
    });
  }

  void agregar_medicamento_comentario(int id_medicamento, String comentario) async{
    await _db?.transaction((txn) async{
      //update medicamentos set numero_dosis=5 where medicamento_id =2

      return await txn.rawUpdate(
          'UPDATE medicamentos SET comentario = ? WHERE medicamento_id = ?',
          [comentario,id_medicamento]);
    });
  }
  void agregar_tratamiento_comentario(int id_tratamiento, String comentario) async{
    await _db?.transaction((txn) async{
      //update medicamentos set numero_dosis=5 where medicamento_id =2

      return await txn.rawUpdate(
          'UPDATE tratamientos SET comentario = ? WHERE tratamiento_id = ?',
          [comentario,id_tratamiento]);
    });
  }

  @override
  void agregar_tratamiento(String nombre_tratamiento) async{
    await _db?.transaction((txn) async {
      return await txn.rawInsert(
          "INSERT INTO tratamientos(nombre,estado) VALUES('"+nombre_tratamiento +"','0')"
      );
    });
  }

  @override
  Future<int?> getCount() async{
  var dbClient = await _db;
  var result = Sqflite.firstIntValue(
    await dbClient!.rawQuery("SELECT COUNT (*) FROM tratamientos")
  );
  return result;
  }

  @override
  Future<List<Medicamento>> get_medicamentos(int id) async{
    var dbClient = await _db;
    final response = await dbClient?.rawQuery('SELECT * FROM medicamentos where id_tratamiento = '+id.toString());
    final listamedicamentos = response?.map((medicamento) => Medicamento.fromJson(medicamento)).toList() ??[];
    return listamedicamentos;
  }
  @override
  Future<List<Tratamiento>> get_tratamientos() async {
    var dbClient = await db;
    final response = await dbClient?.rawQuery('SELECT * FROM tratamientos');
    final listatratamientos = response?.map((tratamiento) => Tratamiento.fromJson(tratamiento)).toList() ??[];
    return listatratamientos;
  }
  
}