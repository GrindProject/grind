import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import 'package:flutter/cupertino.dart';

import 'codemessage.dart';
import 'dao.dart';
import 'datamodel.dart';

final config = FaunaConfig.build(
  secret: 'fnAEL79bh6ACAA1nfM7Oqm6uczZQbYmdOyzf3RTD',
);

/*
abstract class DaoFaunaDB<DM extends DataModel> extends Dao<DM> {
  final _client = FaunaClient(config);

  String getCollectionName();

  DM createModelFromJson(String id, Map<String, dynamic> json);

  Future<DM?> get(String id) async {
    List<DM> list = List.empty(growable: true);
    final query = Map_(Paginate(Ref(Collection(getCollectionName()), id)), Lambda('Ref', Let({'Doc': Get(Var('Ref'))}, Var('Doc'))));
    final result = await _client.query(query);
    result.asMap().values.forEach((element) {
      (element as Map<String, dynamic>).values.forEach((element2) {
        (element2 as List<dynamic>).forEach((element3) {
          list.add(createModelFromJson(element3['ref']['@ref']['id'], element3['data']));
        });
      });
    });
    _client.close();
    if (list.isEmpty) return null;
    return list.first;
  }

  Future<List<DM>> getAll() async {
    List<DM> list = List.empty(growable: true);
    final query = Map_(Paginate(Match(Index('all_' + getCollectionName()))), Lambda('Ref', Let({'Doc': Get(Var('Ref'))}, Var('Doc'))));
    final result = await _client.query(query);
    print(result.asMap().toString());
    result.asMap().values.forEach((element) {
      (element as Map<String, dynamic>).values.forEach((element2) {
        (element2 as List<dynamic>).forEach((element3) {
          list.add(createModelFromJson(element3['ref']['@ref']['id'], element3['data']));
        });
      });
    });
    _client.close();
    return list;
  }

  Future<CodeMessage> put(DM dataModel) async {
    try {
      Obj obj = Obj.fromJson(dataModel.toJson());
      final query = Replace(Ref(Collection(getCollectionName()), dataModel.id), obj);
      print(query.toJson().toString());
      FaunaResponse response = await _client.query(query);
      return CodeMessage(1, "");
    } catch (error) {
      return CodeMessage(100, error.toString());
    }
  }

  Future<CodeMessage> create(DM dataModel) async {
    try {
      Obj obj = Obj.fromJson(dataModel.toJson());
      final query = Create(Collection(getCollectionName()), obj);
      print(query.toJson().toString());
      FaunaResponse response = await _client.query(query);
      return CodeMessage(1, "");
    } catch (error) {
      return CodeMessage(200, error.toString());
    }
  }

  Future<CodeMessage> delete(String id) async {
    try {
      final query = Delete(Ref(Collection(getCollectionName()), id));
      print(query.toJson().toString());
      FaunaResponse response = await _client.query(query);
      return CodeMessage(1, "");
    } catch (error) {
      return CodeMessage(300, error.toString());
    }
  }
}
*/