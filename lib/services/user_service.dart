import '../models/user_model.dart';

class UserService {
  final List<AppUser> _users = [];

  void registerUser(AppUser user) {
    _users.add(user);
  }

  List<AppUser> getUsers() {
    return _users;
  }
}
