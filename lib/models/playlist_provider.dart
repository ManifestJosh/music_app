import 'package:flutter/material.dart';
import 'package:music_app/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(
        songName: "Bad energy",
        artistName: "Skepta and Wizkid",
        albumArtImagePath: "assets/images/images (16).jpeg",
        audiopath: "assets/audio/01 Skepta - Energy (Stay Far Away).mp3"),
    Song(
        songName: "Bloody Samarithan",
        artistName: "Ayra Starr",
        albumArtImagePath: "assets/images/FcyxoSIXgAAL9ZZ.jfif",
        audiopath:
            "assets/audio/Ayra Starr - Bloody Samaritan (NetNaija.com).mp3"),
  ];

  // current song playing index
  int? _currentSongIndex;

  /*
  
  Getters

  */

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;

  /*

  S E T T E R S

  */

  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    notifyListeners();
  }
}
