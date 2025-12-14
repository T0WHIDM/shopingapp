abstract class CategoryProductEvent {}

class CatagoryProductInitialize extends CategoryProductEvent {
  String categoryId;

  CatagoryProductInitialize(this.categoryId);
}
