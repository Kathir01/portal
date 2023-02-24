// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ShipmentList {
  String fileNumber;
  String id;
  String status;
  ShipmentList({
    required this.fileNumber,
    required this.id,
    required this.status,
  });

  ShipmentList copyWith({
    String? fileNumber,
    String? id,
    String? status,
  }) {
    return ShipmentList(
      fileNumber: fileNumber ?? this.fileNumber,
      id: id ?? this.id,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fileNumber': fileNumber,
      'id': id,
      'status': status,
    };
  }

  factory ShipmentList.fromMap(Map<String, dynamic> map) {
    return ShipmentList(
      fileNumber: map['fileNumber'] as String,
      id: map['id'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShipmentList.fromJson(String source) =>
      ShipmentList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ShipmentList(fileNumber: $fileNumber, id: $id, status: $status)';

  @override
  bool operator ==(covariant ShipmentList other) {
    if (identical(this, other)) return true;

    return other.fileNumber == fileNumber &&
        other.id == id &&
        other.status == status;
  }

  @override
  int get hashCode => fileNumber.hashCode ^ id.hashCode ^ status.hashCode;
}
