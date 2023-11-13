import 'dart:io';

class Images{
  late final String name;
  late File? imgPath;

  Images(this.name, this.imgPath);
}

class Results {
  late final String location;
  late final DateTime uploadDate;
  late final int numberImages;
  late final bool isDone;
  late final double Edwardsiella;
  late final double Vibrio;
  late final double Streptococcus;
  late final double Tenacibaculumn;
  late final double Enteromyxum;
  late final double Miamiensis;
  late final double VHSV;

  Results({
    required this.location,
    required this.uploadDate,
    required this.numberImages,
    required this.isDone,
    required this.Edwardsiella,
    required this.Vibrio,
    required this.Streptococcus,
    required this.Tenacibaculumn,
    required this.Enteromyxum,
    required this.Miamiensis,
    required this.VHSV,
  });

  List<double> get diseaseScore {
    return [Edwardsiella, Vibrio, Streptococcus, Tenacibaculumn, Enteromyxum, Miamiensis, VHSV];
  }

}

class Guide{
  late final String name;
  late final String imgPath;

  Guide(this.name, this.imgPath);
}

class Disease{
  late final String krName;
  late final String enName;
  late final List<String> imgPath;
  late final String infectionSrc;
  late final String symptom;
  late final String period;
  late final String description;

  Disease(this.krName, this.enName, this.imgPath, this.infectionSrc, this.symptom, this.period, this.description);
}