using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetOpenAuth.ApplicationBlock;
using DotNetOpenAuth.OAuth2;
using DotNetOpenAuth.OpenId.Extensions.SimpleRegistration;
using DotNetOpenAuth.OpenId.RelyingParty;

public partial class _Default : System.Web.UI.Page
{



    public string ComposerCompanionSiteUrl = "http://composercompanion.mephistowa.com";

    protected void OpenIdAjaxTextBox1_LoggingIn(object sender, OpenIdEventArgs e)
    {
        // Retrieve the email address of the user
        e.Request.AddExtension(new ClaimsRequest
        {
            Email = DemandLevel.Request,
        });
    }

    protected void OpenIdAjaxTextBox1_UnconfirmedPositiveAssertion(object sender, OpenIdEventArgs e)
    {
        // This is where we register extensions that we want to have available in javascript
        // on the browser.
        // OpenIdAjaxTextBox1.RegisterClientScriptExtension<ClaimsResponse>("sreg");
    }

    protected void OpenIdAjaxTextBox1_LoggedIn(object sender, OpenIdEventArgs e)
    {
        string claimedId = e.Response.ClaimedIdentifier;
        // Do something here
    }
}