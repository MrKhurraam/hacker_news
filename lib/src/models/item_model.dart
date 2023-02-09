import 'dart:convert';

class ItemModel {
  int? id;
  bool? deleted;
  String? type;
  String? by;
  int? time;
  String? text;
  bool? dead;
  int? parent;
  List<dynamic>? kids;
  String? url;
  int? score;
  String? title;
  int? descendants;

  ItemModel(
      {this.by,
      this.id,
      this.score,
      this.text,
      this.time,
      this.title,
      this.type,
      this.url});

  ItemModel.fromJson(Map<String, dynamic> json) {
    by = json['by'] ?? '';
    id = json['id'];
    score = json['score'];
    text = json['text'] ?? "";
    time = json['time'];
    title = json['title'];
    type = json['type'];
    dead = json['dead'] ?? false;
    parent = json['parent'];
    url = json['url'];
    kids = json['kids'] ?? [];
    deleted = json['deleted'] ?? false;
    descendants = json['descendants'] ?? 0;
  }

  ItemModel.fromDb(Map<String, dynamic> json) {
    by = json['by'];
    id = json['id'];
    score = json['score'];
    text = json['text'];
    time = json['time'];
    title = json['title'];
    type = json['type'];
    dead = json['dead'] == 1;
    parent = json['parent'];
    url = json['url'];
    kids = jsonDecode(json['kids']);
    deleted = json['deleted'] == 1;
    descendants = json['descendants'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['by'] = this.by;
    data['id'] = this.id;
    data['score'] = this.score;
    data['text'] = this.text;
    data['time'] = this.time;
    data['title'] = this.title;
    data['type'] = this.type;
    data['dead'] = this.dead == null || this.dead == true ? 1 : 0;
    data['parent'] = this.parent;
    data['url'] = this.url;
    data['kids'] = jsonEncode(this.kids);
    data['deleted'] = this.deleted == null || this.deleted == true ? 1 : 0;
    data['descendants'] = this.descendants;
    return data;
  }
}
