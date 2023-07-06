enum AssetType {
  question('q'),
  answer('a');

  const AssetType(this.abbreviation);
  final String abbreviation;
}

class AssetManager {
  static String path({required String id, required AssetType assetType}) {
    return 'assets/${assetType.abbreviation}$id.png';
  }
}
