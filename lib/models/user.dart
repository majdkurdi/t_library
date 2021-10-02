class User {
  final String email;
  final String name;
  final String address;
  final String phoneNumber;
  final String token;
  final int id;

  User({
    required this.email,
    required this.name,
    required this.address,
    required this.token,
    required this.id,
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> response) => User(
        email: response['user']['email'] as String,
        name: response['user']['name'] as String,
        address: response['user']['address'] as String,
        id: response['user']['id'] as int,
        phoneNumber: response['user']['phone_number'] as String,
        token: response['token'] as String,
      );
}
