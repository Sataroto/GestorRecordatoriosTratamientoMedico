import 'dart:core';
import 'package:gestor_recordatorios_tratamiento_medico/model/tratamieno_service.dart';
import 'package:gestor_recordatorios_tratamiento_medico/model/medicamento_service.dart';
import 'package:gestor_recordatorios_tratamiento_medico/model/dosis_services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'dart:async';

abstract class TratamientoRepo{
  Future<List<Medicamento>> get_medicamentos(int id);
  void agrega_medicamento(Medicamento muestra, int id);
  void agregar_tratamiento(Tratamiento muestra);
  Future <List<Tratamiento>> get_tratamientos();
  Future<int?> getCount();
}

class TratamientoSqlite implements TratamientoRepo{
  @override
  void agrega_medicamento(Medicamento muestra, int id) {
    // TODO: implement agrega_medicamento
  }

  @override
  void agregar_tratamiento(Tratamiento muestra) {
    // TODO: implement agregar_tratamiento
  }

  @override
  Future<int?> getCount() {
    // TODO: implement getCount
    throw UnimplementedError();
  }

  @override
  Future<List<Medicamento>> get_medicamentos(int id) {
    // TODO: implement get_medicamentos
    throw UnimplementedError();
  }

  @override
  Future<List<Tratamiento>> get_tratamientos() {
    // TODO: implement get_tratamientos
    throw UnimplementedError();
  }
  
}