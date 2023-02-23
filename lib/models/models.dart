// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// class UserModel {
//   final int id;
//   final String token;

//   UserModel({
//     required this.id,
//     required this.token,
//   });

//   UserModel copyWith({
//     int? id,
//     String? token,
//   }) {
//     return UserModel(
//       id: id ?? this.id,
//       token: token ?? this.token,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'token': token,
//     };
//   }

//   factory UserModel.fromMap(Map<String, dynamic> map) {
//     return UserModel(
//       id: map['id'] as int,
//       token: map['token'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory UserModel.fromJson(String source) =>
//       UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() => 'UserModel(id: $id, token: $token)';

//   @override
//   bool operator ==(covariant UserModel other) {
//     if (identical(this, other)) return true;

//     return other.id == id && other.token == token;
//   }

//   @override
//   int get hashCode => id.hashCode ^ token.hashCode;
// }
