import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:psicApp/app/core/constants/app_enums.dart';

class Psychologist extends Equatable {
  final String uid;
  final String name;
  final String contact;
  final String email;
  final String imageUrl;
  final SpecialtyType specialty;
  final DateTime createdAt;

  const Psychologist({
    required this.uid,
    required this.name,
    required this.contact,
    required this.email,
    this.imageUrl = '',
    required this.createdAt,
    this.specialty = SpecialtyType.none,
  });

  factory Psychologist.fromJson(Map<String, dynamic> map) {
    return Psychologist(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      contact: map['contact'] ?? '',
      email: map['email'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      specialty: SpecialtyType.values.firstWhere(
        (e) => e.name == map['specialty'],
        orElse: () => SpecialtyType.none,
      ),
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
      'specialty': specialty.name,
      'createdAt': createdAt,
    };
  }

  factory Psychologist.empty() {
    return Psychologist(
      uid: '',
      name: '',
      contact: '',
      email: '',
      specialty: SpecialtyType.none,
      createdAt: DateTime.now(),
    );
  }

  factory Psychologist.fromMap(Map<String, dynamic> map) {
    return Psychologist(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      contact: map['contact'] ?? '',
      email: map['email'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      specialty: map['specialty'] ?? SpecialtyType.none,
      createdAt:
          (map['createdAt'] is Timestamp)
              ? (map['createdAt'] as Timestamp).toDate()
              : DateTime.tryParse(map['createdAt']?.toString() ?? '') ??
                  DateTime.now(),
    );
  }

  Psychologist copyWith(Map<String, dynamic> newer) {
    Map<String, dynamic> current = toJson();
    Map<String, dynamic> merged = {...current, ...newer};
    return Psychologist.fromJson(merged);
  }

  @override
  List<Object?> get props => [
    uid,
    name,
    contact,
    email,
    imageUrl,
    specialty,
    createdAt,
  ];
}
