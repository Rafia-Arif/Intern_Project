using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data;
using System.Collections;
using System.Security.Principal;

public partial class System_LogoutPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        //Session["UserType"] = null;
        Session.Abandon();
        Response.Redirect("~/System/LoginPage.aspx");

    }


    
}

    