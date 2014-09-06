<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Score.aspx.cs" Inherits="ComposerCompanion_Score" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Closure/closure/goog/base.js"></script>
    <script type="text/javascript">
        goog.require('goog.debug.Logger');
        goog.require('goog.debug.FancyWindow');
    </script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.9.0/themes/base/jquery-ui.css" />
    <%--    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" /></script>--%>
    <script src="Scripts/jquery-1.8.2.min.js"></script>
    <script src="http://code.jquery.com/ui/1.9.0/jquery-ui.js"></script>
    <script src="Scripts/jquery.mobile-1.2.0-rc.2.min.js"></script>
    <script src="score-library/scorelibrary-deps.js"></script>
    <script src="score-library/scorelibrary.js"></script>
    <script src="score-library/scorecompression.js"></script>
    <script src="score-library/scoreajax.js"></script>
    <script src="score-library/scorediv.js"></script>
    <script src="Scripts/ScoreExt.js"></script>
    <%--    <script src="score-library/scorediv-latest.js"></script>--%>

    <%-- <link rel="stylesheet" href="/score-viewer/css/smoothness/jquery-ui-1.8.20.custom.css" />
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script type="text/javascript" src="score-viewer/js/jquery-ui-1.8.20.custom.min.js"></script>
    <script type="text/javascript" src="score-viewer/js/zip.js/arraybuffer.js"></script>
    <script type="text/javascript" src="score-viewer/js/zip.js/dataview.js"></script>
    <script type="text/javascript" src="score-viewer/js/zip.js/deflate.js"></script>
    <script type="text/javascript" src="score-viewer/js/zip.js/inflate.js"></script>
    <script type="text/javascript" src="score-viewer/js/zip.js/zip.js"></script>
    <script type="text/javascript">zip.workerScriptsPath = 'score-viewer/js/zip.js/';</script>
    <script type="text/javascript" src="http://score-library.googlecode.com/files/scorediv-pv0.0.3.js"></script>--%>
</head>
<body>
    <div class="score-div" style="height: 400px; width: 100%;" musicxml_ref="xml/JCFBach_Menuett.xml">
    </div>

</body>
</html>
