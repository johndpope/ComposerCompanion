<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MusicXMLDrawing.aspx.cs" Inherits="MusicXMLDrawing" %>


<!DOCTYPE html X-UA-Compatible: IE=Edge>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
    <title></title>
    <%--    <script src="http://code.jquery.com/jquery-1.8.1.min.js"></script>
    <script src="http://code.jquery.com/mobile/1.2.0-rc.2/jquery.mobile-1.2.0-rc.2.min.js"></script>--%>
    <link href="Scripts/jquery.mobile-1.2.0-rc.2.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.8.2.min.js"></script>
    <script src="Scripts/jquery.mobile-1.2.0-rc.2.min.js"></script>
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
    <script src="Scripts/MusicXmlReader.js"></script>
    <link href="VexTab/tabdiv.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <canvas width="800" height="200" id="canvas"></canvas>
        <a href="#" class="generate">Generate Vex flow text for number 1</a>
        <div>

            <script>

                $(document).ready(function () {
                    var cangen = false;
                    $(".generate").click(function () {
                        if (cangen) {
                            var result = reader.generateVexFlowText(1);
                            drawer.draw(result);
                        }
                    });
                    var vextab_code = "tabstave notation=true tablature=false key=A \r\n" +
                                  "notes ;1 :43q (C♭/4.G/4.E/4) 5h6/3 7/4  \r\n " +
                                  "notes ;2 :8d [ t12p7p5h7/4 ] :q 7/5 :8 [ 3s5/5 ] \r\n  \r\n" +
                                 " tabstave notation=true \r\n " +
                                  "notes :q (8/2.7b9b7/3) (5b6/2.5b6/3)v :8 [ 7s12/4 ]\r\n " +
                                  "notes [ t:16:9s:8:3s:16:0/4 ]\r\n  ";
                    var drawer = new Vex.Drawer("canvas");
                    drawer.draw(vextab_code);
                    var reader = new chordmaster.MusicXmlReader();
                    $.ajax({
                        url: '<%= ResolveUrl("~/xml/SchubertF_short2_export.xml") %>',
                        success: function (e, s) {
                            if (!cangen) {
                                reader.parse(e)
                            };
                            cangen = true;
                        },
                        error: function (e) {
                        }
                    });
                });
            </script>
        </div>
    </form>
</body>
</html>
