import 'dart:convert';
import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

// user.g.dart 将在我们运行生成命令后自动生成
part 'json_model.g.dart';

/**
 * 生成json_model步骤
 * 1. 引入build_runner依赖
 * 2. // user.g.dart 将在我们运行生成命令后自动生成
    part 'json_model.g.dart';
 * 3. flutter packages pub run build_runner build
 *
 */

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class User {

  @JsonKey(name: "name")
  String name;
  String email;

  User(this.name, this.email);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}

