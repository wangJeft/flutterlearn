import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User();

  late String login;
  num? id;
  String? node_id;
  late String avatar_url;
  String? gravatar_id;
  String? url;
  String? html_url;
  String? followers_url;
  String? following_url;
  String? gists_url;
  String? starred_url;
  String? subscriptions_url;
  String? organizations_url;
  String? repos_url;
  String? events_url;
  String? received_events_url;
  String? type;
  bool? site_admin;
  String? name;
  String? company;
  String? blog;
  String? location;
  String? email;
  String? hireable;
  String? bio;
  String? twitter_username;
  num? public_repos;
  num? public_gists;
  num? followers;
  num? following;
  String? created_at;
  String? updated_at;
  
  factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
