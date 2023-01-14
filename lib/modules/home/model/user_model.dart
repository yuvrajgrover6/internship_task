// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ApiResponse {
  String name;
  String id;
  String atype;
  ApiResponse({
    required this.name,
    required this.id,
    required this.atype,
  });

  ApiResponse copyWith({
    String? name,
    String? id,
    String? atype,
  }) {
    return ApiResponse(
      name: name ?? this.name,
      id: id ?? this.id,
      atype: atype ?? this.atype,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'atype': atype,
    };
  }

  factory ApiResponse.fromMap(Map<String, dynamic> map) {
    return ApiResponse(
      name: map['name'] as String,
      id: map['id'] as String,
      atype: map['atype'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiResponse.fromJson(String source) =>
      ApiResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
