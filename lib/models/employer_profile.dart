class EmployerProfile {
  final String uid;
  final String companyName;
  final String contactPerson;
  final String email;
  final String phone;
  final String website;
  final String description;
  final String location;
  final bool approved;

  EmployerProfile({
    required this.uid,
    required this.companyName,
    required this.contactPerson,
    required this.email,
    required this.phone,
    required this.website,
    required this.description,
    required this.location,
    required this.approved,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'companyName': companyName,
      'contactPerson': contactPerson,
      'email': email,
      'phone': phone,
      'website': website,
      'description': description,
      'location': location,
      'approved': approved,
    };
  }

  factory EmployerProfile.fromMap(Map<String, dynamic> map) {
    return EmployerProfile(
      uid: map['uid'] ?? '',
      companyName: map['companyName'] ?? '',
      contactPerson: map['contactPerson'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      website: map['website'] ?? '',
      description: map['description'] ?? '',
      location: map['location'] ?? '',
      approved: map['approved'] ?? false,
    );
  }
}