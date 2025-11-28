class MyBanner {
  String? categoryId;
  String? collectionId;
  String? id;
  String? thumbnail;

  MyBanner(this.categoryId, this.collectionId, this.id, this.thumbnail);

  factory MyBanner.fromMapJson(Map<String, dynamic> jsonObject) {
    return MyBanner(
      jsonObject['categoryId'],
      jsonObject['collectionId'],
      jsonObject['id'],
      'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}',
    );
  }
}
