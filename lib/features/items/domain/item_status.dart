enum ItemStatus {
  sold('SOLD'),
  unavailable('UNAVAILABLE'),
  active('ACTIVE'),
  reserved('RESERVED');

  final String label;
  const ItemStatus(this.label);
}
