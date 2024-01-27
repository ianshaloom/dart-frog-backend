/// An abstract class that defines the interface for all repositories.
abstract class Repo {
  /// Returns a list of all objects of type [T].
  Future<T> get<T>(String id);

  /// Returns a list of all objects of type [T].
  Future<List<T>> getAll<T>();

  /// Adds the given [object] to the repository.
  Future<void> add<T>(T object);

}
