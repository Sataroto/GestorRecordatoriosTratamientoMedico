class Dosis{
  final int tratamiento_id;
  final int medicamentos_id;
  final int dosis_id;
  final int estado;
  final DateTime momento;
  final String? comentario;

  Dosis(
      {
        required this.tratamiento_id,
        required this.medicamentos_id,
        required this.dosis_id,
        required this.estado,
        required this.momento,
        this.comentario
      }
      );
  factory Dosis.fromJson(Map<String, dynamic> json){
    return Dosis(
      tratamiento_id: json['tratamiento_id'] as int,
      medicamentos_id: json['medicamentos_id'] as int,
      dosis_id: json['dosis_id'] as int,
      estado: json['estado'] as int,
      momento: json['momento']as DateTime,
      comentario: json['comentario'] as String?
    );
  }
}