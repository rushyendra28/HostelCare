import '../models/complaint.dart';

extension ComplaintSortExtension on List<Complaint> {
  List<Complaint> sortedByDate() {
    final list = [...this];
    list.sort((a, b) => b.submittedDate.compareTo(a.submittedDate));
    return list;
  }
}
