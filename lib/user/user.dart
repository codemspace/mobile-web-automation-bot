class User {
  String image;
  String name;
  String nickname;
  String email;
  String phone;
  String dateOfBirth;
  String nationality;
  String gender;
  String primaryAddress;
  String mailingAddress;
  String passport;

  // constructor
  User({
    required this.image,
    required this.name,
    required this.nickname,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    required this.nationality,
    required this.gender,
    required this.primaryAddress,
    required this.mailingAddress,
    required this.passport,
  });

  User copy({
    String? imagePath,
    String? name,
    String? nickname,
    String? phone,
    String? email,
    String? dateOfBirth,
    String? nationality,
    String? gender,
    String? primaryAddress,
    String? mailingAddress,
    String? passport,
  }) =>
      User(
        image: imagePath ?? this.image,
        name: name ?? this.name,
        nickname: nickname ?? this.nickname,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        nationality: nationality ?? this.nationality,
        gender: gender ?? this.gender,
        primaryAddress: primaryAddress ?? this.primaryAddress,
        mailingAddress: mailingAddress ?? this.mailingAddress,
        passport: passport ?? this.passport,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        image: json['imagePath'],
        name: json['name'],
        nickname: json['nickname'],
        email: json['email'],
        phone: json['phone'],
        dateOfBirth: json['dateOfBirth'],
        nationality: json['nationality'],
        gender: json['gender'],
        primaryAddress: json['primaryAddress'],
        mailingAddress: json['mailingAddress'],
        passport: json['passport'],
      );

  Map<String, dynamic> toJson() => {
        'imagePath': image,
        'name': name,
        'nickname': nickname,
        'email': email,
        'phone': phone,
        'dateOfBirth': dateOfBirth,
        'nationality': nationality,
        'gender': gender,
        'primaryAddress': primaryAddress,
        'mailingAddress': mailingAddress,
        'passport': passport,
      };
}
