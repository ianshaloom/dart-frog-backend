import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_backend/repository/session/session.dart';
import 'package:dart_frog_backend/repository/user/user.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';

Handler middleware(Handler handler) {
  return handler.use(
    bearerAuthentication<User>(
      authenticator: (context, token) async {
        final userRepo = context.read<UserRepository>();
        final sessionRepo = context.read<SessionRepository>();

        final session = await sessionRepo.sessionFromToken(token);

        return session != null
            ? userRepo.userFromId(session.userId)
            : Future.value(null);
      },
      applies: (RequestContext context) async {
        return context.request.method != HttpMethod.post &&
            context.request.method != HttpMethod.get;
      },
    ),
  );
}
