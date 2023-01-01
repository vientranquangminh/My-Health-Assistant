class NotificationObject {
  final String title;
  final String date;
  final String time;
  NotificationObject(
      {required this.title, required this.date, required this.time});
}

List<NotificationObject> listNotification = [
  NotificationObject(
      title: 'Have An Appoinment', date: '20 Oc. 2022', time: '14:00'),
  NotificationObject(
      title: 'Appoinment Cancelled', date: 'Today', time: '15:00'),
  NotificationObject(title: 'Have An Appoinment', date: 'Today', time: '9:00'),
];
