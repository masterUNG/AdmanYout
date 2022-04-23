import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class PostModel {
  final String uidPost;
  final List<String> urlPaths;
  final String article;
  final List<String> link;
  final String nameButton;
  final String name;
  PostModel({
    required this.uidPost,
    required this.urlPaths,
    required this.article,
    required this.link,
    required this.nameButton,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uidPost': uidPost,
      'urlPaths': urlPaths,
      'article': article,
      'link': link,
      'nameButton': nameButton,
      'name': name,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      uidPost: (map['uidPost'] ?? '') as String,
      urlPaths: List<String>.from(map['urlPaths']),
      article: (map['article'] ?? '') as String,
      link: List<String>.from(map['link']),
      nameButton: (map['nameButton'] ?? '') as String,
      name: (map['name'] ?? '') as String,
    );
  }

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
