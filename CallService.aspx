<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CallService.aspx.cs" Inherits="ComposerCompanion_CallService" %>


<!DOCTYPE html X-UA-Compatible: IE=Edge>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
    <title></title>
    <script src="Scripts/jquery-1.8.2.min.js"></script>
    <link href="Scripts/jquery.mobile-1.2.0-rc.2.min.css" rel="stylesheet" />
    <script src="Scripts/jquery.mobile-1.2.0-rc.2.min.js"></script>
    </script>
    <script src="Scripts/WcfCaller.js"></script>
    <script src="Scripts/BaseLib.js"></script>
    <link href="Styles/jqm-docs.css" rel="stylesheet" />
    <link class="include" rel="stylesheet" type="text/css" href="Styles/jquery.jqplot.min.css" />
    <link type="text/css" rel="stylesheet" href="Styles/jqplot/shCoreDefault.min.css" />
    <link type="text/css" rel="stylesheet" href="Styles/jqplot/shThemejqPlot.min.css" />
    <link type="text/css" rel="stylesheet" href="Styles/jqplot/examples.css" />
    <script src="Midi/trunk/js/Widgets.Loader.js"></script>
    <script type="text/javascript" src="Scripts/jquery.jqplot.min.js">
    </script>
    <script class="include" type="text/javascript" src="Scripts/syntaxhighlighter/shCore.min.js"></script>
    <script class="include" type="text/javascript" src="Scripts/syntaxhighlighter/shBrushJScript.min.js"></script>
    <script class="include" type="text/javascript" src="Scripts/syntaxhighlighter/shBrushXml.js"></script>
    <script class="include" type="text/javascript" src="Scripts/plugins/jqplot.pieRenderer.min.js"></script>
    <script class="include" type="text/javascript" src="Scripts/plugins/jqplot.logAxisRenderer.min.js"></script>
    <script class="include" type="text/javascript" src="Scripts/plugins/jqplot.cursor.min.js"></script>
    <script class="include" type="text/javascript" src="Scripts/plugins/jqplot.categoryAxisRenderer.min.js"></script>
    <script class="include" type="text/javascript" src="Scripts/plugins/jqplot.canvasTextRenderer.min.js"></script>
    <script class="include" type="text/javascript" src="Scripts/plugins/jqplot.canvasAxisLabelRenderer.min.js"></script>
    <script class="include" type="text/javascript" src="Scripts/plugins/jqplot.barRenderer.min.js"></script>
    <script class="include" type="text/javascript" src="Scripts/plugins/jqplot.highlighter.min.js"></script>
    <script class="include" type="text/javascript" src="Scripts/plugins/jqplot.canvasOverlay.min.js"></script>
    <script class="include" type="text/javascript" src="Scripts/plugins/jqplot.pyramidAxisRenderer.min.js"></script>
    <script class="include" type="text/javascript" src="Scripts/plugins/jqplot.pyramidGridRenderer.min.js"></script>
    <script class="include" type="text/javascript" src="Scripts/plugins/jqplot.pyramidRenderer.min.js"></script>
    <script class="include" type="text/javascript" src="Scripts/plugins/jqplot.ohlcRenderer.min.js"></script>
    <script type="text/javascript" src="Scripts/plugins/jqplot.pointLabels.min.js"></script>

</head>
<body class="ui-mobile-viewport ui-overlay-a">
    <form id="form1" runat="server">
        <div data-role="page" id="Div1">
            <div data-theme="e" data-role="header" data-position="fixed">
                <h3>
                    <div id="holder" style="width: 100px; height: 70px;">Drop here.</div>
                </h3>
            </div>
            <div class="ui-bar ui-bar-b" data-inline="true">
                <div data-role="fieldcontain">
                    <div data-role="fieldcontain" data-inline="true">
                        Midi Key : <a href="#" id="midikey" data-inline="true" data-role="button" data-mini="true"></a>
                    </div>
                    <div data-role="fieldcontain" data-inline="true">
                        <label for="musiclist" class="select">Music :</label>
                        <select id="musiclist" name="musiclist" data-inline="true">
                        </select>
                    </div>
                    <div data-role="fieldcontain" data-inline="true">
                        <label for="chordlength" class="select">Chord Minimum :</label>
                        <select id="chordlength" name="chordlength" data-inline="true">
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                        </select>
                    </div>
                </div>
            </div>
            <div data-role="content" style="padding: 15px">
                <div id="chart_" style="height: 360px; width: 100%; margin: 20px;"></div>
                <div id="chart_2" style="height: 360px; width: 100%; margin: 20px;"></div>
            </div>
            <div data-theme="a" data-role="footer" data-position="fixed">
                <h3>Midi Analysis
                </h3>
            </div>
        </div>
        <script>
            $(document).ready(function () {
                var bargraph = null;
                var bargraph2 = null;
                var loader = new widgets.Loader({
                    message: "loading: Soundfont..."
                });
                loader.stop();
                var holder = document.getElementById('holder');
                holder.ondragover = function () { return false; };
                holder.ondragenter = function () { return false; };
                holder.ondrop = function (e) {
                    e = e || window.event;

                    // Read from e.files, as well as e.dataTransfer
                    var files = (e.files || e.dataTransfer.files);
                    var s = "";
                    for (var i = 0; i < files.length; i++) {
                        (function (i) {
                            filestobuffer.push(files[i]);
                            pumpBuffer();
                        })(i);
                    }

                    return false;
                };
                var filestobuffer = [];

                var pumprunner = false;
                var pumpBuffer = function () {
                    if (pumprunner || filestobuffer.length == 0) {
                        return;
                    }
                    pumprunner = true;
                    var _file = filestobuffer.shift();
                    loader.message(_file.name);
                    var reader = new FileReader();
                    reader.onload = function (event) {
                        var Data = JSON.stringify({ "data": event.target.result });
                        wcfcaller.add_onsuccess(function (d) {
                            HandleServiceResults(d, _file);
                            pumprunner = false;
                            setTimeout(pumpBuffer, 10);
                        });
                        wcfcaller.clearOnSuccess = true;
                        wcfcaller.callService(Data, _file.name);
                    };
                    reader.readAsDataURL(_file);
                }

                function ServiceFailed(result) {
                    // loader.stop();
                    alert('Service call failed: ' + result.status + '' + result.statusText);
                    pumpBuffer();
                }
                var lastresults = null;
                var showSingleMidiResults = function (results) {
                    if (bargraph) {
                        bargraph.destroy();
                    }
                    if (bargraph2) {
                        bargraph2.destroy();
                    }

                    bargraph = showSingleMidiResults_(results, undefined, undefined);
                    bargraph2 = showSingleMidiResults_(results, "CompactResuts", "chart_2");
                }
                var showSingleMidiResults_ = function (results, path, _div) {
                    var _path = results.ChordResuls;
                    var chartdiv = "chart_";
                    if (_div) {
                        chartdiv = _div;
                    }
                    if (path) {
                        //results.CompactResuts
                        _path = results[path];
                    }
                    if (!results) {
                        return;
                    }
                    lastresults = results;
                    var key = results.Keys[0].Key + (results.Keys[0].Accidental == 0 ? "" : results.Keys[0].Accidental == 2 ? flat : sharp);
                    $("#midikey").html(key);
                    var series = [];
                    for (var i = _path.length; i--;)
                        for (var k in _path[i].Voices) {
                            if (typeof (_path[i].Voices[k]) == "function") {
                                continue;
                            }
                            var voice = _path[i].Voices[k];
                            if (voice.VoiceParts.length >= minimumchordlength) {
                                if (voice.name != undefined) {
                                    if (series[voice.name] == undefined) {
                                        series[voice.name] = 1;
                                    } else {
                                        series[voice.name]++;
                                    }
                                }
                            }
                        }
                    var data = { ticks: ["1a", "2b", "3c", "4d", "5e"], data: [[11, 15], [1, 2, 3, 4, 5]] };
                    var _series = [];
                    var _data = [];
                    for (var i in series) {
                        if (typeof (i) == "string" && typeof (series[i]) != "function") {
                            //                            _series.push({ label: i });
                            _data.push([[i, series[i]]]);
                        }
                    }
                    var ticks = data.ticks;
                    var bargraph = null;
                    //var _data = data.data; 
                    if (_data.length > 0)
                        bargraph = $.jqplot(chartdiv, _data, {
                            // The "seriesDefaults" option is an options object that will
                            // be applied to all series in the chart. 
                            seriesDefaults: {
                                renderer: $.jqplot.BarRenderer,
                                rendererOptions: { fillToZero: false },
                                pointLabels: { show: false }
                            },
                            // Custom labels for the series are specified with the "label"
                            // option on the series option.  Here a series option object
                            // is specified for each series.
                            // series: _series,
                            // Show the legend and put it outside the grid, but inside the
                            // plot container, shrinking the grid to accomodate the legend.
                            // A value of "outside" would not shrink the grid and allow
                            // the legend to overflow the container.
                            axesDefaults: {
                                tickRenderer: $.jqplot.CanvasAxisTickRenderer,
                                tickOptions: {
                                    angle: -30,
                                    fontSize: '10pt'
                                }
                            },
                            //legend: {
                            //    show: false,
                            //    placement: 'outsideGrid'
                            //},
                            axes: {
                                // Use a category axis on the x axis and use our custom ticks.
                                xaxis: {
                                    renderer: $.jqplot.CategoryAxisRenderer,
                                    tickRenderer: $.jqplot.CanvasAxisTickRenderer,
                                    tickOptions: {
                                        angle: -90,
                                        fontSize: '10pt',
                                        showMark: false,
                                        showGridline: false
                                    }
                                },
                                // Pad the y axis just a little so bars can get close to, but
                                // not touch, the grid boundaries.  1.2 is the default padding.
                                yaxis: {
                                    pad: 1.05,
                                    tickOptions: { formatString: '%d' }
                                }
                            }
                        });
                    return bargraph;
                }
                $('#musiclist').change(function () {
                    var value = $('#musiclist').val();
                    showSingleMidiResults(MusicLibrary[value].results);
                });
                $("#chordlength").change(function () {
                    var value = $("#chordlength").val();
                    minimumchordlength = value;
                    showSingleMidiResults(lastresults);
                });
                var minimumchordlength = 2;
                var HandleServiceResults = function (results, file) {
                    if (results.Message) {
                        return;
                    }
                    MusicLibrary[file.name] = { results: results, file: file };
                    $('#musiclist').html("");
                    for (var i in MusicLibrary) {
                        if (typeof (MusicLibrary[i]) != "function")
                            $("#musiclist").append($("<option>", { value: MusicLibrary[i].file.name, text: MusicLibrary[i].file.name }));
                    }
                    $('#musiclist').selectmenu("refresh");
                    showSingleMidiResults(MusicLibrary[file.name].results);
                }
                var MusicLibrary = [];
                var Type;
                var Url;
                var Data;
                var ContentType;
                var DataType;
                var ProcessData;
                var userid = "1";
                Type = "POST";
                Url = "Service/MidiAnalysis.svc/Analyze";
                ContentType = "application/json; charset=utf-8";
                DataType = "json"; var ProcessData = true;
                var wcfcaller = new Wcf.Caller(Type, Url, ContentType, DataType, ProcessData, loader);
                wcfcaller.add_onerror(ServiceFailed);

            });
        </script>
        </div>
    </form>
    <script src="Dropfile/trunk/dropfile.js"></script>
</body>
</html>
