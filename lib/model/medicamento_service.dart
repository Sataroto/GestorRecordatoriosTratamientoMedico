class Medicamento{
  final int tratamiento_id;
  final int medicamento_id;
  final String nombre;
  final String presentacion;
  final String dosis;
  final int horario_horas;
  final int? numero_dosis;
  final String? comentario;

  Medicamento(
    {
    required this.medicamento_id,
      required this.tratamiento_id,
      required this.nombre,
      required this.presentacion,
      required this.dosis,
      required this.horario_horas,
      this.numero_dosis,
      this.comentario
    }
  );
  factory Medicamento.fromJson(Map<String, dynamic> json){
    return Medicamento(
        medicamento_id: json['medicamento_id'] as int,
        tratamiento_id: json['tratamiento_id'] as int,
        nombre: json['nombre']as String,
        presentacion: json['presentacion']as String,
        dosis: json['dosis'] as String,
        horario_horas: json['horario_horas'] as int,
    numero_dosis: json['numero_dosis']as int?,
    comentario: json['comentario']as String?
    );
  }
}