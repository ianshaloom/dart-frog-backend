import 'package:dart_frog_backend/constants/constants.dart';
import 'package:dart_frog_backend/repository/repos_impl.dart';
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
  final DatasourceRepo datasourceRepo;

  final Map<String, User> users = {};

  //check if user exists in the database
  Future<User?> userFromCredentials(String email, String password) async {
    final hashedPassword = password.hashWithSHA256();

    try {
      final userExist = await datasourceRepo.usersRepo.userExists(email.hashWithSHA256());

      if (!userExist) {
        return null;
      }

      final user = await datasourceRepo.usersRepo.getItem(email.hashWithSHA256()).then((value) => User.fromJson(value));

      final credentialsMatch = user.password == hashedPassword;

      return credentialsMatch ? user : throw Exception('Incorrect credentials');
      
    } catch (e) {

      throw Future.error(Exception(e.toString()));
      
    }
  }

  // search a user by id
  Future<User?> userFromId(String id) async {

    try {
      final user = await datasourceRepo.usersRepo.getItem(id).then((value) => User.fromJson(value));
      return user;
      
    } catch (e) {
      throw Future.error(Exception(e.toString()));
      
    }
  }

  Future<String> createUser(
    String username,
    String email,
    String password,
  ) async {
    final user = User(
      id: email.hashWithSHA256(),
      username: username,
      email: email,
      password: password.hashWithSHA256(),
    );

    print(user.toJson());

    try {
      final id = await datasourceRepo.usersRepo.addItem(user.toJson());
      return Future.value(id);
    } catch (e) {
      throw Future.error(Exception(e.toString()));
    }
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

  UserRepository(this.datasourceRepo);
}
