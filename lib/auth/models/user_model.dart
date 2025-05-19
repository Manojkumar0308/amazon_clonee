class Users {
  final String uid;
  final String email;

  Users({required this.uid, required this.email});

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
      };
}
