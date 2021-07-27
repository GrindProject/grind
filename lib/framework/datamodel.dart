import 'model.dart';

abstract class DataModel extends Model {
  String id = '';

  DataModel(this.id);

  Map<String, dynamic> toJson();
}
