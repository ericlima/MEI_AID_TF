class LoginRequestDTO {
  String? username;
  String? password;

  LoginRequestDTO();

  LoginRequestDTO.withParams({
    this.username,
    this.password,
  });

  factory LoginRequestDTO.fromJson(Map<String, dynamic> json) {
    return LoginRequestDTO.withParams(
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
