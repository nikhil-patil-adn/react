import 'package:fellowfarmer/api/api.dart';
import 'package:fellowfarmer/pages/footer.dart';
import 'package:fellowfarmer/pages/myaccount_page.dart';
import 'package:fellowfarmer/widgets/customwidget.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderPage extends StatefulWidget {
  @override
  _CalenderPageState createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  DateTime datedry = DateTime.now();
  List meetings = [];
  String custid = "";
  List newdata = [];
  @override
  void initState() {
    super.initState();
    getLoggedincustomerdata();
    //
  }

  getLoggedincustomerdata() {
    var obj = new Api();
    obj.getLoggedincustomerdata().then((val) {
      setState(() {
        custid = val[0]['id'].toString();
        print(custid);
        print("log");
        delivery(custid);
      });
    });
  }

  delivery(custid) {
    var obj = new Api();
    obj.getdelivery(custid).then((val) {
      setState(() {
        newdata = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: lineargradientbg(),
        title: Text("Delivery Calender"),
      ),
      bottomNavigationBar: FooterPage(pageindex: 1),
      endDrawer: MyaccountPage(),
      body: SfCalendar(
        view: CalendarView.month,
        monthViewSettings: MonthViewSettings(showAgenda: true),
        firstDayOfWeek: 1,
        //selectionDecoration: BoxDecoration(color: Colors.red),
        // initialDisplayDate: DateTime(2021, 07, 09, 08, 30),
        // initialSelectedDate: DateTime(2021, 07, 08, 09, 00),
        dataSource: MeetingDataSource(getAppointments(newdata)),
      ),
    );
  }
}

List<Appointment> getAppointments(List newdeliverydata) {
  List<Appointment> meetings = <Appointment>[];

  for (int i = 0; i < newdeliverydata.length; i++) {
    final datedry =
        DateTime.tryParse(newdeliverydata[i]['schedule_delivery_date'])!;

    final startTime =
        DateTime(datedry.year, datedry.month, datedry.day, 9, 0, 0);

    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Appointment(
        startTime: startTime,
        endTime: endTime,
        subject: "Delivery ",
        color: Colors.red,
        startTimeZone: '',
        endTimeZone: '',
        recurrenceRule: 'FREQ=DAILY;COUNT=1',
        isAllDay: true));
  }

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
