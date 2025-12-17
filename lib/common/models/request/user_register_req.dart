class UserRegisterReq {
  String? username;
  String? password;
  String? email;
  String? firstName;
  String? lastName;

  UserRegisterReq({
    this.username,
    this.password,
    this.email,
    this.firstName,
    this.lastName,
  });

  UserRegisterReq.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}
