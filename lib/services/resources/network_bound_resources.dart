abstract class NetworkBoundResources {
  Future<T> networkBoundResponse<T>({
    required Future<T> fromRemote,
    Future<T> Function(T response)? onRemoteDataFetched,
  }) async {
    final response = await fromRemote;
    onRemoteDataFetched?.call(response);
    return response;
  }
}
