import 'package:flutter/cupertino.dart';
import 'package:mbaadmin/helpers/dayLessonHelper.dart';
import '../reservation.dart';

class ReservationRow{
  String time;
  late final List<Reservation?>? reservations;
  ReservationRow({ required this.time, this.reservations});
}

class ReservationProvider extends ChangeNotifier {
  DateTime _selectedDate = DateTime.now();

  List<ReservationRow?> _rows = [];

  DateTime get selectedDate => _selectedDate;

  List<ReservationRow?> get rows => _rows;

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    loadReservations();
    notifyListeners(); // Update widgets that depend on this data
  }


  List<ReservationRow> createEmptyRows(){
    List<ReservationRow> createdRows = [];
    for (int i = 0; i < 13; i++) {
      List<Reservation?>? list = [];
      String? time;
      for (int j = 0; j < 3; j++) {
        final hour = (i+9).toString().padLeft(2, '0');
        const minute = '00'; // Adjust for different minute slots
        time = '$hour:$minute';
        list.add(null);
      }
      createdRows.add(ReservationRow(time: time!, reservations: list ));
      list = [];
      time = null;
    }
    return createdRows;
  }


  final  _db = DayLessonHelper(); // Your database service instance


  Future<void> loadReservations() async {
    try {
      final dbReservations = await _db.getReservations(_selectedDate);
      _rows = _generateTimeSlots(dbReservations);
      notifyListeners();
    } catch (e) {
      // Handle errors (e.g., show a snackbar)
      print('Error loading reservations: $e');
    }
  }


  List<ReservationRow> _generateTimeSlots(List<Reservation?>? resvations) {
    final rows = createEmptyRows();

    if (resvations != null) { // Add null check for reservations
      for (var res in resvations) {
        if (res != null) { // Add null check for res
          var index = rows.indexWhere((r) => r.time == res.time);
          if (index != -1) { // Check if index is valid
            var list = rows[index].reservations;
            var emptyIndex = list!.indexWhere((elem) => elem == null);
            if (emptyIndex != -1) { // Check if empty slot exists
              list[emptyIndex] = res;
            }
          }
        }
      }
    }
    return rows;
  }


}