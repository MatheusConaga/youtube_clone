import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart'; // Import necessário para manipular a interface do sistema

class VideoPlayerScreen extends StatefulWidget {
  final String videoId; // ID do vídeo do YouTube

  const VideoPlayerScreen({Key? key, required this.videoId}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Inicializando o controlador do YouTube
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId, // Define o ID do vídeo
      flags: const YoutubePlayerFlags(
        autoPlay: true, // Inicia o vídeo automaticamente
        mute: false, // Não mudo o vídeo
      ),
    );

    // Adicionando listener para monitorar mudanças no estado do vídeo
    _controller.addListener(() {
      if (_controller.value.isFullScreen) {
        // Oculta a barra de navegação e de status ao entrar em tela cheia
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
      } else {
        // Restaura a barra de navegação e de status ao sair da tela cheia
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      }
    });
  }

  @override
  void dispose() {
    // Libere o controlador ao descartar o widget
    _controller.dispose();
    // Restaura a barra de navegação e de status ao fechar o player
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reprodutor de Vídeo'),
      ),
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
      ),
    );
  }
}