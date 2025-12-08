class VariantType {
  String? id;
  String? name;
  String? title;
  VariantTypeEnum? type;

  VariantType(this.id, this.name, this.title, this.type);

  factory VariantType.fromjson(Map<String, dynamic> jsonObject) {
    return VariantType(
      jsonObject['id'],
      jsonObject['name'],
      jsonObject['title'],
      _getTypeEnum(jsonObject['type']),
    );
  }
}

VariantTypeEnum _getTypeEnum(String type) {
  switch (type.toUpperCase()) {
    case 'COLOR':
      return VariantTypeEnum.COLOR;
    case 'STORAGE':
      return VariantTypeEnum.STORAGE;
    case 'VOLTAGE':
      return VariantTypeEnum.VOLTAGE;
    default:
      return VariantTypeEnum.COLOR;
  }
}


enum VariantTypeEnum { COLOR, STORAGE, VOLTAGE }