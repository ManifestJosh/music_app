import 'package:flutter/material.dart';
import 'package:music_app/models/song.dart';
import 'package:audioplayers/audioplayers.dart';

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

  A U D I O P L A Y E R

  */
  // audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  //duration
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  //constructor
  PlaylistProvider() {
    listenToDuration();
  }
  //initially not playing
  bool _isplaying = false;

  // play the song
  void play() async {
    final String path = _playlist[_currentSongIndex!].audiopath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isplaying = true;
    notifyListeners();
  }

  // pause current song
  void pause() async {
    await _audioPlayer.pause();
    _isplaying = true;
    notifyListeners();
  }

  // resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isplaying = true;
    notifyListeners();
  }

  //pause or resume
  void pauseOrResume() async {
    if (_isplaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  // seek to a specific position in the current song
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        // go to the next song if it's not the last song
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        // if it is the last song , loop back to the first song
        currentSongIndex = 0;
      }
    }
  }

  // play previous song
  void playPreviousSong() async {
    if (_currentDuration.inSeconds > 5) {
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  //listen to duration
  void listenToDuration() {
    //listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    // listen for current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    // listen for song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }
  /*
  
  Getters

  */

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isplaying => _isplaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  /*

  S E T T E R S

  */

  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      play(); //play the song at the new index
    }

    notifyListeners();
  }
}
