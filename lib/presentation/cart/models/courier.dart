class Courier {
  final String code;
  final String name;

  const Courier({
    required this.code,
    required this.name,
  });

  @override
  String toString() => name;
}

List<Courier> couriers = [
  const Courier(code: 'jne', name: 'JNE'),
  const Courier(code: 'pos', name: 'POS'),
  const Courier(code: 'jnt', name: 'J&T'),
];

const String subdistrictOrigin = '2269';
