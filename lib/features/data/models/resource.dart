class Resource<T> {
  final Status status;
  final T? data;
  final String? message;
  Resource(this.status, this.data, this.message);

  void fold(void Function(dynamic failure) param0,
      void Function(dynamic data) param1) {}
}

// ignore: constant_identifier_names
enum Status { LOADING, SUCCESS, ERROR }
