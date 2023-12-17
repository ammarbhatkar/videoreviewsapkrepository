import 'package:isar/isar.dart';

part 'marker_collection.g.dart';

@Collection()
class MarkerCollection {
  Id id = Isar.autoIncrement;

  late int? projectId;
  late String? feedback;
  late double? dy;
  late int? timeStamp;
  late int? order;
  late double? dx;
}
