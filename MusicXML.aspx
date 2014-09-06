<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MusicXML.aspx.cs" Inherits="MusicXML" %>

<!DOCTYPE html X-UA-Compatible: IE=Edge>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="http://code.jquery.com/jquery-1.8.1.min.js"></script>
    <script src="http://code.jquery.com/mobile/1.2.0-rc.2/jquery.mobile-1.2.0-rc.2.min.js"></script>
    <script src="Scripts/MusicXmlReader.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <script>
                $(document).ready(function () {

                    $.ajax({
                        url: '<%= ResolveUrl("~/xml/SchubertF-D899-3-Impromptu-a4.xml") %>',
                        success: function (e, s) {
                            var reader = new chordmaster.MusicXmlReader();
                            reader.parse(e);
                        },
                        error: function (e) {
                        }
                    });
                });
                var parseXml;

                //if (typeof window.DOMParser != "undefined") {
                //    parseXml = function (xmlStr) {
                //        return (new window.DOMParser()).parseFromString(xmlStr, "text/xml");
                //    };
                //} else if (typeof window.ActiveXObject != "undefined" &&
                //       new window.ActiveXObject("Microsoft.XMLDOM")) {
                //    parseXml = function (xmlStr) {
                //        var xmlDoc = new window.ActiveXObject("Microsoft.XMLDOM");
                //        xmlDoc.async = "false";
                //        xmlDoc.loadXML(xmlStr);
                //        return xmlDoc;
                //    };
                //} else {
                //    throw new Error("No XML parser found");
                //}

            </script>
        </div>
    </form>
</body>
</html>
