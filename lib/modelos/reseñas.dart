import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Resena {
  final ObjectId id;
  final String titulo;
  final String resena;
  final int stars;
  final String fotos;

  const Resena(
      {required this.id,
      required this.titulo,
      required this.resena,
      required this.stars,
      required this.fotos});

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'titulo': titulo,
      'resena': resena,
      'stars': stars,
      'fotos': fotos,
    };
  }

  Resena.fromMap(Map<String, dynamic> map)
      : titulo = map['titulo'],
        id = map['_id'],
        resena = map['resena'],
        stars = map['stars'],
        fotos = map['fotos'];
}
