class ProjectDetailsModel {
  final String supervisorID;
  final String projectName;
  final String address;
  final String addressGMap;
  final String clientName;
  final String clientEmail;
  final String clientPhone;
  final DateTime dateCreated;
  final DateTime dateDeadline;
  final bool isCompleted;

  ProjectDetailsModel({
    this.supervisorID,
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
