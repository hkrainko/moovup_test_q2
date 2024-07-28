class Name {
  String last;
  String first;

  Name({
    required this.last,
    required this.first,
  });

  @override
  String toString() {
    return 'Name(last: $last, first: $first)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Name && other.last == last && other.first == first;
  }

  @override
  int get hashCode => last.hashCode ^ first.hashCode;
}
