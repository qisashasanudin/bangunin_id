class ProjectDetailsModel {
  String projectName;
  String address;
  String addressGMap;
  String clientName;
  String clientEmail;
  String clientPhone;
  DateTime dateCreated;
  DateTime dateDeadline;
  bool isCompleted;

  ProjectDetailsModel({
    this.projectName,
    this.address,
    this.addressGMap,
    this.clientName,
    this.clientEmail,
    this.clientPhone,
    this.dateCreated,
    this.dateDeadline,
    this.isCompleted,
  });
}
