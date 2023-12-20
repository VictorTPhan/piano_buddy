import 'dart:convert';

import 'package:http/http.dart';

enum PianoPlay {first, second, both}

/// given a value of PianoPlay (primo, secondo, or both), returns a display string.
String pianoPlayString(PianoPlay p)
{
  switch (p)
  {
    case PianoPlay.first: return "1st Piano";
    case PianoPlay.second: return "2nd Piano";
    case PianoPlay.both: return "Both";
  }
}

class Mode {
  PianoPlay piano;
  String pdfPath;
  String audioPath;
  List<double> turnTimeStamps;
  List<int> turnPages;

  Mode({required this.piano, required this.pdfPath, required this.audioPath, required this.turnTimeStamps, required this.turnPages}) {
    print("Piano: $piano");
    print("PDF Link: $pdfPath");
    print("Audio Link: $audioPath");
    print("Turn Times: $turnTimeStamps");
    print("Turn Pages: $turnPages");
  }
}

class Song{
  String songName;
  String composer;
  List<Mode> modes;

  Song({required this.songName, required this.composer, required this.modes});

  /// Creates a song object automatically given the song name, composer, 3 PDF links, and 3 audio links.
  /// Links provided should be download URLs for the respective files.
  static Song fromLinks({required String songName, required String composer,
    required List<double> primoTimeStamps, required List<int> primoTurnpages,
    required List<double> secondoTimeStamps, required List<int> secondoTurnPages,
    required List<double> bothTimeStamps, required List<int> bothTurnpages})
  {
    print(songName);
    Song s = Song(songName: songName, composer: composer, modes: []);
    s.modes = [
      Mode(
        piano: PianoPlay.first,
        pdfPath: songName + " primo pdf.pdf",
        audioPath: songName + " primo audio.mp3",
        turnTimeStamps: primoTimeStamps,
        turnPages: primoTurnpages
      ),
      Mode(
        piano: PianoPlay.second,
        pdfPath: songName + " secondo pdf.pdf",
        audioPath: songName + " secondo audio.mp3",
        turnTimeStamps: secondoTimeStamps,
        turnPages: secondoTurnPages
      ),
      Mode(
        piano: PianoPlay.both,
        pdfPath: songName + " both pdf.pdf",
        audioPath: songName + " both audio.mp3",
        turnTimeStamps: bothTimeStamps,
        turnPages: bothTurnpages
      ),
    ];
    return s;
  }
}

Future<void> getSongDictionary() async {
  songDictionary.clear();
  // const String REQUEST_URL = "https://MasterSongList.bigphan.repl.co";
  // var response = await get(Uri.parse(REQUEST_URL));
  // var responseData = jsonDecode(response.body);

  var jsonString = """{
    "Concert": {
      "both": {
        "turnPages": [
          1,
          1,
          1,
          -1,
          1,
          -3,
          5
        ],
        "turnTimeStamps": [
          46.97,
          102.36,
          135.04,
          152.83,
          165.71,
          184.98,
          208.62
        ]
      },
      "composer": "Amadeus Mozart",
      "name": "Concert",
      "primo": {
        "turnPages": [
          1,
          1,
          1,
          -1,
          1,
          -3,
          5
        ],
        "turnTimeStamps": [
          46.97,
          102.36,
          135.04,
          152.83,
          165.71,
          184.98,
          208.62
        ]
      },
      "secondo": {
        "turnPages": [
          1,
          1,
          1,
          -1,
          1,
          -3,
          5
        ],
        "turnTimeStamps": [
          46.97,
          102.36,
          135.04,
          152.83,
          165.71,
          184.98,
          208.62
        ]
      }
    },
    "Concerto": {
      "both": {
        "turnPages": [
          1,
          1,
          1,
          -1,
          1,
          -3,
          5
        ],
        "turnTimeStamps": [
          46.97,
          102.36,
          135.04,
          152.83,
          165.61,
          184.98,
          208.62
        ]
      },
      "composer": "Billy Joel",
      "name": "Concerto",
      "primo": {
        "turnPages": [
          1,
          1,
          1,
          -1,
          1,
          -3,
          5
        ],
        "turnTimeStamps": [
          46.97,
          102.36,
          135.04,
          152.83,
          165.61,
          184.98,
          208.62
        ]
      },
      "secondo": {
        "turnPages": [
          1,
          1,
          1,
          -1,
          1,
          -3,
          5
        ],
        "turnTimeStamps": [
          46.97,
          102.36,
          135.04,
          152.83,
          165.61,
          184.98,
          208.62
        ]
      }
    },
    "Easy piano duet": {
      "both": {
        "turnPages": [
          1,
          1,
          1,
          -1,
          1,
          -3,
          5
        ],
        "turnTimeStamps": [
          46.97,
          102.36,
          135.04,
          152.83,
          165.61,
          184.98,
          208.62
        ]
      },
      "composer": "Lopez Calvo Gabriel Alejadro",
      "name": "Easy piano duet",
      "primo": {
        "turnPages": [
          1,
          1,
          1,
          -1,
          1,
          -3,
          5
        ],
        "turnTimeStamps": [
          46.97,
          102.36,
          135.04,
          152.83,
          165.61,
          184.98,
          208.62
        ]
      },
      "secondo": {
        "turnPages": [
          1,
          1,
          1,
          -1,
          1,
          -3,
          5
        ],
        "turnTimeStamps": [
          46.97,
          102.36,
          135.04,
          152.83,
          165.61,
          184.98,
          208.62
        ]
      }
    },
    "Menuet": {
      "both": {
        "turnPages": [
          1,
          1,
          1,
          -1,
          1,
          -3,
          5
        ],
        "turnTimeStamps": [
          46.97,
          102.36,
          135.04,
          152.83,
          165.71,
          184.98,
          208.62
        ]
      },
      "composer": "Amadeus Mozart",
      "name": "Menuet",
      "primo": {
        "turnPages": [
          1,
          1,
          1,
          -1,
          1,
          -3,
          5
        ],
        "turnTimeStamps": [
          46.97,
          102.36,
          135.04,
          152.83,
          165.71,
          184.98,
          208.62
        ]
      },
      "secondo": {
        "turnPages": [
          1,
          1,
          1,
          -1,
          1,
          -3,
          5
        ],
        "turnTimeStamps": [
          46.97,
          102.36,
          135.04,
          152.83,
          165.71,
          184.98,
          208.62
        ]
      }
    },
    "Miniature concerto": {
      "both": {
        "turnPages": [
          1,
          1,
          1,
          1,
          1,
          1,
          1,
          1
        ],
        "turnTimeStamps": [
          24.11,
          58.44,
          63.54,
          91.15,
          113.06,
          140.96,
          163.59,
          190.49,
          219.76,
          250.07
        ]
      },
      "composer": "Alec Rowley",
      "name": "Miniature concerto",
      "primo": {
        "turnPages": [
          1,
          1,
          1,
          1,
          1,
          1,
          1,
          1
        ],
        "turnTimeStamps": [
          24.11,
          58.44,
          63.54,
          91.15,
          113.06,
          140.96,
          163.59,
          190.49,
          219.76,
          250.07
        ]
      },
      "secondo": {
        "turnPages": [
          1,
          1,
          1,
          1,
          1,
          1,
          1,
          1
        ],
        "turnTimeStamps": [
          24.11,
          58.44,
          63.54,
          91.15,
          113.06,
          140.96,
          163.59,
          190.49,
          219.76,
          250.07
        ]
      }
    },
    "Moderato": {
      "both": {
        "turnPages": [],
        "turnTimeStamps": []
      },
      "composer": "Cornelius Gurlitt",
      "name": "Moderato",
      "primo": {
        "turnPages": [],
        "turnTimeStamps": []
      },
      "secondo": {
        "turnPages": [],
        "turnTimeStamps": []
      }
    },
    "Prelude Defaun": {
      "both": {
        "turnPages": [
          1,
          1,
          1,
          1
        ],
        "turnTimeStamps": [
          37,
          53,
          37,
          57,
          66
        ]
      },
      "composer": "Debussy",
      "name": "Prelude Defaun",
      "primo": {
        "turnPages": [
          1,
          1,
          1,
          1
        ],
        "turnTimeStamps": [
          37,
          53,
          37,
          57,
          66
        ]
      },
      "secondo": {
        "turnPages": [
          1,
          1,
          1,
          1
        ],
        "turnTimeStamps": [
          37,
          53,
          37,
          57,
          66
        ]
      }
    },
    "Rondino": {
      "both": {
        "turnPages": [
          1,
          -1
        ],
        "turnTimeStamps": [
          23.69,
          35.66
        ]
      },
      "composer": "Joseph Hadyn",
      "name": "Rondino",
      "primo": {
        "turnPages": [
          1,
          -1
        ],
        "turnTimeStamps": [
          23.69,
          35.66
        ]
      },
      "secondo": {
        "turnPages": [
          1,
          -1
        ],
        "turnTimeStamps": [
          23.69,
          35.66
        ]
      }
    }
  }""";
  var responseData = jsonDecode(jsonString);
  print(responseData.toString());

  responseData.forEach((songName, songData) {
    songDictionary[songName] = Song.fromLinks(
        songName: songName,
        composer: songData["composer"],
        primoTimeStamps: List<double>.from(songData["primo"]["turnTimeStamps"]),
        primoTurnpages: List<int>.from(songData["primo"]["turnPages"]),
        secondoTimeStamps: List<double>.from(songData["secondo"]["turnTimeStamps"]),
        secondoTurnPages: List<int>.from(songData["secondo"]["turnPages"]),
        bothTimeStamps: List<double>.from(songData["both"]["turnTimeStamps"]),
        bothTurnpages: List<int>.from(songData["both"]["turnPages"]),
    );
  });
}

Map<String, Song> songDictionary = {};



