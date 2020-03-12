import 'dart:async';

class SimpleBloc<T> {
  final _controller = StreamController<T>();

  Stream<T> get stream => _controller.stream;

  void add(T object) {
    _controller.add(object);
  }

  void addError(Object erro) {
    if (!_controller.isClosed) {
      _controller.addError(erro);
    }
  }

  @override
  void dispose() {
    _controller.close();
  }
}
