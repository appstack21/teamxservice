class TXSResult<T> {
  TXSResult._();

  factory TXSResult.success(T value) = SuccessState<T>;
  factory TXSResult.error(T error) = ErrorState<T>;
  factory TXSResult.loading(T msg) = LoadingState<T>;
}

class ErrorState<T> extends TXSResult<T> {
  ErrorState(this.error) : super._();
  final T error;
}

class SuccessState<T> extends TXSResult<T> {
  SuccessState(this.value) : super._();
  final T value;
}

class LoadingState<T> extends TXSResult<T> {
  LoadingState(this.msg) : super._();
  final T msg;
}
