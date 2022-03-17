class DecaloModel {
  final int id;
  final String nameDecalo;

  DecaloModel(this.id, this.nameDecalo);

  DecaloModel.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        nameDecalo = map['nameDecalo'];

  Map<String, dynamic> toMapForDb() {
    return <String, dynamic>{
      'id': id,
      'nameDecalo': nameDecalo,
    };
  }


}