import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Patient extends Equatable {
  final String uid;
  final String name;
  final String contact;
  final String email;
  final String imageUrl;
  final DateTime createdAt;

  const Patient({
    required this.uid,
    required this.name,
    required this.contact,
    required this.email,
    this.imageUrl = '',
    required this.createdAt,
  });

  factory Patient.fromJson(Map<String, dynamic> map) {
    return Patient(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      contact: map['contact'] ?? '',
      email: map['email'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'contact': contact,
      'email': email,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
    };
  }

  factory Patient.empty() {
    return Patient(
      uid: '',
      name: '',
      contact: '',
      email: '',
      createdAt: DateTime.now(),
    );
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      contact: map['contact'] ?? '',
      email: map['email'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      createdAt:
          (map['createdAt'] is Timestamp)
              ? (map['createdAt'] as Timestamp).toDate()
              : DateTime.tryParse(map['createdAt']?.toString() ?? '') ??
                  DateTime.now(),
    );
  }

  Patient copyWith(Map<String, dynamic> newer) {
    Map<String, dynamic> current = toJson();
    Map<String, dynamic> merged = {...current, ...newer};
    return Patient.fromJson(merged);
  }

  @override
  List<Object?> get props => [uid, name, contact, email, imageUrl, createdAt];
}
