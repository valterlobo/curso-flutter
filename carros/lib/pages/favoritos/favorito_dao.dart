import 'dart:async';

import 'package:carros/pages/favoritos/favorito.dart';
import 'package:carros/utils/sql/base_dao.dart';

// Data Access Object
class FavoritoDAO extends BaseDAO<Favorito> {
  @override
  String get tableName => "favorito";

  @override
  Favorito fromMap(Map<String, dynamic> map) {
    return Favorito.fromMap(map);
  }
}
