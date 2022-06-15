import 'package:flutter/material.dart';
import 'package:connectmongo/modelos/reseñas.dart';

class DetallesResena extends StatelessWidget {
  DetallesResena(
      {required this.resena,
      required this.onTapDelete,
      required this.onTapEdit});

  final Resena resena;
  final VoidCallback onTapEdit, onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      color: Colors.blue,
      child: ListTile(
        leading: Text('${resena.titulo}',
            style: Theme.of(context).textTheme.headline6),
        title: Text(resena.resena),
        subtitle: Text(resena.fotos),
        trailing: Column(
          children: [
            GestureDetector(
              child: Icon(Icons.edit),
              onTap: onTapEdit,
            ),
            GestureDetector(
              child: Icon(Icons.delete),
              onTap: onTapDelete,
            )
          ],
        ),
      ),
    );
  }
}
