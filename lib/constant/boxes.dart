import 'package:hive/hive.dart';

class HiveBoxes {
  static Box getUserId() => Hive.box('userId');
}
