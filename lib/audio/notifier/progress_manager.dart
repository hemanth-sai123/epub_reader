import 'dart:io';

import 'package:archive/archive.dart';
import 'package:epub_reader/audio/notifier/play_button_notifier.dart';
import 'package:epub_reader/audio/notifier/progress_notifier.dart';
import 'package:epub_reader/audio/notifier/repeat_button_notifier.dart';
import 'package:flutter/material.dart';

import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';


class PageManager {
  final currentSongTitleNotifier = ValueNotifier<String>('');
  final playlistNotifier = ValueNotifier<List<String>>([]);
  final progressNotifier = ProgressNotifier();
  final repeatButtonNotifier = RepeatButtonNotifier();
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final playButtonNotifier = PlayButtonNotifier();
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);

  late AudioPlayer _audioPlayer;
  late ConcatenatingAudioSource _playlist;

  PageManager(bookName) {
    _init(bookName);
  }

  void _init(bookName) async {
    _audioPlayer = AudioPlayer();
    _setInitialPlaylist(bookName);
    _listenForChangesInPlayerState();
    _listenForChangesInPlayerPosition();
    _listenForChangesInBufferedPosition();
    _listenForChangesInTotalDuration();
    _listenForChangesInSequenceState();
  }
  var _tempImages =[];
  unarchiveAndSave(var zippedFile, Directory dir1) async {
    try{
      _playlist=ConcatenatingAudioSource(children:[]);
      await _audioPlayer.setAudioSource(_playlist);
      var bytes = zippedFile.readAsBytesSync();
      var archive = ZipDecoder().decodeBytes(bytes);
      for (var file in archive) {
        var fileName = '${dir1.path}${file.name}';

        if (file.isFile) {
          var outFile = File(fileName);
          //print('File:: ' + outFile.path);
          String path = outFile.path;
          if(path.endsWith('.mp3'))
            _playlist.add(AudioSource.uri(outFile.uri, tag: 'Song ${file.name}'));
          //_tempImages.add(outFile.path);


          outFile = await outFile.create(recursive: true);
          await outFile.writeAsBytes(file.content);
        }
      }
      print("dkskldklklskldsklkls "+_tempImages.toString());
    }
    catch(e){

    }
  }

  Future<void> getFiles(bookName)async{

    try{

      var tempDir = await getTemporaryDirectory();
      Directory? appDocDir = Platform.isAndroid ? await getExternalStorageDirectory() : await getApplicationDocumentsDirectory();
      Directory? appDocDir1 = await getTemporaryDirectory();
      //
      Directory dir1 = Directory('${appDocDir1?.path}');
      String path = appDocDir!.path + '/${bookName}.zip';
      //
      final zipFile = File(path);
      unarchiveAndSave(zipFile,dir1);
         // final destinationDir = appDocDir;
         // try {
         //   await ZipFile.extractToDirectory(
         //       zipFile: zipFile,
         //       destinationDir:dir1,
         //       onExtracting: (zipEntry, progress) {
         //         print('progress: ${progress.toStringAsFixed(1)}%');
         //         print('name: ${zipEntry.name}');
         //         print('isDirectory: ${zipEntry.isDirectory}');
         //         print(
         //             'modificationDate: ${zipEntry.modificationDate?.toLocal().toIso8601String()}');
         //         print('uncompressedSize: ${zipEntry.uncompressedSize}');
         //         print('compressedSize: ${zipEntry.compressedSize}');
         //         print('compressionMethod: ${zipEntry.compressionMethod}');
         //         print('crc: ${zipEntry.crc}');
         //         return ZipFileOperation.includeItem;
         //       }).then((value) async{
         //
         //     //
         //     //
         //     // print("filessinthese1 ");
         //     Directory? appDocDir = Platform.isAndroid ? await getExternalStorageDirectory() : await getApplicationDocumentsDirectory();
         //     // print("filessinthese1 ");
         //     // var directory = appDocDir!.path;
         //     //
         //
         //      //Directory dir = Directory('${appDocDir.path}/OKHAAHARAN/');
         //     Directory dir = Directory('${dir1.path}${bookName}');
         //     //String mp3Path = dir.toString();
         //     print(dir);
         //     List<FileSystemEntity> _files;
         //     List<FileSystemEntity> _songs = [];
         //     _files = dir.listSync();
         //     for(FileSystemEntity entity in _files) {
         //       String path = entity.path;
         //       if(path.endsWith('.mp3'))
         //         _songs.add(entity);
         //     }
         //     print(_songs);
         //     print("jdsjkjdsjkdsjkjksdlemdg "+_songs.length.toString());
         //     List<AudioSource> list =[];
         //     for(int i=0;i<_songs.length;i++){
         //       list.add(AudioSource.file(_songs[i].path,tag:_songs[i].path.split('/').last));
         //     }
         //     _playlist=ConcatenatingAudioSource(children:list);
         //     await _audioPlayer.setAudioSource(_playlist);
         //
         //   });
         // } catch (e) {
         //   print(e);
         // }

    }catch(e){
      print("l;sdldlsldsl;l;dsl;l;dsl;lds;l;dsl;lds; "+e.toString());
    }

  }
  void _setInitialPlaylist(bookName) async {
    const prefix = 'https://www.soundhelix.com/examples/mp3';
    final song1 = Uri.parse('$prefix/SoundHelix-Song-1.mp3');
    final song2 = Uri.parse('$prefix/SoundHelix-Song-2.mp3');
    final song3 = Uri.parse('$prefix/SoundHelix-Song-3.mp3');

    // _playlist = ConcatenatingAudioSource(children: [
    //   AudioSource.file(filePath,tag: ""),
    //   AudioSource.uri(song1, tag: 'Song 1'),
    //   AudioSource.uri(song2, tag: 'Song 2'),
    //   AudioSource.uri(song3, tag: 'Song 3'),
    // ]);
    await getFiles(bookName);

  }

  void _listenForChangesInPlayerState() {
    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
      }
    });
  }

  void _listenForChangesInPlayerPosition() {
    _audioPlayer.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _listenForChangesInBufferedPosition() {
    _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });
  }

  void _listenForChangesInTotalDuration() {
    _audioPlayer.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
  }

  void _listenForChangesInSequenceState() {
    _audioPlayer.sequenceStateStream.listen((sequenceState) {
      if (sequenceState == null) return;

      // update current song title
      final currentItem = sequenceState.currentSource;
      final title = currentItem?.tag as String?;
      currentSongTitleNotifier.value = title ?? '';

      // update playlist
      final playlist = sequenceState.effectiveSequence;
      final titles = playlist.map((item) => item.tag as String).toList();
      playlistNotifier.value = titles;

      // update shuffle mode
      isShuffleModeEnabledNotifier.value = sequenceState.shuffleModeEnabled;

      // update previous and next buttons
      if (playlist.isEmpty || currentItem == null) {
        isFirstSongNotifier.value = true;
        isLastSongNotifier.value = true;
      } else {
        isFirstSongNotifier.value = playlist.first == currentItem;
        isLastSongNotifier.value = playlist.last == currentItem;
      }
    });
  }

  void play() async {
    _audioPlayer.play();
  }

  void pause() {
    _audioPlayer.pause();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  void dispose() {
    _audioPlayer.dispose();
  }

  void onRepeatButtonPressed() {
    repeatButtonNotifier.nextState();
    switch (repeatButtonNotifier.value) {
      case RepeatState.off:
        _audioPlayer.setLoopMode(LoopMode.off);
        break;
      case RepeatState.repeatSong:
        _audioPlayer.setLoopMode(LoopMode.one);
        break;
      case RepeatState.repeatPlaylist:
        _audioPlayer.setLoopMode(LoopMode.all);
    }
  }

  void onPreviousSongButtonPressed() {
    _audioPlayer.seekToPrevious();
  }

  void onNextSongButtonPressed() {
    _audioPlayer.seekToNext();
  }

  void onShuffleButtonPressed() async {
    final enable = !_audioPlayer.shuffleModeEnabled;
    if (enable) {
      await _audioPlayer.shuffle();
    }
    await _audioPlayer.setShuffleModeEnabled(enable);
  }

  void addSong(String song1) {
    // final songNumber = _playlist.length + 1;
    // const prefix = 'https://www.soundhelix.com/examples/mp3';
    // final song = Uri.parse('$prefix/SoundHelix-Song-$songNumber.mp3');
    // _playlist.add(AudioSource.uri(song, tag: 'Song $songNumber'));
   // final songNumber = _playlist.length + 1;
  ///  const prefix = 'https://www.soundhelix.com/examples/mp3';
    final song = Uri.parse('$song1');
    _playlist.add(AudioSource.uri(song, tag: 'Song'));
  }

  void removeSong() {
    // final index = _playlist.length - 1;
    // if (index < 0) return;
    // _playlist.removeAt(index);
  }
}