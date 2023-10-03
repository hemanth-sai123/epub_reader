
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'notifier/play_button_notifier.dart';
import 'notifier/progress_manager.dart';
import 'notifier/progress_notifier.dart';
import 'notifier/repeat_button_notifier.dart';

class AudioMyDataPlayer extends StatefulWidget {
  @override
  _AudioMyDataPlayerState createState() => _AudioMyDataPlayerState();
}

// use GetIt or Provider rather than a global variable in a real project
 PageManager? _pageManager;
class _AudioMyDataPlayerState extends State<AudioMyDataPlayer> {
  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    _pageManager!.dispose();
    super.dispose();
  }
  bool state=true;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();


    if (state) {
      //setYourPath();
      var data = ModalRoute
          .of(context)
          ?.settings
          .arguments as Map<String,dynamic>;

      var bookName =data["bookTitle"];
     // var bookUrl =data["bookUrl"];


      _pageManager = PageManager(bookName);
      // if (isDownloads) {
      //   setValue();
      // } else {
      //   books = books1;
      // }



      setState(() {

      });
      state = false;
      // books1 =books1.where((element) =>
      //
      // await setYourPath(element.bookName)
      //
      // ).toList();
      // books1.forEach((String value) async {
      // //await setYourPath(value);
      // });
    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CurrentSongTitle(),
              Playlist(),
              AddRemoveSongButtons(),
              AudioProgressBar(),
              AudioControlButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class CurrentSongTitle extends StatelessWidget {
  const CurrentSongTitle({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: _pageManager!.currentSongTitleNotifier,
      builder: (_, title, __) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(title, style: TextStyle(fontSize: 40)),
        );
      },
    );
  }
}

class Playlist extends StatelessWidget {
  const Playlist({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<List<String>>(
        valueListenable: _pageManager!.playlistNotifier,
        builder: (context, playlistTitles, _) {
          return ListView.builder(
            itemCount: playlistTitles.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${playlistTitles[index]}'),
              );
            },
          );
        },
      ),
    );
  }
}

class AddRemoveSongButtons extends StatelessWidget {
  const AddRemoveSongButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(),
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: [
      //     FloatingActionButton(
      //       onPressed: _pageManager.addSong,
      //       child: Icon(Icons.add),
      //     ),
      //     FloatingActionButton(
      //       onPressed: _pageManager.removeSong,
      //       child: Icon(Icons.remove),
      //     ),
      //   ],
      // ),
    );
  }
}

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: _pageManager!.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          onSeek: _pageManager!.seek,
        );
      },
    );
  }
}


class AudioControlButtons extends StatelessWidget {

  const AudioControlButtons({Key? key}) : super(key: key);

  static addSongs(String song1){
    _pageManager!.addSong(song1);
  }

  @override
  Widget build(BuildContext context) {
    if(_pageManager==null)
      _pageManager=PageManager("bookName");
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RepeatButton(),
          PreviousSongButton(),
          PlayButton(),
          NextSongButton(),
          ShuffleButton(),
        ],
      ),
    );
  }
}

class RepeatButton extends StatelessWidget {
  const RepeatButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<RepeatState>(
      valueListenable: _pageManager!.repeatButtonNotifier,
      builder: (context, value, child) {
        Icon icon;
        switch (value) {
          case RepeatState.off:
            icon = Icon(Icons.repeat, color: Colors.white);
            break;
          case RepeatState.repeatSong:
            icon = Icon(Icons.repeat_one);
            break;
          case RepeatState.repeatPlaylist:
            icon = Icon(Icons.repeat);
            break;
        }
        return IconButton(
          icon: icon,
          onPressed: _pageManager!.onRepeatButtonPressed,
        );
      },
    );
  }
}

class PreviousSongButton extends StatelessWidget {
  const PreviousSongButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _pageManager!.isFirstSongNotifier,
      builder: (_, isFirst, __) {
        return IconButton(
          icon: Icon(Icons.skip_previous,color: Colors.white,),
          onPressed:
          (isFirst) ? null : _pageManager!.onPreviousSongButtonPressed,
        );
      },
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ButtonState>(
      valueListenable: _pageManager!.playButtonNotifier,
      builder: (_, value, __) {
        switch (value) {
          case ButtonState.loading:
            return Container(
              margin: EdgeInsets.all(8.0),
              width: 32.0,
              height: 32.0,
              child: CircularProgressIndicator(),
            );
          case ButtonState.paused:
            return IconButton(
              icon: Icon(Icons.play_arrow,color: Colors.white,),
              iconSize: 32.0,
              onPressed: _pageManager!.play,
            );
          case ButtonState.playing:
            return IconButton(
              icon: Icon(Icons.pause,color: Colors.white,),
              iconSize: 32.0,
              onPressed: _pageManager!.pause,
            );
        }
      },
    );
  }
}

class NextSongButton extends StatelessWidget {
  const NextSongButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _pageManager!.isLastSongNotifier,
      builder: (_, isLast, __) {
        return IconButton(
          icon: Icon(Icons.skip_next,color: Colors.white,),
          onPressed: (isLast) ? null : _pageManager!.onNextSongButtonPressed,
        );
      },
    );
  }
}

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _pageManager!.isShuffleModeEnabledNotifier,
      builder: (context, isEnabled, child) {
        return IconButton(
          icon: (isEnabled)
              ? Icon(Icons.shuffle,color: Colors.white,)
              : Icon(Icons.shuffle, color: Colors.grey),
          onPressed: _pageManager!.onShuffleButtonPressed,
        );
      },
    );
  }
}