import 'dart:convert';

class Tile {
  String title;
  String subtitle;
  String event;
  String image;

  Tile({
    required this.title,
    required this.subtitle,
    required this.event,
    required this.image
  });

  Tile copyWith({
    String? title,
    String? subtitle,
    String? event,
    String? image,
  }) {
    return Tile(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      event: event ?? this.event,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'event': event,
      'image': image,
    };
  }

  factory Tile.fromMap(Map<String, dynamic> map) {
    return Tile(
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      event: map['event'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Tile.fromJson(String source) => Tile.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Tile(title: $title, subtitle: $subtitle, event: $event, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Tile &&
      other.title == title &&
      other.subtitle == subtitle &&
      other.event == event &&
      other.image == image;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      subtitle.hashCode ^
      event.hashCode ^
      image.hashCode;
  }
}
