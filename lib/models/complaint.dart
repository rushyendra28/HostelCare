enum ComplaintStatus { inProgress, viewed, solved }

class Complaint {
  final String id;
  final String title;
  final String description;
  final String guestName;
  final String roomNumber;
  final DateTime submittedDate;
  final ComplaintStatus status;
  final String? photoUrl;

  Complaint({
    required this.id,
    required this.title,
    required this.description,
    required this.guestName,
    required this.roomNumber,
    required this.submittedDate,
    required this.status,
    this.photoUrl,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      guestName: json['guestName'],
      roomNumber: json['roomNumber'],
      submittedDate: DateTime.parse(json['submittedDate']),
      status: _statusFromString(json['status']),
      photoUrl: json['photoUrl'],
    );
  }

  static ComplaintStatus _statusFromString(String status) {
    switch (status.toLowerCase()) {
      case 'in_progress':
        return ComplaintStatus.inProgress;
      case 'viewed':
        return ComplaintStatus.viewed;
      case 'solved':
        return ComplaintStatus.solved;
      default:
        return ComplaintStatus.viewed;
    }
  }

  String get statusString {
    switch (status) {
      case ComplaintStatus.inProgress:
        return 'In Progress';
      case ComplaintStatus.viewed:
        return 'Viewed';
      case ComplaintStatus.solved:
        return 'Solved';
    }
  }
}
