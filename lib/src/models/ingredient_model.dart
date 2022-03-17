class IngredientModel {
  final int? id;
  final String nameIngredient;
  final String amount;

  IngredientModel(this.id, this.nameIngredient, this.amount);

  IngredientModel.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        nameIngredient = map['nameIngredient'],
        amount = map['amount'];

  Map<String, dynamic> toMapForDb() {
    return <String, dynamic>{
      'id': id,
      'nameIngredient': nameIngredient,
      'amount': amount,
    };
  }
}