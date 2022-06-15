import 'package:mongo_dart/mongo_dart.dart';
import 'package:connectmongo/modelos/reseñas.dart';
import 'package:connectmongo/utilidades/constantes.dart';

class MongoDB {
  static var db, coleccionResenas;

  static conectar() async {
    db = await Db.create(CONEXION);
    await db.open();
    coleccionResenas = db.collection(COLECCION);
  }

  static Future<List<Map<String, dynamic>>> getResenas() async {
    try {
      final resenas = await coleccionResenas.find().toList();
      return resenas;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static insertar(Resena resena) async {
    await coleccionResenas.insertAll([resena.toMap()]);
  }

  static actualizar(Resena resena) async {
    var j = await coleccionResenas.findOne({"_id": resena.id});
    j["nombre"] = resena.titulo;
    j["resena"] = resena.resena;
    j["stars"] = resena.stars;
    j["fotos"] = resena.fotos;
    await coleccionResenas.save(j);
  }

  static eliminar(Resena resena) async {
    await coleccionResenas.remove(where.id(resena.id));
  }
}
