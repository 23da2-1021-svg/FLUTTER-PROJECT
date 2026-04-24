class UserModel {
  final String id;
  final String fullName;
  final String email;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.email,
  });

  String get initials {
    final parts = fullName.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return fullName[0].toUpperCase();
  }
}
