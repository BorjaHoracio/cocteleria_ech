class RecipeModel {
  final int? id;
  final int? idDistilled;
  final int? idBeer;
  final String nameRecipe;
  final String? image;
  final String elaborationMethod;
  final int isCertification;
  final String glassType;
  final String decor;
  final String preparation;
  final int fav;
  var nameDistilled;
  var color;

  RecipeModel(this.id, this.idDistilled, this.idBeer, this.nameRecipe, this.image, this.elaborationMethod, this.isCertification, this.glassType, this.decor, this.preparation, this.fav);

  RecipeModel.fromMap(Map<String, dynamic> map)
      :  id = map['id'],
        idDistilled = map['idDistilled'],
        idBeer = map['idBeer'],
        nameRecipe = map['nameRecipe'],
        image = map['image'],
        elaborationMethod = map['elaborationMethod'],
        isCertification = map['isCertification'],
        glassType = map['glassType'],
        decor = map['decor'],
        preparation = map['preparation'],
        fav = map['fav'],
        nameDistilled = map['nameDistilled'],
        color = map['color'];

  Map<String, dynamic> toMapForDb() {
    return <String, dynamic>{
      'id': id,
      'idDistilled': idDistilled,
      'idBeer': idBeer,
      'nameRecipe': nameRecipe,
      'image': image,
      'elaborationMethod': elaborationMethod,
      'isCertification': isCertification,
      'glassType': glassType,
      'decor': decor,
      'preparation': preparation,
      'fav': fav,
    };
  }
}