class VariantsType {
  String? id;
  String? name;
  String? title;
  VariantTypeEnum? type;

  VariantsType(this.id, this.name, this.title, this.type);

  factory VariantsType.fromMapJson(Map<String, dynamic> jsonObject) {
    return VariantsType(
      jsonObject['id'],
      jsonObject['name'],
      jsonObject['title'],
      _getTypeEnum(jsonObject['type']),
    );
  }
}

VariantTypeEnum _getTypeEnum(String type) {
  switch (type) {
    case 'color':
      return VariantTypeEnum.color;

    case 'storage':
      return VariantTypeEnum.storage;

    case 'voltage':
      return VariantTypeEnum.voltage;

    default:
      return VariantTypeEnum.color;
  }
}

enum VariantTypeEnum { color, storage, voltage }
