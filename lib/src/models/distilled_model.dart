class DistilledModel {
  final int? id;
  final String nameDistilled;
  final String image;
  final String denOrigen;
  final String origen;
  final String process;
  final String color;

  DistilledModel(this.id, this.nameDistilled, this.image, this.denOrigen, this.origen, this.process, this.color);

  DistilledModel.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        nameDistilled = map['nameDistilled'],
        image = map['image'],
        denOrigen = map['denOrigen'],
        origen = map['origen'],
        color = map['color'],
        process = map['process'];

  Map<String, dynamic> toMapForDb() {
    return <String, dynamic>{
      'id': id,
      'nameDistilled': nameDistilled,
      'image': image,
      'denOrigen': denOrigen,
      'origen': origen,
      'process': process,
      'color': color,
    };
  }


}