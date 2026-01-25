import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Schedule extends Equatable {
  final String uid;
  final String name;
  final String contato;
  final String email;
  final String imageUrl;
  final DateTime createAt;

  const Schedule({
    required this.uid,
    required this.name,
    required this.contato,
    required this.email,
    this.imageUrl = '',
    required this.createAt,
  });

  factory Schedule.fromJson(Map<String, dynamic> map) {
    return Schedule(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      contato: map['contato'] ?? '',
      email: map['email'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      createAt: (map['createAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'contato': contato,
      'email': email,
      'imageUrl': imageUrl,
      'createAt': createAt,
    };
  }

  factory Schedule.empty() {
    return Schedule(
      uid: '',
      name: '',
      contato: '',
      email: '',
      createAt: DateTime.now(),
    );
  }

  factory Schedule.fromMap(Map<String, dynamic> map) {
    return Schedule(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      contato: map['contato'] ?? '',
      email: map['email'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      createAt:
          (map['createAt'] is Timestamp)
              ? (map['createAt'] as Timestamp).toDate()
              : DateTime.tryParse(map['createAt']?.toString() ?? '') ??
                  DateTime.now(),
    );
  }

  Schedule copyWith(Map<String, dynamic> newer) {
    Map<String, dynamic> current = toJson();
    Map<String, dynamic> merged = {...current, ...newer};
    return Schedule.fromJson(merged);
  }

  @override
  List<Object?> get props => [uid, name, contato, email, imageUrl, createAt];
}
