// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class TimeInfo extends Equatable {
  String abbreviation;
  String clientIp;
  String datetime;
  int dayOfWeek;
  int dayOfYear;
  bool dst;
  String dstFrom;
  int dstOffset;
  String dstUntil;
  int rawOffset;
  String timezone;
  int unixtime;
  String utcDatetime;
  String utcOffset;
  int weekNumber;

  TimeInfo(
      {required this.abbreviation,
      required this.clientIp,
      required this.datetime,
      required this.dayOfWeek,
      required this.dayOfYear,
      required this.dst,
      required this.dstFrom,
      required this.dstOffset,
      required this.dstUntil,
      required this.rawOffset,
      required this.timezone,
      required this.unixtime,
      required this.utcDatetime,
      required this.utcOffset,
      required this.weekNumber});

  static TimeInfo fromJson(Map<String, dynamic> json) {
    final timeInfo = TimeInfo(
        abbreviation: json['abbreviation'],
        clientIp: json['client_ip'],
        datetime: json['datetime'],
        dayOfWeek: json['day_of_week'],
        dayOfYear: json['day_of_year'],
        dst: json['dst'],
        dstFrom: json['dst_from'],
        dstOffset: json['dst_offset'],
        dstUntil: json['dst_until'],
        rawOffset: json['raw_offset'],
        timezone: json['timezone'],
        unixtime: json['unixtime'],
        utcDatetime: json['utc_datetime'],
        utcOffset: json['utc_offset'],
        weekNumber: json['week_number']);

    return timeInfo;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['abbreviation'] = abbreviation;
    data['client_ip'] = clientIp;
    data['datetime'] = datetime;
    data['day_of_week'] = dayOfWeek;
    data['day_of_year'] = dayOfYear;
    data['dst'] = dst;
    data['dst_from'] = dstFrom;
    data['dst_offset'] = dstOffset;
    data['dst_until'] = dstUntil;
    data['raw_offset'] = rawOffset;
    data['timezone'] = timezone;
    data['unixtime'] = unixtime;
    data['utc_datetime'] = utcDatetime;
    data['utc_offset'] = utcOffset;
    data['week_number'] = weekNumber;
    return data;
  }

  @override
  List<Object> get props => [abbreviation, timezone];
}
