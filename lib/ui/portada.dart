import 'package:flutter/material.dart';
import 'package:connectmongo/modelos/reseñas.dart';
import 'package:connectmongo/mongodb/mongodb.dart';
import 'package:connectmongo/ui/detalles.dart';
import 'package:connectmongo/ui/editarresena.dart';

class Portada extends StatefulWidget {
  @override
  _PortadaState createState() => _PortadaState();
}

class _PortadaState extends State<Portada> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MongoDB.getResenas(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.white,
            child: const LinearProgressIndicator(
              backgroundColor: Colors.black,
            ),
          );
        } else if (snapshot.hasError) {
          return Container(
            color: Colors.white,
            child: Center(
              child: Text(
                "Lo sentimos tienes errores regra por donde veniste :)",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text("RESEÑAS"),
            ),
            body: ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DetallesResena(
                    resena: Resena.fromMap(snapshot.data[index]),
                    onTapDelete: () async {
                      _eliminarResena(Resena.fromMap(snapshot.data[index]));
                    },
                    onTapEdit: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) {
                                return EditarResena();
                              },
                              settings: RouteSettings(
                                arguments: Resena.fromMap(snapshot.data[index]),
                              ))).then((value) => setState(() {}));
                    },
                  ),
                );
              },
              itemCount: snapshot.data.length,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return EditarResena();
                })).then((value) => setState(() {}));
              },
              child: Icon(Icons.add),
            ),
          );
        }
      },
    );
  }

  _eliminarResena(Resena resena) async {
    await MongoDB.eliminar(resena);
    setState(() {});
  }
}
