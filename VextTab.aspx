<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VextTab.aspx.cs" Inherits="VextTab" %>


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
    <script src="Vexflow/trunk/vextab/vextab.js"></script>
    <script src="Scripts/Ext/VexTab/tuninig_ext.js"></script>
    <link href="VexTab/tabdiv.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <canvas width="800" height="200" id="canvas"></canvas>
        <canvas width="800" height="200" id="canvas1"></canvas>
        <div class="vex-tabdiv" width="400" scale="0.8">
        </div>
        <textarea class="vex-tabdiv" style="width: 420px; height: 100px;">
            tabstave notation=true
            notes 4-5-6/3 10/4
        </textarea>
        <script>
            $(document).ready(function () {
                var JUSTIFY_WIDTH = 800;
                var CONTEXT = new Vex.Flow.Renderer(
                 document.getElementById("canvas"),
                   Vex.Flow.Renderer.Backends.CANVAS).getContext();

                var parser = new Vex.Flow.VexTab();
                //var _renderer = new Vex.Flow.Renderer(this._canvas, Vex.Flow.Renderer.Backends.CANVAS);
                var vextab_code = "tabstave notation=true tablature=false key=A \r\n" +
                                  "notes :q (C/4.G/4.E/4) 5h6/3 7/4 | \r\n " +
                                  "notes :8 [ t12p7p5h7/4 ] :q 7/5 :8 [ 3s5/5 ] \r\n  \r\n" +
                                 " tabstave notation=true \r\n " +
                                  "notes :q (8/2.7b9b7/3) (5b6/2.5b6/3)v :8 [ 7s12/4 ]\r\n " +
                                  "notes [ t:16:9s:8:3s:16:0/4 ]\r\n  ";
                var drawer = new Vex.Drawer("canvas1");
                drawer.draw(vextab_code);
                try {
                    parser.parse(vextab_code);
                    if (parser.isValid()) {
                        var elements = parser.getElements();
                        var staves = elements.staves;
                        var tabnotes = elements.tabnotes;
                        var notes = elements.notes;
                        var ties = elements.ties;
                        var beams = elements.beams;

                        for (var i = 0; i < staves.length; ++i) {
                            var tabstave = staves[i].tab;
                            var voice_tabnotes = elements.tabnotes[i];
                            var voice_ties = elements.ties[i];
                            var notestave = staves[i].note;
                            var voice_notes = notes[i];

                            if (tabstave) {
                                tabstave.setWidth(JUSTIFY_WIDTH - 50);
                                tabstave.setContext(CONTEXT).draw();
                            }

                            if (notestave) {
                                notestave.setWidth(JUSTIFY_WIDTH - 50);
                                notestave.setContext(CONTEXT).draw();
                            }

                            if (notestave && tabstave) {
                                Vex.Flow.Formatter.FormatAndDrawTab(
                                  CONTEXT,
                                  tabstave,
                                  notestave,
                                  voice_tabnotes,
                                  voice_notes);
                            } else if (tabstave) {
                                if (voice_tabnotes) Vex.Flow.Formatter.FormatAndDraw(
                                    CONTEXT, tabstave, voice_tabnotes);
                            } else if (notestave) {
                                if (voice_notes) Vex.Flow.Formatter.FormatAndDraw(
                                    CONTEXT, notestave, voice_notes);
                            }


                            // Draw ties
                            for (var j = 0; j < voice_ties.length; ++j) {
                                voice_ties[j].setContext(CONTEXT).draw();
                            }
                            // Draw stave
                            //stave.setWidth(JUSTIFY_WIDTH);

                            //stave.addClef("treble").setContext(CONTEXT).draw();

                            //// Draw notes and modifiers.
                            //if (voice_notes) {
                            //    Vex.Flow.Formatter.FormatAndDraw(CONTEXT, stave,
                            //        voice_notes, JUSTIFY_WIDTH - 20);
                            //}

                            //// Draw ties
                            //for (var j = 0; j < voice_ties.length; ++j) {
                            //    voice_ties[j].setContext(CONTEXT).draw();
                            //}
                        }
                        // Draw beams
                        for (var j = 0; j < beams.length; ++j) {
                            beams[j].setContext(CONTEXT).draw();
                        }
                    }
                } catch (e) {
                    alert(e.message);
                }
            });
        </script>
    </form>
</body>
</html>
