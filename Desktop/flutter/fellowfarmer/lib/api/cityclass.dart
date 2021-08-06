class City {
  const City({
    required this.name,
  });

  final String name;

  @override
  String toString() {
    return '$name';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is City && other.name == name;
  }
}
