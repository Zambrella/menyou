enum Flavor {
  dev('development'),
  staging('staging'),
  prod('production');

  const Flavor(this.name);

  final String name;
}
