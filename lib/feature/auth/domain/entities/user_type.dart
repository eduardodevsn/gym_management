enum UserType {
  user,
  coach;

  String get label => switch (this) {
        UserType.user => 'USUARIO',
        UserType.coach => 'COACH',
      };
}
