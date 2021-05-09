import 'package:kahootify_server/models/error_info.dart';
import 'package:kahootify_server/models/player_info.dart';
import 'package:kahootify_server/models/server_info.dart';
import 'package:kahootify_server/players/abstract_player.dart';
import 'package:kahootify_server/players/local_player.dart';
import 'package:kahootify_server/server.dart';
import 'package:kahootify_server/server_modes/game_mode.dart';
import 'package:kahootify_server/server_modes/server_mode.dart';

class LobbyMode extends ServerMode {
  LobbyMode(Server server) : super(server);

  @override
  ServerMode nextMode() {
    return GameMode(server);
  }

  @override
  void handlePlayerInfo(PlayerInfo playerInfo, AbstractPlayer player) {
    playerInfo.score = player.playerInfo.score;
    player.playerInfo = playerInfo;
    server.sendDataToAll(playerInfo.toJson());
  }

  @override
  void handleServerInfo(ServerInfo serverInfo, AbstractPlayer player) {
    if (player is LocalPlayer) {
      server.serverInfo = serverInfo;
      server.sendDataToAll(serverInfo.toJson());
    } else {
      player.send(ErrorInfo("No privileges for this operation"));
    }
  }
}
