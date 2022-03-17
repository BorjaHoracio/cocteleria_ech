const tablaDestilado = '''
  CREATE TABLE distilled
  (
    id INTEGER PRIMARY KEY,
    nameDistilled TEXT,
    image TEXT,
    denOrigen TEXT,
    origen TEXT,
    process TEXT,
    color TEXT
  )
''';
const tablaCerveza = '''
  CREATE TABLE beer (
    id INTEGER PRIMARY KEY,
    nameBeer TEXT,
    image TEXT,
    denOrigen TEXT,
    origen TEXT,
    process TEXT
  )
''';
const tablaRecetas = '''
  CREATE TABLE recipe (
    id INTEGER PRIMARY KEY,
    idDistilled INTEGER,
    idBeer INTEGER,
    nameRecipe TEXT,
    image TEXT,
    elaborationMethod TEXT,
    isCertification INTEGER,
    glassType TEXT,
    decor TEXT,
    preparation TEXT,
    fav INTEGER,
    foreign key(idDistilled) references distilled(id),
    foreign key(idBeer) references beer(id)
  )
''';
const tablaIngredientes = '''
  CREATE TABLE ingredient (
    id INTEGER PRIMARY KEY,
    idRecipe INTEGER,
    nameIngredient TEXT,
    amount TEXT,
    foreign key(idRecipe) references recipe(id)
  )
''';
// const tablaClasificacion = '''
//   CREATE TABLE classification (
//     id INTEGER PRIMARY KEY,
//     idDistilled INTEGER,
//     name TEXT,
//     foreign key(idDistilled) references distilled(id)
//   )
// ''';

const tablaDecalo = '''
  CREATE TABLE decalo (
    id INTEGER PRIMARY KEY,
    nameDecalo TEXT
  )
''';

// const tablaMiBarra = '''
//   CREATE TABLE myBar (
//     id INTEGER PRIMARY KEY,
//     name TEXT,

//   )
// ''';