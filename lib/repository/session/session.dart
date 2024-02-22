import 'package:equatable/equatable.dart';



class Session extends Equatable {
  final String userId;
  final String token;
  final DateTime expiryDate;
  final DateTime createdAt;

  Session({
    required this.userId,
    required this.token,
    required this.expiryDate,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [userId, token, expiryDate, createdAt];
}

class SessionRepository {
  Future<Session> createSession(String userId) async {
    final session = Session(
      userId: userId,
      token: generateToken(userId),
      expiryDate: DateTime.now().add(const Duration(hours: 24)),
      createdAt: DateTime.now(),
    );
    sessions[session.token] = session;
    return session;
  }

  Future<Session?> sessionFromToken(String token) async {
    final session = sessions[token];

    if (session != null && session.expiryDate.isAfter(DateTime.now())) {
      return session;
    }

    return null;
  }

  Future<void> deleteSession(String token) async {
    sessions.remove(token);
  }

  String generateToken(String userId) {
    return '${userId}--${DateTime.now().toIso8601String()}';
  }

  final Map<String, Session> sessions = {};

  // factory constructor
  SessionRepository._();
  static final SessionRepository _instance = SessionRepository._();
  factory SessionRepository() => _instance;
}
