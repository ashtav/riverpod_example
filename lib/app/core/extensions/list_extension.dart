extension ListExtension<E> on List<E>? {
  E find(bool Function(E e) test, E Function() orElse) {
    return (this ?? []).firstWhere(test, orElse: orElse);
  }
}
