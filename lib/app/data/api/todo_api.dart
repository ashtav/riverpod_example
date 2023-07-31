part of api;

class TodoApi extends Fetch {
  Future<ResHandler> getTodo() async => await get('todos');
}