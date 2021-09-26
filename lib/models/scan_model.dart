import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:meta/meta.dart';

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
  ScanModel({
    this.id = 0,
    required this.valor,
    this.tipo = '',
  }) {
    if (this.valor.contains('http')) {
      this.tipo = 'http';
    } else {
      this.tipo = 'geo';
    }
  }

  int id;
  String tipo;

  String valor;

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() {
    dynamic obj = {
      'id': null,
      "tipo": tipo,
      "valor": valor,
    };
    if (id > 0) {
      obj['id'] = id.toInt().toString();
    }
    return obj;
  }

  LatLng getLatLng() {
    final latlng = this.valor.substring(4).split(',');
    final lat = double.parse(latlng[0]);
    final lng = double.parse(latlng[1]);
    return LatLng(lat, lng);
  }
}
