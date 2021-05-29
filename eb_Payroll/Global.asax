<%@ Application Language="C#" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e) 
    {
        // Code that runs on application startup

    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        //// Code that runs when an unhandled error occurs
        //string strError = "Error in: " + Request.Path +
        //    "<br/>Url: " + Request.RawUrl + "<br/><br/>";

        //// Get the exception object for the last error message that occured.
        //Exception ErrorInfo;

        //if (Server.GetLastError().InnerException == null)
        //{
        //    ErrorInfo = Server.GetLastError();
        //}
        //else
        //{
        //    ErrorInfo = Server.GetLastError().InnerException.GetBaseException();
        //}

        //strError += "Error Message: " + ErrorInfo.Message +
        //    "<br/>Error Source: " + ErrorInfo.Source +
        //    "<br/>Error Target Site: " + ErrorInfo.TargetSite +
        //    "<br/><br/>QueryString Data:<br/>-----------------<br/>";

        //// Gathering QueryString information
        //for (int i = 0; i < Context.Request.QueryString.Count; i++)
        //    strError += Context.Request.QueryString.Keys[i] + ":&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + Context.Request.QueryString[i] + "<br/>";
        //strError += "<br/>Post Data:<br/>----------<br/>";

        //// Gathering Post Data information
        //for (int i = 0; i < Context.Request.Form.Count; i++)
        //    strError += Context.Request.Form.Keys[i] + ":&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + Context.Request.Form[i] + "<br/>";
        //strError += "<br/>";

        //if (HttpContext.Current.Session != null)
        //    if (HttpContext.Current.Session["_UserID"] != null) strError += "User ID:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + HttpContext.Current.Session["_UserID"].ToString() + "<br/><br/>";

        //strError += "Exception Stack Trace:<br/>----------------------<br/>" + ErrorInfo.StackTrace +
        //    "<br/><br/>Server Variables:<br/>-----------------<br/>";

        //// Gathering Server Variables information
        //for (int i = 0; i < Context.Request.ServerVariables.Count; i++)
        //    strError += Context.Request.ServerVariables.Keys[i] + ":&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + Context.Request.ServerVariables[i] + "<br/>";
        //strError += "<br/>";

        //Server.ClearError();
        //Response.Clear();
        //clsCommon.RecordException(strError);
    }

    void Session_Start(object sender, EventArgs e) 
    {
        // Code that runs when a new session is started

        //set english as default startup language
        Session["MyCulture"] = "en-US";
    }

    void Session_End(object sender, EventArgs e) 
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }
       
</script>
