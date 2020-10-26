import 'package:flutter/foundation.dart';

class Orphanage with ChangeNotifier {
  final String id;
  final String name;
  final String about;
  final String instructions;
  final String openingHours;
  final String openOnWeekend;
  final String phone;

  Orphanage({
    this.id,
    this.name,
    this.about,
    this.instructions,
    this.openingHours,
    this.openOnWeekend,
    this.phone,
  });
}
