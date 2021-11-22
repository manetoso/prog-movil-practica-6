// ignore_for_file: file_names

class ProductDAO {
  String? cveprod;
  String? descprod;
  String? imgprod;

  ProductDAO({
    this.cveprod,
    this.descprod,
    this.imgprod,
  });

  Map<String, dynamic> toMap() {
    return {
      'cveprod': cveprod,
      'descprod': descprod,
      'imgprod': imgprod,
    };
  }

}