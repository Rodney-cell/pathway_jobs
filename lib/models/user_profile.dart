class UserProfile {
  final String uid;
  final String name;
  final String email;
  final String role;
  final bool approved;

  UserProfile({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    required this.approved,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'role': role,
      'approved': approved,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? '',
      approved: map['approved'] ?? false,
    );
  }
}