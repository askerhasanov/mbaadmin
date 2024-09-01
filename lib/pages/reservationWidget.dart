import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/reservationProvider.dart';

class ReservationWidget extends StatelessWidget {
  const ReservationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReservationProvider(),
      child: ReservationList(),
    );
  }
}

class ReservationList extends StatelessWidget {
  const ReservationList({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ReservationProvider>(context);

    return Column(
      children: [
        DateNavigation(
          selectedDate: provider.selectedDate,
          onDateChanged: (date) => provider.setSelectedDate(date),
        ),
        ListView.builder(
          itemCount: provider.rows.length, // Number of time slot rows (9:00 to 21:00)
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Text('${provider.rows[index]!.time}'),
                ),
                Expanded(
                  child: Row(
                    children: [
                      ReservationSlot(row: provider.rows[index], index: 0,),
                      ReservationSlot(row: provider.rows[index], index: 1,),
                      ReservationSlot(row: provider.rows[index], index: 2,),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class DateNavigation extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;

  const DateNavigation({super.key, required this.selectedDate, required this.onDateChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => onDateChanged(selectedDate.subtract(const Duration(days: 1))),
          icon: const Icon(Icons.arrow_left),
        ),
        Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
        IconButton(
          onPressed: () => onDateChanged(selectedDate.add(const Duration(days: 1))),
          icon: const Icon(Icons.arrow_right),
        ),
      ],
    );
  }
}

class ReservationSlot extends StatelessWidget {
  final ReservationRow? row;
  final int index;
  const ReservationSlot({super.key, this.row, required this.index});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          // Handle slot tap
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: row?.reservations != null && index < row!.reservations!.length && row!.reservations![index] != null
                  ? Text('${row!.reservations![index]!.studentId}\n${row!.reservations![index]!.courseId}', textAlign: TextAlign.center,)
                  : Text('empty')
          ),
        ),
      ),
    );
  }
}