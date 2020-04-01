class EmailAddress {
  final String value;

  const EmailAddress(this.value) : assert(value != null);

  @override
  bool operator ==(other) {
    if (identical(this, other)) return true;

    return other is EmailAddress && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
