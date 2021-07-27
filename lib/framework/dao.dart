import 'codemessage.dart';
import 'datamodel.dart';

abstract class Dao<DM extends DataModel> {
  Future<DM?> get(String id);

  Future<List<DM>> getAll();

  Future<CodeMessage> put(DM dataModel);

  Future<CodeMessage> create(DM dataModel);

  Future<CodeMessage> delete(String id);
}
