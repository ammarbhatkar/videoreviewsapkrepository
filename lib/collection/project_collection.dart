import 'package:Video_Review/collection/marker_collection.dart';
import 'package:isar/isar.dart';

part 'project_collection.g.dart';

@Collection()
class ProjectColleciton {
  Id id = Isar.autoIncrement;
  String? title;

  String? videopath;
  String? date;

  @Index(composite: [CompositeIndex('title')])
  final markerCollectionObject = IsarLinks<MarkerCollection>();
}
