import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

import '../reservation.dart';

class DayLessonHelper {
  /// load dayData from server

  Future<List<Reservation?>?> getReservations(DateTime date) async {

    String targetDate = DateFormat('yyyy-MM-dd').format(date);
    // 1. Connect to your database.
    DatabaseReference reservationsRef = FirebaseDatabase.instance.ref('/reservations');
    // 2. Construct a query to fetch reservations for the given date.
    try {
      DatabaseEvent resEvent = await reservationsRef.orderByChild('day').equalTo(targetDate).once();
      var data = resEvent.snapshot.value;
      if (data != null) {
        List<Reservation?> resList = (data as Map).entries.map((e) => Reservation.fromMapEntry(e)).toList();
        return resList;
      } else {
        print('No reservations found for $targetDate');
        return [];
      }
    } catch (e) {
      print('Error fetching reservations: $e');
    }

  }
}