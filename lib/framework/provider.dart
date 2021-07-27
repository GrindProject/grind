import 'businessmodel.dart';
import 'codemessage.dart';

abstract class Provider<BM extends BusinessModel> {
  Future<BM?> get(String id);

  Future<List<BM>> getAll();

  Future<CodeMessage> put(BM businessModel);

  Future<CodeMessage> create(BM businessModel);

  Future<CodeMessage> delete(String id);
}
