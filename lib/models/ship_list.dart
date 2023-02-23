// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// class ShipmentList {
//   String fileNumber;
//   String id;
//   ShipmentList({
//     required this.fileNumber,
//     required this.id,
//   });

//   ShipmentList copyWith({
//     String? fileNumber,
//     String? id,
//   }) {
//     return ShipmentList(
//       fileNumber: fileNumber ?? this.fileNumber,
//       id: id ?? this.id,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'fileNumber': fileNumber,
//       'id': id,
//     };
//   }

//   factory ShipmentList.fromMap(Map<String, dynamic> map) {
//     return ShipmentList(
//       fileNumber: map['fileNumber'] as String,
//       id: map['id'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory ShipmentList.fromJson(String source) =>
//       ShipmentList.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() => 'ShipmentList(fileNumber: $fileNumber, id: $id)';

//   @override
//   bool operator ==(covariant ShipmentList other) {
//     if (identical(this, other)) return true;

//     return other.fileNumber == fileNumber && other.id == id;
//   }

//   @override
//   int get hashCode => fileNumber.hashCode ^ id.hashCode;
// }
