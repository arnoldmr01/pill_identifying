import 'package:clock_app/constants/theme_data.dart';
import 'package:clock_app/enums.dart';
import 'information/alarm_info.dart';
import 'information/menu_info.dart';

List<MenuInfo> menuItems = [
  MenuInfo(MenuType.clock,
      title: '時鐘', imageSource: 'assets/clock_icon.png'),
  MenuInfo(MenuType.alarm,
      title: '提醒', imageSource: 'assets/alarm_icon.png'),
  MenuInfo(MenuType.info,
      title: '藥品資訊', imageSource: 'assets/timer_icon.png'),
  MenuInfo(MenuType.detect,
      title: '藥物辨識', imageSource: 'assets/stopwatch_icon.png'),

];

List<AlarmInfo> alarms = [
  AlarmInfo(
      alarmDateTime: DateTime.now().add(Duration(hours: 1)),
      title: 'Office',
      gradientColorIndex: 0),
  AlarmInfo(
      alarmDateTime: DateTime.now().add(Duration(hours: 2)),
      title: 'Sport',
      gradientColorIndex: 1),
];
