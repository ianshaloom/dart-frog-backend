import 'package:dart_frog_backend/constants/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final String id;
  final String username;
  final String email;
  final String password;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [id, username, email, password];
}


class UserRepository {

  final Map<String, User> users = {};

  //check if user exists in the database
  Future<User?> userFromCredentials(String username, String password) async {
    final hashedPassword = password.hashWithSHA256();

    final user = users.values.where(
      (user) {
        return user.username == username && user.password == hashedPassword;
      },
    ).toList();

    return user.isEmpty ? null : user.first;
  }

  // search a user by id
  Future<User?> userFromId(String id) async {
    final user = users[id];

    return user;
  }

  Future<User> createUser(
    String username,
    String email,
    String password,
  ) async {
    final user = User(
      id: const Uuid().v5(null, email),
      username: username,
      email: email,
      password: password.hashWithSHA256(),
    );

    users[user.id] = user;

    return Future.value(user);
  }

  Future<void> deleteUser(String id) async {
    users.remove(id);
  }

  Future<User> updateUser(
    String id, {
    String? username,
    String? email,
    String? password,
  }) async {
    final user = users[id];

    if (user == null) {
      throw Future.error(Exception('User not found'));
    }

    final newUsername = username ?? user.username;
    final newEmail = email ?? user.email;
    final hashedPassword =
        password != null ? const Uuid().v5(null, password) : user.password;

    final updatedUser = user.copyWith(
      username: newUsername,
      email: newEmail,
      password: hashedPassword,
    );

    users[id] = updatedUser;

    return Future.value(updatedUser);
  }

  // factory constructor
  UserRepository._();
  static final UserRepository _instance = UserRepository._();
  factory UserRepository() =>  _instance;
}
