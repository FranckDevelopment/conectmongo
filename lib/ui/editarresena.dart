import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:connectmongo/mongodb/mongodb.dart';
import 'package:connectmongo/modelos/reseñas.dart';

class EditarResena extends StatefulWidget {
  @override
  _EditarResenaState createState() => _EditarResenaState();
}

class _EditarResenaState extends State<EditarResena> {
  static const EDICION = 1;
  static const INSERCION = 2;

  TextEditingController tituloController = TextEditingController();
  TextEditingController resenaController = TextEditingController();
  TextEditingController fotosController = TextEditingController();
  TextEditingController starsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textWidget = "Añadir Reseña";
    int operacion = INSERCION;
    Resena? resena;
    if (ModalRoute.of(context)?.settings.arguments != null) {
      operacion = EDICION;
      resena = ModalRoute.of(context)?.settings.arguments as Resena;
      tituloController.text = resena.titulo;
      resenaController.text = resena.resena;
      fotosController.text = resena.fotos;
      starsController.text = resena.stars.toString();
      textWidget = "Editar Reseña";
    }
    return Scaffold(
      appBar: AppBar(title: Text(textWidget)),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: tituloController,
                    decoration: InputDecoration(labelText: "Titulo"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: resenaController,
                    decoration: InputDecoration(labelText: "Descripcion"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: fotosController,
                    decoration: InputDecoration(labelText: "URL fotos"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: starsController,
                    decoration:
                        InputDecoration(labelText: "numero de estrellas"),
                    keyboardType: TextInputType.number,
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
              child: ElevatedButton(
                child: Text(textWidget),
                onPressed: () {
                  if (operacion == EDICION) {
                    _actualizarResena(resena!);
                  } else {
                    _insertarResena();
                  }
                  Navigator.pop(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  _insertarResena() async {
    final resena = Resena(
      id: M.ObjectId(),
      titulo: tituloController.text,
      resena: resenaController.text,
      fotos: fotosController.text,
      stars: int.parse(starsController.text),
    );
    await MongoDB.insertar(resena);
  }

  _actualizarResena(Resena resena) async {
    final j = Resena(
      id: resena.id,
      titulo: tituloController.text,
      resena: resenaController.text,
      fotos: fotosController.text,
      stars: int.parse(starsController.text),
    );
    await MongoDB.actualizar(j);
  }

  @override
  void dispose() {
    super.dispose();
    tituloController.dispose();
    resenaController.dispose();
    fotosController.dispose();
    starsController.dispose();
  }
}
