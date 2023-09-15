import 'dart:io';

class Images{
  late final String name;
  late File? imgPath;

  Images(this.name, this.imgPath);
}

class Results{
  late final DateTime date;
  late final bool result;
  late final double percent;
  late final String disease;

  Results({required DateTime date, required bool result, double percent = 0, required String disease})
  : date = date,
  result = result,
  percent = percent,
  disease = disease;
}

class Guide{
  late final String name;
  late final String imgPath;

  Guide(this.name, this.imgPath);
}