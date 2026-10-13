class SignupRespEntity {
  final int id;
  final String email;
  final String password;
  final String name;
  final String role;
  final String avatar;
  final String creationAt;
  final String updatedAt;

  const SignupRespEntity({
    this.id = 0,
    this.email = "",
    this.password = "",
    this.name = "",
    this.role = "",
    this.avatar = "",
    this.creationAt = "",
    this.updatedAt = "",
  });
}
