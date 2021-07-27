import 'dart:async';

class Pipe<T> {
  final StreamController<T> _controller;

  Stream<T> get receive => _controller.stream;

  Pipe() : _controller = StreamController<T>.broadcast() {
    _controller.onListen = () {};
  }

  void whenListenedDo(Function onListen) {
    _controller.onListen = () {
      onListen();
    };
  }

  void dispose() {
    _controller.close();
  }

  bool send(T data) {
    if (_controller.isClosed) return false;
    _controller.sink.add(data);
    return true;
  }

  bool throwError(Error error) {
    if (_controller.isClosed) return false;
    _controller.sink.addError(error);
    return true;
  }
}
