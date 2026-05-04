mixin Linkable<T> {
  T? _prev;
  T? _next;

  T? getPrev() => _prev;

  T? getNext() => _next;

  set prev(T chainable) {
    _prev = chainable;
  }

  set next(T chainable) {
    _next = chainable;
  }
}
