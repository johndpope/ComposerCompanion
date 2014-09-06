<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MidiReader.aspx.cs" Inherits="MidiReader" %>

<!DOCTYPE html X-UA-Compatible: IE=Edge>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Midi/trunk/js/MIDI.Player.js"></script>
    <script src="Midi/trunk/js/lib/jasmid/jasmid/stream.js"></script>
    <script src="Midi/trunk/js/lib/jasmid/jasmid/midifile.js"></script>
    <script src="Midi/trunk/js/lib/jasmid/jasmid/replayer.js"></script>
    <script src="Midi/trunk/js/VersionControl.Base64.js"></script>
    <script src="Midi/trunk/js/lib/base64binary.js"></script>
    <script src="http://code.jquery.com/jquery-1.8.1.min.js"></script>
    <script src="Data/datasourcegenerator.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <script>
                if (typeof (chordmaster) == "undefined") {
                    chordmaster = {};
                }
                chordmaster.MidiReader = function () {
                    this._player = MIDI.Player;
                    this._player.timeWarp = 1; // speed the song is played back
                }
                chordmaster.MidiReader.prototype = {
                    loadFile: function (file, callback) {
                        var _this= this;
                        var success = (function (data) {
                            _this._player.loadFile();
                        });
                        $.ajax({
                            url: file,
                            success: success
                        });
                    }
                }
                if (!Function.prototype.bind) {
                    Function.prototype.bind = function (oThis) {
                        if (typeof this !== "function") {
                            // closest thing possible to the ECMAScript 5 internal IsCallable function
                            throw new TypeError("Function.prototype.bind - what is trying to be bound is not callable");
                        }

                        var aArgs = Array.prototype.slice.call(arguments, 1),
                        fToBind = this,
                        fNOP = function () { },
                        fBound = function () {
                            return fToBind.apply(this instanceof fNOP
                                                 ? this
                                                 : oThis,
                                               aArgs.concat(Array.prototype.slice.call(arguments)));
                        };

                        fNOP.prototype = this.prototype;
                        fBound.prototype = new fNOP();

                        return fBound;
                    };
                }

                $(document).ready(function () {
                    var chordreader = new chordmaster.MidiReader();
                    chordreader.loadFile("bingham.mid", function () {
                        alert("loaded bingham");
                    });
                });
            </script>
        </div>
    </form>
</body>
</html>
