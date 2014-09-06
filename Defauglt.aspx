<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Defauglt.aspx.cs" Inherits="_Default" %>


<!DOCTYPE html X-UA-Compatible: IE=Edge>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.9.0/themes/base/jquery-ui.css" />
    <link href="Scripts/jquery.mobile-1.2.0-rc.2.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="mycustomtheme.min.css" />
    <script src="Scripts/jquery-1.8.2.min.js"></script>
    <script src="http://code.jquery.com/ui/1.9.0/jquery-ui.js"></script>
    <script src="Scripts/jquery.mobile-1.2.0-rc.2.min.js"></script>
    <link href="Styles/jquery.mobile-1.2.0.css" rel="stylesheet" />
    <link href="Styles/jqm-docs.css" rel="stylesheet" />
    <link href="Styles/zocial.css" rel="stylesheet" />
    <link href='http://fonts.googleapis.com/css?family=Pompiere' rel='stylesheet' type='text/css'>
    <script src="http://js.live.net/v5.0/wl.js"></script>
    <!-- VexFlow Uncompiled Sources -->
    <script src="Scripts/BaseLib.js"></script>
    <script src="Vexflow/trunk/vexflow.js"></script>
    <script src="MultiSelect/jquery.bgiframe.min.js"></script>
    <script src="MultiSelect/jquery.multiSelect.js"></script>
    <link href="MultiSelect/jquery.multiSelect.css" rel="stylesheet" />
    <script src="Data/chord_data.js"></script>
    <script src="Data/voices.js"></script>
    <script src="Data/datasourcegenerator.js"></script>
    <script src="Vexflow/trunk/vextab/vextab.js"></script>
    <script src="Scripts/Ext/VexTab/tuninig_ext.js"></script>
    <script src="Scripts/MusicXmlReader.js"></script>
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
    <script src="Scripts/ScoreManager.js"></script>
    <link href="VexTab/tabdiv.css" rel="stylesheet" />
    <link href="Data/stylesheet.css" rel="stylesheet" type="text/css" />
    <title>Composer Companion</title>
    <style>
        body .zocial
        {
            margin: 8px 4px;
            font-size: 13px;
        }
    </style>
</head>
<body>
    <div data-role="page" id="login">
        <div data-role="header" data-theme="f">
            <h1>Composer Companion
            </h1>
            <img src="images/header.png" style="text-align: center;" />
        </div>
        <div data-role="content" role="main">
            <div class="content-primary">
            </div>
            <div class="content-secondary">
                <div>
                    <a href="#cc" id="noidlogin" class="zocial primary" title="I don't need to login cause I'm awesome.">I dont need to Log in.</a>
                </div>
                <div id="fb-root"></div>
                <div id="facebook_login">
                    <p>
                        <fb:login-button />
                    </p>
                </div>
                <div id="facebook"></div>
                <div id="microsoft">
                    <a style="color: white;" href="#" class="zocial windows">Sign in with Windows Live</a>
                    <div id="signin"></div>
                </div>
                <div id="google">
                    <a style="color: white;" href="#" id="google_authorize_button" class="zocial googleplus">Sign in with Google+</a>
                </div>
                <div id="google_content"></div>
            </div>
            <script>
                function loginUser() {
                    FB.login(function (response) { }, { scope: 'email' });
                }
            </script>
            <script>
                var federatedInfo = null;
                function handleStatusChange(response) {
                    // document.body.className = response.authResponse ? 'connected' : 'not_connected';

                    if (response.authResponse) {

                        FB.api('/me', function (user) {
                            if (user) {
                                federatedInfo = { user: user, provider: "facebook" };
                                // $.mobile.changePage($("#cc"));
                                $("#facebook_login").hide();
                                $("#facebook").html("");
                                $("#facebook").append($("<a style='color: white;'  class='zocial facebook' href='#cc' id='livesignout'>Continue with Facebook!</a>"));
                            }
                        });
                    }
                }
                $("#noidlogin").click(function () {
                    federatedInfo = null;
                });
                var REDIRECT_URL = 'http://composercompanion.mephistowa.com/ComposerCompanion/Default.aspx';
                window.fbAsyncInit = function () {
                    FB.init({
                        appId: '476464249051163', // App ID
                        channelUrl: REDIRECT_URL, // Channel File
                        status: true, // check login status
                        cookie: true, // enable cookies to allow the server to access the session
                        xfbml: true  // parse XFBML
                    });
                    FB.Event.subscribe('auth.statusChange', handleStatusChange);
                };

                // Load the SDK Asynchronously
                (function (d) {
                    var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
                    if (d.getElementById(id)) { return; }
                    js = d.createElement('script'); js.id = id; js.async = true;
                    js.src = "//connect.facebook.net/en_US/all.js";
                    ref.parentNode.insertBefore(js, ref);
                }(document));




                $(document).ready(function () {

                    function onLiveLoginComplete() {
                        var session = WL.getSession();
                        if (session) {
                            log("You are signed in!");
                            clearLiveDiv("logout");
                            federatedInfo = { user: session, provider: "live" };
                        }
                    }
                    var clearLiveDiv = function (c) {
                        $("#microsoft").html("");
                        switch (c) {
                            case "logout": //<a style="color: white;"  href="#" class="zocial windows">Sign in with Windows Live</a>
                                $("#microsoft").append($("<a style='color: white;'  class='zocial windows' href='#cc' id='livesignout'>Continue with Windows Live!</a>"));
                                //$("#livesignout").click(signUserOut);
                                break;
                            case "login":
                                $("#microsoft").append($("<a style='color: white;'  class='zocial windows' href='#' id='livesignin'>Sign In with Windows Live!</a>"));
                                $("#livesignin").click(signInUser);
                                break
                        }
                    }
                    function onSessionChange() {
                        var session = WL.getSession();
                        if (session) {
                            log("Your session has changed.");
                        }
                    }
                    WL.init({ client_id: "00000000440DBC67", redirect_uri: REDIRECT_URL });
                    WL.Event.subscribe("auth.login", onLiveLoginComplete);
                    WL.Event.subscribe("auth.sessionChange", onSessionChange);

                    var signUserOut = function () {
                        WL.logout();
                    }
                    var signInUser = function () {
                        WL.login({
                            scope: "wl.signin"
                        }, onLiveLoginComplete);
                    }
                    var session = WL.getSession();
                    if (session) {
                        clearLiveDiv("logout");

                    } else {
                        clearLiveDiv("login");
                    }

                    function log(message) {
                        var child = document.createTextNode(message);
                        var parent = document.getElementById('JsOutputDiv') || document.body;
                        parent.appendChild(child);
                        parent.appendChild(document.createElement("br"));
                    }
                });
            </script>
            <script>
                function handleClientLoad() {
                    gapi.client.setApiKey(apiKey);
                    window.setTimeout(checkAuth, 1);
                }
                function handleAuthClick(event) {
                    gapi.auth.authorize({ client_id: clientId, scope: scopes, immediate: false }, handleAuthResult);
                    return false;
                }
                function handleAuthResult(authResult) {

                    var authorizeButton = document.getElementById('google_authorize_button');
                    if (authorizeButton) {
                        if (authResult && !authResult.error) {
                            authorizeButton.style.visibility = 'hidden';
                            makeApiCall();
                        } else {

                            authorizeButton.style.visibility = '';
                            authorizeButton.onclick = handleAuthClick;
                        }
                    }
                    else {
                        authorizationResult = authResult;
                    }
                }
                var authorizationResult = null;
                function checkAuth() {
                    gapi.auth.authorize({ client_id: clientId, scope: scopes, immediate: true }, handleAuthResult);
                }
                // Load the API and make an API call.  Display the results on the screen.
                function makeApiCall() {
                    gapi.client.load('plus', 'v1', function () {
                        var request = gapi.client.plus.people.get({
                            'userId': 'me'
                        });
                        request.execute(function (resp) {
                            $("#google").html('<a style="color: white;" href="#cc" class="zocial googleplus">Continue with Google+</a>');
                            federatedInfo = { user: resp, provider: "google" };
                        });
                    });
                }
                function appendResults(text) {
                    var results = document.getElementById('googleresults');
                    results.appendChild(document.createElement('P'));
                    results.appendChild(document.createTextNode(text));
                }

                function makeRequest() {
                    var request = gapi.client.urlshortener.url.get({
                        'shortUrl': 'http://goo.gl/fbsS'
                    });
                    request.execute(function (response) {
                        appendResults(response.longUrl);
                    });
                }
                var clientId = '280788345596.apps.googleusercontent.com';
                var apiKey = 'AIzaSyAYUolFsNJuja3SIN9QRrVU0Io0r8kI2Zg';
                var scopes = "https://www.googleapis.com/auth/plus.me";
                $(document).ready(function () {
                    if (authorizationResult) {
                        handleAuthResult(authorizationResult)
                    }
                    // To enter one or more authentication scopes, refer to th
                    // Use a button to handle authentication the first time.

                    //https://accounts.google.com/o/oauth2/auth?
                    //    scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.email+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.profile&
                    //    state=%2Fprofile&
                    //    redirect_uri=https%3A%2F%2Foauth2-login-demo.appspot.com%2Foauthcallback&
                    //    response_type=token&
                    //    client_id=812741506391.apps.googleusercontent.com


                });
            </script>
            <script src="https://apis.google.com/js/client.js?onload=handleClientLoad"></script>
            <div id="JsOutputDiv"></div>
            <div id="googleresults"></div>
        </div>

        <div data-role="footer" data-theme="f">
            <h3>Composer Companion</h3>
        </div>
    </div>

    <div data-role="page" id="cc">
        <div data-role="header" data-theme="f">
            <h1>Composer Companion
            </h1>
        </div>

        <div class="ui-bar ui-bar-b">
            <div style="float: left;">
                <img id="image" />
            </div>
            <div id="name" style="float: left; display: inline; padding-right: 150px;"></div>
            <div id="popupBasic" style="float: left;">
                <p>
                    Loading.<img src="ajax-loader.gif" />
                </p>
            </div>
            <div style="float: left;">
                <iframe src="https://www.facebook.com/plugins/like.php?href=<%= ComposerCompanionSiteUrl %>"
                    scrolling="no" frameborder="0"
                    style="border: none; width: 450px; height: 80px"></iframe>
            </div>
        </div>
        <div class="ui-bar ui-bar-a" style="z-index: 2;">
            <script type="text/javascript"><!--
                google_ad_client = "ca-pub-2969509550294160";
                /* Composer Companion */
                google_ad_slot = "8900442168";
                google_ad_width = 728;
                google_ad_height = 90;
    //-->
            </script>
            <script type="text/javascript"
                src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
            </script>
        </div>
        <!-- /header -->
        <div data-role="content" role="main">
            <div class="content-secondary">
                <ul data-role="listview" data-inset="true" data-theme="c">
                    <li data-role="divider" role="heading" class="ui-bar-f">Chord / Scales</li>
                    <li>
                        <div id="toggle">
                            <h3>Melody and Base</h3>
                        </div>
                        <div data-role="fieldcontain" id="melodybuttons">
                            <ul data-role="listview" data-inset="true" data-theme="c">
                                <li data-role="divider" role="heading" class="ui-bar-f">Melody</li>
                                <li>
                                    <div data-role="controlgroup" data-type="horizontal">
                                        <a href="#" data-role="button" id="addmelodybtn">Add</a>
                                        <a href="#" data-role="button" id="clearmelodybtn">Clear</a>
                                        <a href="#" data-role="button" class="playmelodystaff" id="playmelodybtn">Play</a>
                                        <!--<a href="#" data-role="button" id="setbasebtn">Set Base</a>-->
                                    </div>
                                </li>
                                <li>
                                    <div class="ui-grid-b">
                                        <div class="ui-block-a" data-role="fieldcontain">
                                            <fieldset data-role="controlgroup" id="keygroup_melody">
                                            </fieldset>
                                        </div>
                                        <div class="ui-block-b">
                                            <div data-role="fieldcontain">
                                                <fieldset data-role="controlgroup" id="keygroup_accidentals">
                                                </fieldset>
                                            </div>
                                            <div data-role="fieldcontain">
                                                <fieldset data-role="controlgroup" id="keygroup_octaves" data-type="horizontal">
                                                </fieldset>
                                            </div>
                                        </div>
                                        <div class="ui-block-c">
                                            <div data-role="fieldcontain" id="melodyarea">
                                                <ul data-role="listview" class="melodylist" data-theme="a">
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div data-role="fieldcontain" id="Div2">
                            <div data-role="fieldcontain">
                                <fieldset data-role="controlgroup" data-type="horizontal">
                                    <legend>Clef : </legend>
                                    <input type="radio" name="CleffChoice" id="RadioTreble" value="treble" checked="checked" />
                                    <label for="RadioTreble">Treble</label>
                                    <input type="radio" name="CleffChoice" id="RadioBass" value="bass" />
                                    <label for="RadioBass">Bass</label>
                                    <input type="radio" name="CleffChoice" id="RadioAlto" value="alto" />
                                    <label for="RadioAlto">Alto</label>
                                    <input type="radio" name="CleffChoice" id="RadioTenor" value="tenor" />
                                    <label for="RadioTenor">Tenor</label>

                                </fieldset>
                            </div>
                            <!--<div data-role="fieldcontain">
                                <fieldset data-role="controlgroup" data-type="horizontal" id="octaveshift1">
                                    <legend>Octave Shift : </legend>

                                </fieldset>
                            </div>-->
                            <div data-role="fieldcontain" id="Div1">
                                <a href="#" data-role="button" class="playmelodystaff" id="playmelodystaff">Play</a>
                                <canvas id="melodystaffcanvas" height="200" width="400" />
                                <ul data-role="listview" class="melodylist" id="melodylist" data-theme="a">
                                </ul>
                            </div>

                        </div>
                    </li>
                    <li>
                        <div data-role="fieldcontain" id="Div3">
                            <div data-role="controlgroup" data-type="horizontal">
                                <a href="#" data-role="button" data-icon="gear" id="selectmorescales">Click to Select Scales of Interest</a>
                            </div>
                            <div id="scale_filter">
                                <ul data-role="listview" data-inset="true" data-theme="c">
                                    <li data-role="divider" role="heading" class="ui-bar-f">Selected Scales</li>
                                    <li>
                                        <div data-role="fieldcontain" id="selectedscales">
                                            <ul data-role="listview" data-theme="g" id="selectscaleslist" data-inset="true" style="white-space: nowrap;">
                                            </ul>
                                        </div>
                                    </li>
                                    <li id="toselect">
                                        <div data-role="fieldcontain">
                                            <ul data-role="listview" id="scales_">
                                            </ul>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>

                    </li>
                    <li>
                        <div data-role="fieldcontain" id="Div4">
                            <ul data-role="lisview" id="helplist" data-inset="true" data-theme="c">
                                <li data-role="divider" role="heading" class="ui-bar-f">Directions</li>
                                <li>Press the Melody button</li>
                                <li>Cick a Key[A-G] with an optional accidental(&#x266d; | &#x266f; | &#x266e;) and select the octave for the note.</li>
                                <li>Press the Add for more notes in the chord.</li>
                                <li>Options will appear in the list.</li>
                                <li>Press these options to see them on a staff.</li>
                            </ul>
                        </div>
                        <div id="togglehelp">
                            <h3>Help?</h3>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="content-primary">
                <ul data-role="listview" data-inset="true" data-theme="c">
                    <li data-role="divider" role="heading" class="ui-bar-f">Chord Alternates
                    </li>
                    <li>
                        <div data-role="fieldcontain">
                            <fieldset data-role="controlgroup" data-type="horizontal">
                                <legend>Clef : </legend>
                                <input type="radio" name="CleffChoice2" id="RadioTreble2" value="treble" checked="checked" />
                                <label for="RadioTreble2">Treble</label>
                                <input type="radio" name="CleffChoice2" id="RadioBass2" value="bass" />
                                <label for="RadioBass2">Bass</label>
                                <input type="radio" name="CleffChoice2" id="RadioAlto2" value="alto" />
                                <label for="RadioAlto2">Alto</label>
                                <input type="radio" name="CleffChoice2" id="RadioTenor2" value="tenor" />
                                <label for="RadioTenor2">Tenor</label>

                            </fieldset>
                        </div>
                        <div>
                            <a href="#" data-role="button" class="playstaffnotes" id="A1">Play</a>
                            <canvas width="400" height="200" id="staffnotes"></canvas>

                        </div>
                        <table>
                            <tr>
                                <td>
                                    <span id="chord_call_name"></span>
                                </td>
                                <td style="padding-left: 100px;">
                                    <span id="scale_call_name"></span>
                                </td>
                            </tr>
                        </table>
                        <div data-role="fieldcontain">
                            <fieldset data-role="controlgroup" data-type="horizontal">
                                <legend>Bias:</legend>
                                <input type="radio" name="radio-choice-bias" id="biasflat" value="choice-1" />
                                <label for="biasflat">&#x266d;</label>

                                <input type="radio" name="radio-choice-bias" id="biassharp" value="choice-2" checked="checked" />
                                <label for="biassharp">&#x266f;</label>
                            </fieldset>
                        </div>
                        <label for="scaleselection">Scales </label>
                        <select name="scaleselection" id="scaleselection">
                        </select>
                    </li>
                    <li>
                        <div data-role="fieldcontain" id="Div5">
                            <div id="paginginfo"></div>
                            <div data-role="controlgroup" data-type="horizontal">
                                <a href="#" data-icon="arrow-l" data-role="button" id="pagingback">Back</a>
                                <a href="#" data-icon="arrow-r" data-role="button" id="pagingforward">Forward</a>
                                <select name="scaleselection" id="pagesize">
                                    <option>5</option>
                                    <option>10</option>
                                    <option>20</option>
                                    <option>50</option>
                                </select>
                            </div>
                        </div>
                        <div data-role="fieldcontain" id="results">
                            <ul data-role="listview" data-theme="g" id="matchingresults">
                            </ul>
                        </div>
                    </li>
                    <%--<li data-role="divider" role="heading" class="ui-bar-f">Chord Progressions</li>
                    <li>
                        <div data-role="fieldcontain" id="chordprogressionssection">
                        </div>
                    </li>--%>
                </ul>
            </div>

        </div>

        <!-- /grid-b -->
        <div data-role="footer">
            <h3>Master of Chords</h3>
        </div>
    </div>
    <!-- /footer -->
    <!-- /content -->
    </div>
    <script src="Scripts/ChordMaster.Reader.js"></script>
    <script>
        for (var i = 0; i < key.length; i++) {
            var input = $("<input>", {
                type: "radio", name: "radio_keygroup", id: "radio_keygroup" + i, value: key[i], click: function (s) {
                    refresh();
                }
            });
            var label = $("<label>", { "for": "radio_keygroup" + i, text: key[i] });
            $("#keygroup").append(input).append(label);
        }
        for (var i = 0; i < key.length; i++) {
            var input = $("<input>", {
                type: "radio", name: "keygroup_melody", id: "keygroup_melody" + i, value: key[i], click: (function (s, e) {

                    $("input[name=keygroup_melody]").each(function (s, e) {
                        var ischecked = $(e).attr('checked');
                        if (ischecked) {
                            selectedmelody = $(e).val();

                        }
                    });
                })
            });
            var label = $("<label>", { "for": "keygroup_melody" + i, text: key[i] });
            $("#keygroup_melody").append(input).append(label);
        }
        selectedmelody = null;
        selectedaccidental = "";
        $("#keygroup_melody").trigger("refresh");
        $("#keygroup").trigger("refresh");
        var melodylist = [];
        $("#clearmelodybtn").click(function () {
            melodylist = [];
            refreshmelodylist();
            $("#matchingresults").html("");
            if (getrootbase() == null) { return; }
            var v = calculateV();
            var scales = getSelectedScales();
            refreshOptionsList(v, scales);
        });
        $("#addmelodybtn").click(function () {
            if (!findmelody(melodylist, selectedmelody, selectedaccidental.trim(), selectedoctave)) {
                var obj = { key: selectedmelody, accidental: selectedaccidental.trim(), octave: selectedoctave };
                melodylist.push(obj);
                refreshmelodylist();
                if (getrootbase() == null) { return; }
                var v = calculateV();
                var scales = getSelectedScales();
                refreshOptionsList(v, scales);
            }
        });
        //$("#setbasebtn").click(function () {
        //    setrootbase(selectedmelody);
        //    setaccidental(selectedaccidental);
        //    setoctaverootbase(selectedoctave);
        //    refreshmelodylist();
        //    if (getrootbase() == null) { return; }
        //    var v = calculateV();
        //    var scales = getSelectedScales();
        //    refreshOptionsList(v, scales);
        //});
        var refresh = function () {
            if (getrootbase()) {
                var v = calculateV();
                var scales = getSelectedScales();
                refreshOptionsList(v, scales);
            }
        }
        var melodystaffcanvas = new Vex.Drawer("melodystaffcanvas");
        var generateCode = function (list) {
            var vextab_code = "tabstave notation=true  tablature=false clef=" + selectedcleffchoice + " \r\n" +
                              "notes ;1 :w (";
            for (var i = 0; i < list.length; i++) {
                vextab_code += list[i].key + list[i].accidental + "/" + list[i].octave;
                if (i != list.length - 1) {
                    vextab_code += ".";
                }
            }
            vextab_code += ") \r\n";
            return vextab_code;
        }
        var selectedcleffchoice = "treble";
        $("input[name=CleffChoice]").change(function () {
            $("input[name=CleffChoice]").each(function (s, e) {
                var ischecked = $(e).attr('checked');
                if (ischecked) {
                    selectedcleffchoice = $(e).val();
                }
            });
            refresh();
        });
        var selectedcleffchoice2 = "treble";
        $("input[name=CleffChoice2]").change(function () {
            $("input[name=CleffChoice2]").each(function (s, e) {
                var ischecked = $(e).attr('checked');
                if (ischecked) {
                    selectedcleffchoice2 = $(e).val();
                }
            });

            chordmaster.renderNotes();
        });
        var currentpage = 0;
        var lastpage = 0;
        var pagingsize = 5;
        $("#pagingback").click(function () {
            currentpage--;
            if (currentpage < 0) {
                currentpage = lastpage - 1;
            }
            if (currentpage >= lastpage) {
                currentpage = 0;
            }
            refresh();
        });
        $("#pagingforward").click(function () {
            currentpage++;
            if (currentpage >= lastpage) {
                currentpage = 0;
            }
            if (currentpage < 0) {
                currentpage = lastpage - 1;
            }
            refresh();
        });
        $("#pagesize").change(function (e) {
            pagingsize = parseInt($("#pagesize").val());
            refresh();
            if (currentpage < 0) {
                currentpage = lastpage - 1;
            }
            if (currentpage >= lastpage) {
                currentpage = 0;
            }
            refresh();
        });

        var refreshOptionsList = function (v, scales) {
            var matches = chordmaster.findMatches(v, scales, currentpage, pagingsize);
            var sorted = melodylist.sort(function (a, b) {
                var val_a = library[a.key + a.accidental] + a.octave * 12;
                var val_b = library[b.key + b.accidental] + b.octave * 12;
                return val_a - val_b;
            });
            var code = generateCode(sorted)
            melodystaffcanvas.draw(code);
            $("#matchingresults").html("");
            var added = [];
            for (var i = matches.length; i--;) {
                var _Text = tonicetext(matches[i]);
                if (added.indexOf(_Text) == -1) {
                    added.push(_Text);
                    $("#matchingresults").append($("<li>", {
                        click:
                        (function () {
                            $("#scaleselection").html("");
                            var possible_scales = [];
                            var selectedscales = getSelectedScales();
                            for (var i = 0; i < this.smartinfo.scales.length; i++) {
                                if (shouldShow(selectedscales, [this.smartinfo.scales[i]]) || selectedscales.length == 0)
                                    //if (possible_scales.indexOf(getScaleName(this.smartinfo.scales[i])) == -1)
                                {
                                    var option = $("<option>",
                                         {
                                             value: this.smartinfo.scales[i],
                                             text: scaleText(this, this.smartinfo.scales[i]),//getScaleName(this.smartinfo.scales[i]),
                                             selected: i == 0 ? true : false
                                         })
                                    $("#scaleselection").append(option);
                                    possible_scales.push(getScaleName(this.smartinfo.scales[i]));
                                }
                            }
                            this.selectedScale = this.smartinfo.scales[0];
                            $("#scaleselection").match = this;
                            chordmaster.renderNotes(this, this.selectedScale);
                            $('#scaleselection').val(this.smartinfo.scales[i]);
                            $('#scaleselection').selectmenu("refresh");
                            $("#chord_call_name").text(keyText(this, this.selectedScale));
                            $("#scale_call_name").text(scaleText(this, this.selectedScale));
                        }).bind(matches[i])
                    }).append($("<a>", { style: "font-size:.75em", text: _Text, href: "#" })));
                }
            }
            $("#matchingresults").listview("refresh");


        }
        $("#scaleselection").bind("change", function (event, ui) {
            if (chordmaster.get_lastChords()) {
                chordmaster.get_lastChords().selectedScale = $("#scaleselection").val();
                $("#scale_call_name").text(scaleText(this, $("#scaleselection").val()));
                chordmaster.renderNotes();
            }
        });
        var shouldShow = function (scales, _scales) {
            for (var i = scales.length; i--;) {
                for (var j = _scales.length; j--;) {
                    if (scales[i] == getScaleName(_scales[j])) {
                        return true;
                    }
                }
            }
            return false;
        }
        var getScaleName = function (id) {
            for (var i in bosslist) {
                for (var j = bosslist[i].length; j--;) {
                    if (bosslist[i][j].id == id) {
                        return bosslist[i][j].official;
                    }
                }
            }
            return "[Unknown]";
        }
        var getScale = function (id) {
            for (var i in bosslist) {
                for (var j = bosslist[i].length; j--;) {
                    if (bosslist[i][j].id == id) {
                        return bosslist[i][j];
                    }
                }
            }
        }
        var tonicetext = function (obj) {
            return obj.smartinfo.isInversion ? obj.smartinfo.name.split("or")[0] + " " + " ".nth(obj.smartinfo.inversion) + " Inv" : obj.smartinfo.name.split("or")[0] + " [" + getBaseRoot(obj._info.col2.data) + "]";
        };
        var keyText = function (obj, scaleId) {
            if (obj.smartinfo.isInversion) {
                var scale = getScale(scaleId);
                var offset = obj.smartinfo.voice[obj.smartinfo.voice.length - obj.smartinfo.inversion]
                var base_int = library[getrootbase() + getaccidentalsvalue()];
                var letter = findLetter(convertToMelody(base_int, offset));
                return letter + "  " + obj.smartinfo.name.split("or")[0] + " " + " ".nth(obj.smartinfo.inversion) + " Inv"
            }
            return getrootbase() + getaccidentalsvalue() + " " + obj.smartinfo.name.split("or")[0];//obj._info[("col1")].data[0];
        }
        var scaleText = function (obj, id) {
            var scaleinfo = getScale(id);//obj._info.col2.data+ obj.smartinfo.name.split(or)[0]
            return getBaseRoot(scaleinfo.root.toString(12)) + " " + scaleinfo.official;
        }
        var getBaseRoot = function (root, single) {
            var value = parseInt(root, 12);
            var base_int = library[getrootbase() + getaccidentalsvalue()];
            var resut = (base_int - value) % 12;
            if (resut < 0) {
                resut += 12;
            }
            var results = "";
            for (var i in library) {
                if (library[i] == resut) {
                    if (results == "")
                        results += i;
                    else {
                        results += "/" + i;
                    }
                    if (single) {
                        break;
                    }
                }
            }
            return results;
        }
        var getSelectedScales = function () {
            var list = [];
            $("input[name=scales_radio]").each(function (s, e) {
                var ischecked = $(e).attr('checked');
                if (ischecked)
                    list.push($(e).val());
            });
            return list;
        }
        var getrootbase = function () {
            var lowest = 1000;
            var base = null;
            for (var i = 0 ; i < melodylist.length; i++) {
                var temp = library[melodylist[i].key + melodylist[i].accidental] + melodylist[i].octave * 12;
                if (temp < lowest) {
                    base = melodylist[i].key;
                    lowest = temp;
                }
            }
            return base;
            // return output;
        }
        var getrootoctave = function () {
            var lowest = 1000;
            var base = null;
            for (var i = 0 ; i < melodylist.length; i++) {
                var temp = library[melodylist[i].key + melodylist[i].accidental] + melodylist[i].octave * 12;
                if (temp < lowest) {
                    base = melodylist[i].octave;
                    lowest = temp;
                }
            }
            return base;
            // return output;
        }
        var getKeyValue = function (melodyobject) {
            return library[melodyobject.key + melodyobject.accidental] + melodyobject.octave * 12;
        }
        var _rootbase = null;
        var setrootbase = function (value) {
            _rootbase = value;
        }
        var _rootocatave = null;
        var setoctaverootbase = function (value) {
            _rootocatave = value;
        }
        var _rootaccidental = "";
        var setaccidental = function (value) {
            _rootaccidental = value;
        }
        var calculateV = function () {
            var base_int = library[(getrootbase() + getaccidentalsvalue()).trim()];
            var sorted = melodylist.sort(function (a, b) {
                var val_a = library[a.key + a.accidental] + a.octave * 12;
                var val_b = library[b.key + b.accidental] + b.octave * 12;
                return val_a - val_b;
            });
            var result = ["00"];
            var base_int = library[(sorted[0].key + sorted[0].accidental).trim()];
            for (var i = 1; i < sorted.length; i++) {
                result.push(converttoBase12(getKeyValue(sorted[i]) - getKeyValue(sorted[0])));
            }

            return (result);
        }

        var refreshmelodylist = function () {
            $(".melodylist").html("");
            $(".melodylist").append($("<li>", {
                text: "Melody",
                "role": "heading",
                "data-role": "divider",
                "class": "ui-bar-f"
            }));
            //$(".melodylist").append($("<li>", {
            //    text: "[" + (getrootbase() + getaccidentalsvalue()) + "/" + getrootoctave() + "]",
            //}));
            for (var i = 0; i < melodylist.length; i++) {
                $(".melodylist").append($("<li>").append($("<a>", {
                    "data-role": "button",
                    "data-icon": "delete",
                    "data-inline": "true",
                    href: "#",
                    text: (melodylist[i].key + melodylist[i].accidental + "/" + melodylist[i].octave),
                    click: (function () {
                        var index = findmelodyindex(melodylist, this.key, this.accidental, this.octave)
                        if (index != -1) {
                            melodylist.splice(index, 1);
                            refreshmelodylist();
                            refresh();
                        }
                    }).bind(melodylist[i])
                })));
            }

            $(".melodylist").trigger("create");
            // $(".melodylist").trigger("refresh");
        }
        var findmelody = function (list, a, b, octa) {
            for (var i = list.length; i--;) {
                if (list[i].key == a && list[i].accidental == b && list[i].octave == octa) {
                    return true;
                }
            }
            return false;
        }
        var findmelodyindex = function (list, a, b, c) {
            for (var i = list.length; i--;) {
                if (list[i].key == a && list[i].accidental == b && list[i].octave == c) {
                    return i;
                }
            }
            return -1;
        }
        var accidentals = [htmlDecode("&#x266e;"), htmlDecode('&#x266d;'), htmlDecode('&#x266F;')];
        for (var i = 0; i < accidentals.length; i++) {
            var input = $("<input >", { class: 'accidentals', type: "radio", name: "radio_accidental", id: "radio_accidental" + i, value: natural == accidentals[i] ? " " : accidentals[i], click: function (s) { refresh(); } });
            var label = $("<label>", { class: 'accidentals', "for": "radio_accidental" + i, text: accidentals[i] });
            $("#accidentals").append(input).append(label);
        }
        $("#accidentals").trigger("refresh");
        var getaccidentalsvalue = function () {
            var lowest = 1000;
            var base = null;
            for (var i = 0 ; i < melodylist.length; i++) {
                var temp = library[melodylist[i].key + melodylist[i].accidental] + melodylist[i].octave * 12;
                if (temp < lowest) {
                    base = melodylist[i].accidental;
                    lowest = temp;
                }
            }
            return base;
        }
        for (var i = 0; i < accidentals.length; i++) {
            var input = $("<input >", {
                class: 'accidentals', type: "radio", name: "keygroup_accidentals", id: "keygroup_accidentals" + i, value: natural == accidentals[i] ? " " : accidentals[i],
                click: (function (s, e) {
                    $("input[name=keygroup_accidentals]").each(function (s, e) {
                        var ischecked = $(e).attr('checked');
                        if (ischecked) {
                            selectedaccidental = $(e).val();
                        }
                    });

                })
            });
            var label = $("<label>", { class: 'accidentals', "for": "keygroup_accidentals" + i, text: accidentals[i] });
            $("#keygroup_accidentals").append(input).append(label);
        }
        $("#keygroup_accidentals").trigger("refresh");

        var octaves = [1, 2, 3, 4, 5, 6, 7];
        var selectedoctave = 4;
        for (var i = 0 ; i < octaves.length ; i++) {
            var input = $("<input >", {
                class: 'accidentals', type: "radio", name: "keygroup_octaves", id: "keygroup_octaves" + i, value: octaves[i],
                click: (function (s, e) {
                    $("input[name=keygroup_octaves]").each(function (s, e) {
                        var ischecked = $(e).attr('checked');
                        if (ischecked) {
                            selectedoctave = $(e).val();
                        }
                    });

                })
            });
            var label = $("<label>", { class: 'accidentals', "for": "keygroup_octaves" + i, text: octaves[i] });
            $("#keygroup_octaves").append(input).append(label);
        }
        $("#keygroup_octaves").trigger("refresh");



    </script>
    <script>
        var chordmaster = new ChordMaster.Reader();
        var octaveoneshifted = 0;
        var octavetwoshifted = 0;
        chordmaster.add_oncomplete(function () {
            // <input type="radio" name="radio-choice-2" id="radio-choice-21" value="choice-1" checked="checked" />
            // <label for="radio-choice-21">Cat</label> 

            for (var i = 0; i < chordmaster._scales.length; i++) {
                var input = $("<input >", {
                    type: "checkbox",
                    name: "scales_radio",
                    id: "scales_radio" + i,
                    value: chordmaster._scales[i],
                    text: chordmaster._scales[i],
                    click: function () { refresh(); }
                });
                var label = $("<label>", { "for": "scales_radio" + i, text: chordmaster._scales[i] });
                $("#scales_").append(input).append(label);
            }
            $("#scales_").trigger("create");

            $("#popupBasic").hide();
        });
        var loader = new widgets.Loader({
            message: "loading: Soundfont..."
        });
        loader.stop();
        $('#cc').live('pageinit', function () {
            if (federatedInfo && federatedInfo.user) {
                if (federatedInfo && federatedInfo.user && federatedInfo.provider == "facebook") {
                    FB.api('/me', function (user) {
                        if (user) {
                            var image = document.getElementById('image');
                            image.src = 'https://graph.facebook.com/' + user.id + '/picture';
                            var name = document.getElementById('name');
                            name.innerHTML = user.name
                        }
                    });
                }
                else if (federatedInfo.provider == "google") {
                    var heading = document.getElementById('name');
                    var image = document.getElementById('image');
                    image.src = federatedInfo.user.image.url;
                    heading.appendChild(image);
                    name.innerHTML = (federatedInfo.user.displayName);
                }
            }

            var selectingscales = false;

            var createOctaveShift = function (spaceselector, name, start, stop, setfunc) {
                for (var i = start; i <= stop ; i++) {
                    var input = $("<input >", {
                        type: "radio",
                        name: name,
                        id: name + i,
                        value: i
                    });
                    var label = $("<label>", { "for": name + i, text: i });
                    $(spaceselector).append(input).append(label);
                    $("input[name=" + name + "]").click(function () {
                        $("input[name=" + name + "]").each(function (s, e) {
                            var ischecked = $(e).attr('checked');
                            if (ischecked) {
                                setfunc($(e).val());
                            }
                        });

                    });
                }
                $(spaceselector).trigger("create");
            };

            $("#popupBasic").show();
            $("#biasflat").click(function () {
                chordmaster.bias = flat;
                chordmaster.renderNotes();
            });
            $("#musicimport").change(function () {

            });
            $("#helplist").listview();
            $("#biassharp").click(function () {
                chordmaster.bias = sharp;
                chordmaster.renderNotes();
            });
            $(".callasp").trigger("collapse");
            $("#toselect").hide();
            $("#selectmorescales").click(function () {
                if (!selectingscales) {
                    $("#toselect").show();
                    $("#selectedscales").hide();
                    selectingscales = true;
                }
                else {
                    $("#toselect").hide();
                    $("#selectedscales").show();
                    selectingscales = false;
                }
                $("#selectscaleslist").html("");

                $("input[name=scales_radio]").each(function (s, e) {
                    var ischecked = $(e).attr('checked');
                    if (ischecked)
                        $("#selectscaleslist").append($("<li>", { text: $(e).val() }));
                });
                $('#selectscaleslist').listview('refresh');
            });
            $("#toggle").toggle(function () {

                $("#melodybuttons").show();
                $('#toggle').html('<H5><a href="#" class="btn">Close</a></H5>');
                $("#melodybuttons").trigger('expand');
                $(".btn").button({ mini: true });
                $(".btn").buttonMarkup({ mini: true });
                //});
            },
            function () {
                $("#melodybuttons").trigger('collapse');
                $('#toggle').html('<H5><a href="#" class="btn">Select melody notes/chord.</a></H5>');
                $("#melodybuttons").hide();
                $(".btn").button({ mini: true });
                $(".btn").buttonMarkup({ mini: true });
            });
            $("#melodybuttons").trigger('collapse');
            $('#toggle').html('<H5><a href="#" class="btn">Select melody notes/chord.</a></H5>');
            $("#melodybuttons").hide();
            $(".btn").button({ mini: true });
            $(".btn").buttonMarkup({ mini: true });

            var setuppopout = function (name, toggle, list, btntext, x, y, movex, movey) {
                $(toggle).toggle(function () {

                    $(list).show();
                    $(toggle).html('<H5><a href="#" class="btn">Close</a></H5>');
                    $(".btn").button({ mini: true });
                    $(".btn").buttonMarkup({ mini: true });
                },
               function () {
                   $(toggle).html('<H5><a href="#" class="btn">' + btntext + '</a></H5>');
                   $(list).hide();
                   $(".btn").button({ mini: true });
                   $(".btn").buttonMarkup({ mini: true });
               });
                $(toggle).html('<H5><a href="#" class="btn">' + btntext + '</a></H5>');
                $(list).hide();
                $(".btn").button({ mini: true });
                $(".btn").buttonMarkup({ mini: true });
                //});
            }
            setuppopout("#helppopout", "#togglehelp", "#helplist", "Help?", -40, 30, 0, 100);
            setuppopout("", "#toggleholder", "#holderlist", "Music Import");
            $("#scale_toggle").toggle(function () {

                $("#scales_list_").show();
                $('#scale_popout').animate({
                    top: 0, right: 30,
                    width: 475
                }, 'slow', function () {
                    $('#scale_toggle').html('<H5><a href="#" class="btn">Close</a></H5>');
                    //  $("#melodybuttons").trigger('expand');
                    $(".btn").button({ mini: true });
                    $(".btn").buttonMarkup({ mini: true });
                });
            },
            function () {
                // $("#melodybuttons").trigger('collapse');
                var width = $('#scale_popout').height();
                $('#scale_popout').animate({
                    top: -30, right: 30,
                    width: 115
                }, 'slow', function () {
                    $('#scale_toggle').html('<H5><a href="#" class="btn">Scales</a></H5>');
                    $("#scales_list_").hide();
                    $(".btn").button({ mini: true });
                    $(".btn").buttonMarkup({ mini: true });
                });
            });
            $(".btn").button();
            $('#scale_popout').animate({
                top: -30, right: 30,
                width: 115
            }, 'slow', function () {
                $('#scale_toggle').html('<H5><a href="#" class="btn">Scales</a></H5>');
                $("#scales_list_").hide();
                $(".btn").button({ mini: true });
                $(".btn").buttonMarkup({ mini: true });
            });
            var midipluginloaded = false;
            var playmelodyhandler = function () {
                if (midipluginloaded == false) {

                    midipluginloaded = true;
                    playmelody();
                }
                else playmelody();
            }
            MIDI.loadPlugin(function () {
                loader.stop();
            });
            $(".playmelodystaff").click(playmelodyhandler);
            var playmelody = function () {
                var notes = getNotes(melodylist, 100);
                MIDI.Player.playRandomNotes(notes);
            }
            var playstaffnoteshandler = function () {
                var scalenotes = chordmaster.get_scalemidinotes();
                var chordnotes = chordmaster.get_chordmidinotes();
                var notes = [];
                for (var i = 0 ; i < chordnotes.length; i++) {
                    notes.push(MIDI.Player.createNote(chordnotes[i], i == 0 ? 100 : 0));
                }
                notes.push(MIDI.Player.createNote(60, 1000, false));
                for (var i = 0 ; i < scalenotes.length; i++) {
                    notes.push(MIDI.Player.createNote(scalenotes[i], 500));
                }
                MIDI.Player.playRandomNotes(notes);
            }
            $(".playstaffnotes").click(playstaffnoteshandler);
            var getNotes = function (list, offset) {
                var notes = [];
                for (var i = 0; i < list.length; i++) {
                    var midinote = library[list[i].key + list[i].accidental] + ((parseInt(list[i].octave) + 1) * 12);
                    notes.push(MIDI.Player.createNote(midinote, i == 0 ? offset : 0));
                }
                return notes;
            }

            chordmaster.parseChordXml();
        });
    </script>
    <script src="Dropfile/trunk/dropfile.js"></script>
</body>
</html>
