class WarriorZ{

  int id;
  String name;
  String ki;
  String maxKi;
  String race;
  String gender;
  String description;
  String image;
  String affiliation;
  DateTime? deletedAt;

  WarriorZ({
    required this.id,
    required this.name,
    required this.ki,
    required this.maxKi,
    required this.race,
    required this.gender,
    required this.description,
    required this.image,
    required this.affiliation,
    this.deletedAt,
  });
  
  }