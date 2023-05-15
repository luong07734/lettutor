import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:lettutor/models/schedule.dart';
import 'package:flutter/material.dart';

Timer? _timer;

Future joinMeeting(ScheduleRowItem schedule) async {
  try {
    String? token = schedule.studentMeetingLink?.substring(13);
    dynamic roomId = json.decode(decodeBase64(token!.split(".")[1]))["room"];
    String serverUrl = "https://meet.lettutor.com";
    bool shouldDisplayToast = true;

    Map<FeatureFlag, Object> featureFlags = {};

    // Define meetings options here
    var options = JitsiMeetingOptions(
      roomNameOrUrl: roomId,
      serverUrl: serverUrl,
      subject: "Letutor Meeting",
      token: token,
      isAudioMuted: true,
      isAudioOnly: false,
      isVideoMuted: true,
      userDisplayName: "Temp User",
      userEmail: "tempUser@gmail.com",
      featureFlags: featureFlags,
    );

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      String strTimeUntil = getUntilTime(DateTime.fromMillisecondsSinceEpoch(
          schedule.scheduleDetailInfo!.startPeriodTimestamp!));

      if (schedule.scheduleDetailInfo!.startPeriodTimestamp! <=
          DateTime.now().millisecondsSinceEpoch) {
        timer.cancel();
      } else if (shouldDisplayToast && _timer != null) {
        print("should display $shouldDisplayToast");
        Fluttertoast.showToast(
            msg:
                "$strTimeUntil\n ultil lesson start (${DateFormat("HH:mm, dd - MM - yyyy").format(DateTime.fromMillisecondsSinceEpoch(schedule.scheduleDetailInfo!.startPeriodTimestamp!))})",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            timeInSecForIosWeb: 1,
            fontSize: 12.0);
        // timer.cancel();
        // print(
        //     "$strTimeUntil\n ultil lesson start (${DateFormat("HH:mm, dd - MM - yyyy").format(DateTime.fromMillisecondsSinceEpoch(schedule.scheduleDetailInfo!.startPeriodTimestamp!))})");
      }
    });

    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeetWrapper.joinMeeting(
      options: options,
      listener: JitsiMeetingListener(
          onOpened: () => debugPrint("onOpened"),
          onConferenceWillJoin: (url) {
            debugPrint("onConferenceWillJoin: url: $url");
          },
          onConferenceJoined: (url) {
            debugPrint("onConferenceJoined: url: $url");
          },
          onConferenceTerminated: (url, error) {
            shouldDisplayToast = false;
            Fluttertoast.cancel();
            if (_timer != null) {
              _timer!.cancel();
              // _timer = null;
            }
            debugPrint("onConferenceTerminated: url: $url, error: $error");
          },
          onAudioMutedChanged: (isMuted) {
            debugPrint("onAudioMutedChanged: isMuted: $isMuted");
          },
          onVideoMutedChanged: (isMuted) {
            debugPrint("onVideoMutedChanged: isMuted: $isMuted");
          },
          onScreenShareToggled: (participantId, isSharing) {
            debugPrint(
              "onScreenShareToggled: participantId: $participantId, "
              "isSharing: $isSharing",
            );
          },
          onParticipantJoined: (email, name, role, participantId) {
            debugPrint(
              "onParticipantJoined: email: $email, name: $name, role: $role, "
              "participantId: $participantId",
            );
          },
          onParticipantLeft: (participantId) {
            debugPrint("onParticipantLeft: participantId: $participantId");
          },
          onParticipantsInfoRetrieved: (participantsInfo, requestId) {
            debugPrint(
              "onParticipantsInfoRetrieved: participantsInfo: $participantsInfo, "
              "requestId: $requestId",
            );
          },
          onChatMessageReceived: (senderId, message, isPrivate) {
            debugPrint(
              "onChatMessageReceived: senderId: $senderId, message: $message, "
              "isPrivate: $isPrivate",
            );
          },
          onChatToggled: (isOpen) =>
              debugPrint("onChatToggled: isOpen: $isOpen"),
          onClosed: () {
            shouldDisplayToast = false;
            Fluttertoast.cancel();

            print("timer $_timer");
            if (_timer != null) {
              _timer!.cancel();
              // _timer = null;
            }
            debugPrint("onClosed");
          }),
    );
  } catch (error) {
    print("error: $error");
    Fluttertoast.cancel();

    if (_timer != null) {
      _timer!.cancel();
      // _timer = null;
    }
  }
}

String decodeBase64(String toDecode) {
  String res;
  try {
    while (toDecode.length * 6 % 8 != 0) {
      toDecode += "=";
    }
    res = utf8.decode(base64.decode(toDecode));
  } catch (error) {
    throw Exception("decodeBase64([toDecode=$toDecode]) \n\t\terror: $error");
  }
  return res;
}

String getUntilTime(DateTime time) {
  final now = DateTime.now();
  final difference = time.difference(now);
  final days = difference.inDays;
  final hours = difference.inHours - days * 24;
  final minutes = difference.inMinutes - days * 24 * 60 - hours * 60;
  final seconds = difference.inSeconds -
      days * 24 * 60 * 60 -
      hours * 60 * 60 -
      minutes * 60;
  return "$days days $hours hours $minutes minutes $seconds seconds";
}

void joinJitsiMeet(BuildContext context, ScheduleRowItem schedule) async {
  await joinMeeting(schedule);
}
