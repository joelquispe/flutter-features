// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WarriorZModel {
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

  WarriorZModel({
    required this.id,
    required this.name,
    required this.ki,
    required this.maxKi,
    required this.race,
    required this.gender,
    required this.description,
    required this.image,
    required this.affiliation,
    required this.deletedAt
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'ki': ki,
      'maxKi': maxKi,
      'race': race,
      'gender': gender,
      'description': description,
      'image': image,
      'affiliation': affiliation,
      'deletedAt': deletedAt?.millisecondsSinceEpoch,
    };
  }

  factory WarriorZModel.fromMap(Map<String, dynamic> map) {
    return WarriorZModel(
      id: map['id'] as int,
      name: map['name'] as String,
      ki: map['ki'] as String,
      maxKi: map['maxKi'] as String,
      race: map['race'] as String,
      gender: map['gender'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      affiliation: map['affiliation'] as String,
      deletedAt: map['deletedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['deletedAt'] as int) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WarriorZModel.fromJson(String source) => WarriorZModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
