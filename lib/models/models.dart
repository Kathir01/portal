// import 'dart:convert';

// // // ignore_for_file: public_member_api_docs, sort_constructors_first
// // import 'dart:convert';

// // class User {
// //   final int id;
// //   final int userId;
// //   final String title;
// //   final String body;

// //   User({
// //     required this.id,
// //     required this.userId,
// //     required this.title,
// //     required this.body,
// //   });

// //   User copyWith({
// //     int? id,
// //     int? userId,
// //     String? title,
// //     String? body,
// //   }) {
// //     return User(
// //       id: id ?? this.id,
// //       userId: userId ?? this.userId,
// //       title: title ?? this.title,
// //       body: body ?? this.body,
// //     );
// //   }

// //   Map<String, dynamic> toMap() {
// //     return <String, dynamic>{
// //       'id': id,
// //       'userId': userId,
// //       'title': title,
// //       'body': body,
// //     };
// //   }

// //   factory User.fromMap(Map<String, dynamic> map) {
// //     return User(
// //       id: map['id'] as int,
// //       userId: map['userId'] as int,
// //       title: map['title'] as String,
// //       body: map['body'] as String,
// //     );
// //   }

// //   String toJson() => json.encode(toMap());

// //   factory User.fromJson(String source) =>
// //       User.fromMap(json.decode(source) as Map<String, dynamic>);

// //   @override
// //   String toString() {
// //     return 'User(id: $id, userId: $userId, title: $title, body: $body)';
// //   }

// //   @override
// //   bool operator ==(covariant User other) {
// //     if (identical(this, other)) return true;

// //     return other.id == id &&
// //         other.userId == userId &&
// //         other.title == title &&
// //         other.body == body;
// //   }

// //   @override
// //   int get hashCode {
// //     return id.hashCode ^ userId.hashCode ^ title.hashCode ^ body.hashCode;
// //   }
// // }

// class User {
//   final int ok;
//   final int data;

//   User({
//     required this.ok,
//     required this.data,
//   });

//   User copyWith({
//     int? ok,
//     int? data,
//   }) {
//     return User(
//       ok: ok ?? this.ok,
//       data: data ?? this.data,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'ok': ok,
//       'data': data,
//     };
//   }

//   factory User.fromMap(Map<String, dynamic> map) {
//     return User(
//       ok: map['ok'] as int,
//       data: map['data'] as int,
//     );
//   }

// //   String toJson() => json.encode(toMap());

// //   factory User.fromJson(String source) =>
// //       User.fromMap(json.decode(source) as Map<String, dynamic>);

// //   @override
// //   String toString() => 'User(ok: $ok, data: $data)';

// //   @override
// //   bool operator ==(covariant User other) {
// //     if (identical(this, other)) return true;

// //     return other.ok == ok && other.data == data;
// //   }

// //   @override
// //   int get hashCode => ok.hashCode ^ data.hashCode;
// // }
