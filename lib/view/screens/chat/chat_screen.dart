// chat_page.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lettutor/data/network/apis/chat/chat_apis.dart';
import 'package:lettutor/data/provider/is_auto_tts.dart';
import 'package:lettutor/data/provider/speech_language.dart';
import 'package:lettutor/data/shared_preference/constants/shared_preference_keys.dart';
import 'package:lettutor/models/chat_message.dart';
import 'package:lettutor/view/screens/chat/components/message_bubble.dart';
import 'package:lettutor/view/screens/chat/components/message_compose.dart';
import 'package:lettutor/view/screens/chat/setting_screen.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
  });

  static _ChatPageState? of(BuildContext context) =>
      context.findAncestorStateOfType<_ChatPageState>();
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with WidgetsBindingObserver {
  // var _messages = <ChatMessage>[
  //   // ChatMessage('Hello, how can I help?', false),
  // ];
  final ChatApi chatApi = ChatApi();
  List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();
  List<bool> isPlayingList = [];
  bool isHavingNewMessage = false;
  // late InterstitialAd _interstitialAd;
  bool _isInterstitialAdReady = false;

  void playAtIndex(int index) {
    setState(() {
      for (int i = 0; i < isPlayingList.length; ++i) {
        if (index == i) {
          isPlayingList[index] = true;
        } else {
          isPlayingList[i] = false;
        }
      }
    });
  }

  void allStop() {
    setState(() {
      for (int i = 0; i < isPlayingList.length; ++i) {
        isPlayingList[i] = false;
      }
    });
  }

  @override
  void initState() {
    print('init state');
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loadMessages().then((loadedMessages) {
      setState(() {
        _messages = loadedMessages;
        var fixedList = List.filled(loadedMessages.length, false);
        isPlayingList = List.from(fixedList);
        print('load message');
      });
    });
    // _createInterstitialAd();

    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  // void _createInterstitialAd() {
  //   InterstitialAd.load(
  //     adUnitId: "ca-app-pub-3940256099942544/1033173712",
  //     request: AdRequest(),
  //     adLoadCallback: InterstitialAdLoadCallback(
  //       onAdLoaded: (ad) {
  //         setState(() {
  //           // _interstitialAd = ad;
  //           _isInterstitialAdReady = true;
  //         });
  //       },
  //       onAdFailedToLoad: (error) {
  //         print('InterstitialAd failed to load: $error');
  //       },
  //     ),
  //   );
  // }

  // void _showInterstitialAd() {
  //   if (_isInterstitialAdReady) {
  //     // _interstitialAd.show();
  //     _isInterstitialAdReady = false;
  //     _createInterstitialAd();
  //   } else {
  //     print('Interstitial ad is not ready yet.');
  //   }
  // }

  var _awaitingResponse = false;

  Future<void> saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _messages.map((message) => jsonEncode(message)).toList();
    await prefs.setStringList(SharedPreferenceKeys.messages, jsonList);
  }

  Future<List<ChatMessage>> loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(SharedPreferenceKeys.messages) ?? [];
    final messages =
        jsonList.map((json) => ChatMessage.fromJson(jsonDecode(json))).toList();
    return messages;
  }

  void _scrollToBottom() async {
    print("scrolled");
    await Future.delayed(Duration(milliseconds: 100));
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _onSubmitted(String message) async {
    setState(() {
      _messages.add(ChatMessage(content: message, isUserMessage: true));
      isPlayingList.add(false);
      _awaitingResponse = true;
    });
    _scrollToBottom();
    try {
      final response;
      if (_messages.length < 6) {
        response = await chatApi.completeChat(_messages);
      } else {
        response =
            await chatApi.completeChat(_messages.sublist(_messages.length - 5));
      }
      setState(() {
        _messages.add(ChatMessage(content: response, isUserMessage: false));
        isPlayingList.add(false);
        _awaitingResponse = false;
        isHavingNewMessage = true;
        // print("ads ${_messages.length}");
        // if (_messages.length % 4 == 0) {
        //   print("it's ads time");
        //   _showInterstitialAd();
        // }
      });
      _scrollToBottom();
    } catch (err) {
      print(err);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Please try again.')),
      );
      setState(() {
        _awaitingResponse = false;
      });
    }
  }

  void deleteMessages() {
    print("delete messages of chat screen");
    setState(() {
      _messages.clear();
      isPlayingList.clear();
    });
  }

  @override
  void dispose() {
    print('dispose');
    saveMessages();
    print('save message');

    WidgetsBinding.instance.removeObserver(this);
    // _interstitialAd.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('did change app');
    saveMessages();
    print('save message');
  }

  @override
  Widget build(BuildContext context) {
    SpeechLanguageProfile speechLanguageProfile =
        Provider.of<SpeechLanguageProfile>(context);
    AutoTTSProfile autoTTSProfile = Provider.of<AutoTTSProfile>(context);
    // if (autoTTSProfile.autoTTS == true) {
    //   isPlayingList[isPlayingList.length - 1] = true;
    // }

    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: const Text('Chat'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              ).then((result) {
                // Handle result from second page
                if (result == true) {
                  setState(() {
                    print("delete and refreshui");
                    _messages.clear();
                  });
                }
              });
              null;
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              controller: _scrollController,
              children: [
                ..._messages.map((msg) {
                  return MessageBubble(
                    content: msg.content,
                    isUserMessage: msg.isUserMessage,
                    languageCode: speechLanguageProfile.speechLanguageCode,
                    isAutoRead: _messages.indexOf(msg) == _messages.length - 1
                        ? autoTTSProfile.autoTTS
                        : false,
                    isPlayingList: isPlayingList,
                    index: _messages.indexOf(msg),
                    playAtIndex: playAtIndex,
                    stopAll: allStop,
                    isHavingNewMessage: isHavingNewMessage,
                  );
                }),
              ],
            ),
          ),
          MessageComposer(
            onSubmitted: _onSubmitted,
            awaitingResponse: _awaitingResponse,
          ),
        ],
      ),
    );
  }
}
