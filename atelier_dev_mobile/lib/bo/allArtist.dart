import 'dart:convert';
class AllArtist{
  int? id;
  String? name;
  String? description;
  String? scene;
  String? heure;
  AllArtist(this.id, this.name, this.description, this.scene, this.heure);
  AllArtist.fromJson(Map<String, dynamic> json):
        id = json['id'],
        name = json['name'],
        description = json['description'],
        scene = json['scene'],
        heure = json['heure'];

  Map<String, dynamic> toJson() =>{
    'id' : id,
    'name' : name,
    'description' : description,
    'scene' : scene,
    'heure' : heure,
  };
}