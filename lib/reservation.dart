class Reservation {
  final String id;
  final String studentId;
  final String courseId;
  final String day;
  final String time;

  Reservation({
    required this.id,
    required this.studentId,
    required this.courseId,
    required this.day,
    required this.time
  });

  factory Reservation.fromMapEntry(MapEntry entry){
    return Reservation(
        id: entry.key,
        studentId: entry.value['userId'] ?? '',
        courseId:entry.value['courseId'] ?? '',
        day: entry.value['day'] ?? '',
        time: entry.value['time']?? '');
  }

}