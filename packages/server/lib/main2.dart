import 'dart:convert';

import 'package:kahootify_server/models/player_info.dart';
import 'package:web_socket_channel/io.dart';

// Test player
main() async {
  var socket = IOWebSocketChannel.connect("ws://localhost:6666/");

  PlayerInfo playerInfo = PlayerInfo(id: 1, name: "Artur");

  socket.sink.add(jsonEncode(playerInfo.toJson()));
  socket.stream.listen((event) {
    print(event);
  });

  while (socket.stream.isBroadcast) {
    await Future.delayed(Duration(seconds: 10)).then((value) => socket.sink.add(jsonEncode(PlayerInfo(id: 1, name: "CC").toJson())));
  }
}
