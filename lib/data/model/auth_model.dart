class CreateModel {
  String name;
  String email;
  String password;

  CreateModel({required this.name, required this.email, required this.password});
  factory CreateModel.fromJson(Map<String, dynamic> json) => CreateModel(
    name: json["name"],
    email: json["email"],
    password: json["password"],
  );
  Map<String ,dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
  };
}