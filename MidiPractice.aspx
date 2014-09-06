<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MidiPractice.aspx.cs" Inherits="MidiPractice" %>

<!DOCTYPE html X-UA-Compatible: IE=Edge>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="http://code.jquery.com/jquery-1.8.1.min.js"></script>
    <script src="http://code.jquery.com/mobile/1.2.0-rc.2/jquery.mobile-1.2.0-rc.2.min.js"></script>
    <script src="Scripts/BaseLib.js"></script>
    <script src="Vexflow/trunk/src/header.js"></script>
    <script src="Vexflow/trunk/src/vex.js"></script>
    <script src="Vexflow/trunk/src/flow.js"></script>
    <script src="Vexflow/trunk/src/tables.js"></script>
    <script src="Vexflow/trunk/src/fonts/vexflow_font.js"></script>
    <script src="Vexflow/trunk/src/glyph.js"></script>
    <script src="Vexflow/trunk/src/stave.js"></script>
    <script src="Vexflow/trunk/src/staveconnector.js"></script>
    <script src="Vexflow/trunk/src/tabstave.js"></script>
    <script src="Vexflow/trunk/src/tickcontext.js"></script>
    <script src="Vexflow/trunk/src/tickable.js"></script>
    <script src="Vexflow/trunk/src/note.js"></script>
    <script src="Vexflow/trunk/src/barnote.js"></script>
    <script src="Vexflow/trunk/src/ghostnote.js"></script>
    <script src="Vexflow/trunk/src/stavenote.js"></script>
    <script src="Vexflow/trunk/src/tabnote.js"></script>
    <script src="Vexflow/trunk/src/beam.js"></script>
    <script src="Vexflow/trunk/src/voice.js"></script>
    <script src="Vexflow/trunk/src/voicegroup.js"></script>
    <script src="Vexflow/trunk/src/modifier.js"></script>
    <script src="Vexflow/trunk/src/modifiercontext.js"></script>
    <script src="Vexflow/trunk/src/accidental.js"></script>
    <script src="Vexflow/trunk/src/dot.js"></script>
    <script src="Vexflow/trunk/src/formatter.js"></script>
    <script src="Vexflow/trunk/src/stavetie.js"></script>
    <script src="Vexflow/trunk/src/tabtie.js"></script>
    <script src="Vexflow/trunk/src/tabslide.js"></script>
    <script src="Vexflow/trunk/src/bend.js"></script>
    <script src="Vexflow/trunk/src/vibrato.js"></script>
    <script src="Vexflow/trunk/src/annotation.js"></script>
    <script src="Vexflow/trunk/src/articulation.js"></script>
    <script src="Vexflow/trunk/src/tuning.js"></script>
    <script src="Vexflow/trunk/src/stavemodifier.js"></script>
    <script src="Vexflow/trunk/src/keysignature.js"></script>
    <script src="Vexflow/trunk/src/timesignature.js"></script>
    <script src="Vexflow/trunk/src/clef.js"></script>
    <script src="Vexflow/trunk/src/music.js"></script>
    <script src="Vexflow/trunk/src/keymanager.js"></script>
    <script src="Vexflow/trunk/src/renderer.js"></script>
    <script src="Vexflow/trunk/src/raphaelcontext.js"></script>
    <script src="Vexflow/trunk/src/stavevolta.js"></script>
    <script src="Vexflow/trunk/src/staverepetition.js"></script>
    <script src="Vexflow/trunk/src/stavebarline.js"></script>
    <script src="Vexflow/trunk/src/stavesection.js"></script>
    <script src="Vexflow/trunk/src/stavehairpin.js"></script>
    <script src="Vexflow/trunk/src/stavetempo.js"></script>
    <script src="Vexflow/trunk/src/tremolo.js"></script>
    <script src="Midi/trunk/js/DOMLoader.XMLHttp.js"></script>
    <script src="Midi/trunk/js/DOMLoader.script.js"></script>
    <script src="Midi/trunk/js/MIDI.audioDetect.js"></script>
    <script src="Midi/trunk/js/MIDI.loadPlugin.js"></script>
    <script src="Midi/trunk/js/MIDI.Plugin.js"></script>
    <script src="Midi/trunk/js/MIDI.Player.js"></script>
    <script src="Midi/trunk/js/MusicTheory.Synesthesia.js"></script>
    <script src="Midi/trunk/js/Widgets.Loader.js"></script>
    <script src="Midi/trunk/js/lib/jasmid/jasmid/stream.js"></script>
    <script src="Midi/trunk/js/lib/jasmid/jasmid/midifile.js"></script>
    <script src="Midi/trunk/js/lib/jasmid/jasmid/replayer.js"></script>
    <script src="Midi/trunk/js/VersionControl.Base64.js"></script>
    <script src="Midi/trunk/js/lib/base64binary.js"></script>
    <script src="Scripts/MidiReader.js"></script>
    <script src="Scripts/MidiDraw.js"></script>
    <script src="http://code.jquery.com/jquery-1.8.1.min.js"></script>
    <script src="Data/datasourcegenerator.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1 id="title"></h1>
            <div id="drop_zone" style="width: 200px; height: 120px; border: dotted;">Drop files here</div>
            <output id="list"></output>
            <div id="analysis_zone" style="width: 200px; height: 120px; border: dotted;">Analyze files here </div>
            <canvas id="midicanvas" height="230" width="600"></canvas>
            <div>
                <label for="quarternote">Quarter note value</label>
                <input name="quarternote" id="quarternote" type="text" value=".25" class="quarternote" />
            </div>
            <div>
                <label for="durationtxt">Duration</label>
                <input name="durationtxt" id="durationtxt" type="text" value=".00025" class="durationtxt" />
            </div>
            <select id="channels"></select>
            <div>
                <a href="#" class="next">Next</a>
                <a href="#" class="previous">Previous</a>
                <a href="#" class="refresh">Refresh</a>
            </div>
            <div>
                <a href="#" class="playnote">Play note</a>
            </div>
            <script>
                var folderoffset = "Midi/trunk/";
                if (typeof (console) === "undefined") var console = { log: function () { } };

                // Begin loading indication.
                var loader = new widgets.Loader({
                    message: "loading: Soundfont..."
                });
                function handleFileSelect(evt) {
                    evt.stopPropagation();
                    evt.preventDefault();

                    var files = evt.dataTransfer.files; // FileList object.
                    var data = evt.dataTransfer.getData('URL');
                    // files is a FileList of File objects. List some properties.
                    var output = [];
                    for (var i = 0, f; f = files[i]; i++) {
                        output.push('<li><strong>', escape(f.name), '</strong> (', f.type || 'n/a', ') - ',
                                    f.size, ' bytes, last modified: ',
                                    f.lastModifiedDate ? f.lastModifiedDate.toLocaleDateString() : 'n/a',
                                    '</li>');

                        var reader = new FileReader();

                        // Closure to capture the file information.
                        reader.onload = (function (theFile) {
                            return function (e) {
                                // Render thumbnail.
                                var span = document.createElement('span');
                                musictracks.push(e.target.result);
                                document.getElementById('list').insertBefore(span, null);
                                var player = MIDI.Player;
                                player.timeWarp = 1; // speed the song is played back
                                player.loadFile(musictracks[0], player.start);

                                // control the piano keys colors
                            };
                        })(f);

                        // Read in the image file as a data URL.
                        reader.readAsDataURL(f);
                    }
                    document.getElementById('list').innerHTML = '<ul>' + output.join('') + '</ul>';
                }
                var musictracks = [];
                function handleDragOver(evt) {
                    evt.stopPropagation();
                    evt.preventDefault();
                    evt.dataTransfer.dropEffect = 'copy'; // Explicitly show this is a copy.
                }
                function bindEvent(el, eventName, eventHandler) {
                    if (el.addEventListener) {
                        el.addEventListener(eventName, eventHandler, false);
                    } else if (el.attachEvent) {
                        el.attachEvent('on' + eventName, eventHandler);
                    }
                }

                // Setup the dnd listeners.
                var dropZone = document.getElementById('drop_zone');
                bindEvent(dropZone, 'dragover', handleDragOver, false);
                bindEvent(dropZone, 'drop', handleFileSelect, false);
                var mychoords = [];
                var handleFileAnalysis = function (evt) {
                    evt.stopPropagation();
                    evt.preventDefault();

                    var files = evt.dataTransfer.files; // FileList object.
                    var data = evt.dataTransfer.getData('URL');
                    // files is a FileList of File objects. List some properties.
                    var output = [];
                    for (var i = 0, f; f = files[i]; i++) {

                        var reader = new FileReader();

                        // Closure to capture the file information.
                        reader.onload = (function (theFile) {
                            return function (e) {

                                var flat = htmlDecode("&#x266d;");
                                var sharp = htmlDecode("&#x266f;");

                                chordreader.loadFile(e.target.result);
                                chordreader.process();
                                // var chords = chordreader.extractChords(.25, ["1"], .25 / 2);
                                // var chords2 = chordreader.extractChords(.25, ["0"], .25 / 2);
                                var channels = chordreader._channels;

                                $("#channels").html("");
                                for (var i = channels.length ; i--;) {
                                    $("#channels").append($("<option>", { value: channels[i], text: "Channel " + channels[i] }));
                                }
                                $("#channels").append($("<option>", { value: "All", text: "Channel All" }));
                                var chords3 = chordreader.extractChords(.0, chordreader.channels, parseFloat($('#durationtxt').val()));

                                mychoords = [];
                                for (var i in chords3) {
                                    var vchord = chordreader.getVScaleofChord(chords3[i][0]);
                                    var _v = chordreader.getDrawableChord(chords3[i][0]);
                                    if (_v != null)
                                        mychoords.push(_v);
                                    // control the piano keys colors
                                }
                            };
                        })(f);

                        // Read in the image file as a data URL.
                        reader.readAsDataURL(f);
                    }
                    document.getElementById('list').innerHTML = '<ul>' + output.join('') + '</ul>';
                }

                var chordreader = new chordmaster.MidiReader(flat, sharp);
                $(document).ready(function () {

                    $("#channels").change(function () {
                        var value = $("#channels").val();
                        var chords3 = null;
                        if (value == "All") {
                            chords3 = chordreader.extractChords(.0, undefined, parseFloat($('#durationtxt').val()));
                        }
                        else {
                            chords3 = chordreader.extractChords(.0, [value], parseFloat($('#durationtxt').val()));
                        }
                        mychoords = [];
                        for (var i in chords3) {
                            var vchord = chordreader.getVScaleofChord(chords3[i][0]);
                            var _v = chordreader.getDrawableChord(chords3[i][0]);
                            if (_v != null)
                                mychoords.push(_v);
                            // control the piano keys colors
                        }
                        current = 0;
                    });

                    var findLetter = function (num, bias, toavoid) {
                        var result = null;
                        for (var i in library) {
                            if (library[i] == num) {
                                if (i.indexOf(bias) != -1) {
                                    result = i;
                                }
                                else if (bias == undefined) {
                                    result = i;
                                }
                                if (i.indexOf(sharp) == -1 && i.indexOf(flat) == -1) {
                                    return i;
                                }
                            }
                        }
                        return result;
                    }
                    var current = 0;
                    var stepsize = 0;
                    $(".previous").click(function () {
                        current -= stepsize;
                        if (current < 0) {
                            current = mychoords.length - stepsize;
                        }
                        draw(current);
                    });
                    var mididraw = new ChordMaster.MidiDraw($("#midicanvas")[0]);
                    var draw = function (current) {
                        if (mychoords.length > stepsize) {
                            var timeInfo = mychoords[current].timeInfo["0"];
                            stepsize = timeInfo.numerator;
                            mididraw.drawMeasure({
                                width: 500,
                                denominator: timeInfo.denominator,
                                numerator: timeInfo.numerator,
                                clefs: [{
                                    type: "treble",
                                    offsetx: 0,
                                    offsety: 100,
                                }],
                                quarterNoteDuration: $(".quarternote").val(),
                                index: current,
                                notes: mychoords
                            });
                        }
                    }
                    $(".refresh").click(function () {
                        draw(current);
                    });
                    $(".next").click(function () {
                        current += stepsize;
                        if (current > mychoords.length - stepsize) {
                            current = 0;
                        }
                        draw(current);
                    });
                    $(".playnote").click(function () {
                        var secs = 60;
                        var bpm = 40;
                        var bps = secs / bpm;
                        var toplay = [[{ note: 60, value: 4 }]
                        ];
                        toplay = toplay.concat(riff_library.Funk.GiveItUpOrTurnItLose.data);
                        var notes = [];
                        var offset = 0;
                        for (var i = 0 ; i < toplay.length; i++) {
                            for (var j = 0 ; j < toplay[i].length; j++) {

                                var beat_time = bps / toplay[i][j].value;
                                offset = beat_time * 1000;
                                if (toplay[i][j].rest) {
                                }
                                else notes.push(MIDI.Player.createNote(toplay[i][j].note, j == 0 ? 0 : 0));

                            }
                            if (i != toplay.length - 1)
                                for (var j = 0 ; j < toplay[i].length; j++) {
                                    var beat_time = bps / toplay[i][j].value;
                                    offset = beat_time * 1000;
                                    notes.push(MIDI.Player.createNote(toplay[i][j].note, offset, false));

                                }
                        }
                        MIDI.Player.playRandomNotes(notes);
                    });
                    var analysis_zone = $("#analysis_zone")[0];
                    bindEvent(analysis_zone, "drop", handleFileAnalysis);
                });
                //
                MIDI.loadPlugin(function () {
                    // this is the language we are running in
                    var title = document.getElementById("title");
                    title.innerHTML = "Sound being generated with " + MIDI.lang + ".";
                    // this sets up the MIDI.Player and gets things going...

                    // 
                    //
                    loader.stop();
                });
            </script>
        </div>
    </form>
</body>
</html>
