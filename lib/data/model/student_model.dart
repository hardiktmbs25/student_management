class StudentModel {
  String id;
  String Name;
  int RollNo;
  String Class;
  bool isSyncd;
  String syncMethod;

  StudentModel({required this.id,required this.Name, required this.RollNo, required this.Class,this.isSyncd = false,this.syncMethod = "None"});

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    id: json['id'],
    Name: json['Name'],
    RollNo: json['RollNo'],
    Class: json['Class'],
    isSyncd: json['isSyncd'],
    syncMethod: json['syncMethod'],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "Name": Name,
    "RollNo": RollNo,
    "Class": Class,
    "isSyncd": isSyncd,
    "syncMethod": syncMethod,
  };
}
