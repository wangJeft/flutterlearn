import 'package:json_annotation/json_annotation.dart';
import "user.dart";

part 'repo.g.dart';

@JsonSerializable()
class Repo {
  Repo();

  num? id;
  late String name;
  late String full_name;
  late User owner;
  Repo? parent;
  bool? private;
  String? description;
  late bool fork;
  String? language;
  num? forks_count;
  num? stargazers_count;
  num? size;
  String? default_branch;
  num? open_issues_count;
  String? pushed_at;
  String? created_at;
  String? updated_at;
  num? subscribers_count;
  Map<String, dynamic>? license;

  factory Repo.fromJson(Map<String, dynamic> json) => _$RepoFromJson(json);

  Map<String, dynamic> toJson() => _$RepoToJson(this);
}