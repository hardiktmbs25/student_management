class EmployeeModel {
  String id;
  String Emp_Name;
  String Role;
  DateTime Joining_date;
  bool isSynced;
  String syncMethod;

  EmployeeModel({required this.id,required this.Emp_Name, required this.Role,required this.Joining_date,this.isSynced = false,this.syncMethod = "None"});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
    id: json['id'],
    Emp_Name: json['Emp_Name'],
    Role: json['Role'],
    Joining_date: json['Joining_date'],
    isSynced: json['isSynced'],
    syncMethod: json['syncMethod'],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "Emp_Name": Emp_Name,
    "Role": Role,
    "Joining_date":Joining_date,
    "isSynced": isSynced,
    "syncMethod": syncMethod,
  };
}
